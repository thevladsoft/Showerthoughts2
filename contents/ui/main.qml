import QtQuick 2.0;
// import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.3 as QtControls
// import QtQuick.Controls 2.1

Item {
    id:root

    width: 250
    height: 300

    property string isp: ""
    property string url: ""
    property string tiempo_top
    
    Component.onCompleted: {
	plasmoid.backgroundHints = 0;
//          Component.addEventListener('ConfigChanged', configChanged);	
    }
    
    Connections {
        target: plasmoid.configuration
        onIntervaloChanged: {
//             print("--..--");
            time.restart();
        }
        onTiempo_topChanged: {
            time.restart();
        }
        onSubredditChanged: {
            time.restart();
        }
    }
   


    Column{
        QtControls.ScrollView{
            id: scrolly
            width: root.width
            height: root.height
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
            contentItem :tooltip
            PlasmaCore.ToolTipArea {
            id: tooltip
             width: root.width-10
             height: root.height+20
             mainText: ""        
             Text {  
                id: texty
        // 		verticalAlignment: Text.AlignVCenter
                style: Text.Outline
                styleColor: "black"
                color: "white"
                wrapMode : Text.WordWrap
                width: tooltip.width
                height: tooltip.height
                text: root.isp 
             }
             MouseArea {
                anchors.fill: texty
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                onClicked: {
                    onTriggered: print(mouse.button);if (mouse.button == Qt.LeftButton) {time.restart()} else { Qt.openUrlExternally(root.url);}
                }
             }
            }
	
    }
    

      
    }
    

    
        Timer {
	  id: time
	  running: true
	  triggeredOnStart: true
	  interval: plasmoid.configuration.intervalo * 60 * 1000
	  onTriggered: {
          request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/top.json?sort=top&t='+plasmoid.configuration.tiempo_top+'&limit=100',callback);
//            texty.anchors.top = scrolly.top
//           print(texty.y+"-.-");
//           print('https://www.reddit.com/r/showerthoughts/top.json?sort=top&t='+plasmoid.configuration.tiempo_top+'&limit=100',plasmoid.configuration.intervalo,interval);
      }
    }

    
    function request(url, callback) {
      //XMLHttpRequest hace cache de la data. Sin embargo, después de un rato esta
      //caduca (creo) y descarga data nueva, asi que todo esta bien
       var xhr = new XMLHttpRequest();
       
       xhr.onreadystatechange = (function f() {
	   if (xhr.readyState == 4) { callback(xhr);}
	   else{
	     root.isp = "Loading...";
	     tooltip.mainText = "Loading...";
	     tooltip.subText = "";
	  }
         });
       xhr.open('GET', url, true);
       xhr.setRequestHeader('User-Agent','/u/thevladsoft');
       XMLHttpRequest.timeout = 15000
       xhr.send();
   }
   
   function callback(x){
        if (x.responseText) {
            var d = JSON.parse(x.responseText);
	    var N=Math.floor(Math.random()*100)
            root.isp = d["data"]["children"][N]["data"].title
	    root.isp += "\n      -"+d["data"]["children"][N]["data"].author
	    tooltip.mainText = d["data"]["children"][N]["data"].title
	    tooltip.subText = "      -"+d["data"]["children"][N]["data"].author
	    root.url = d["data"]["children"][N]["data"].url
        }else{
	    root.isp = "Connection failed\n      -Showerthoughts.plasmoid"
	    tooltip.mainText = "Connection failed\n      -Showerthoughts.plasmoid"
	    tooltip.subText = "";
	    root.url = ""
	}
    }
  
}

    

