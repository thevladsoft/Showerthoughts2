import QtQuick 2.0;
// import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4 as QtControls
// import QtQuick.Controls 2.1

Item {
    id:root

    width: 250
    height: 300

    property string isp: ""
    property string url: ""
//     property string tiempo_top
    property string imagenurl: ""
    property string thumburl: ""
    
    
    
    Component.onCompleted: {
        plasmoid.backgroundHints = 0;
        request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/about.json',callback_back);
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
            request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/about.json',callback_back);
        }
        onTit_o_imgChanged: {
//             time.restart();
            if(plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = false
            }else{
                thumb.visible = false
                texty.visible = true
            }
        }
        onBack_imgChanged: {
            if (plasmoid.configuration.back_img ) {
                imagen.visible = true
            }else{
                imagen.visible = false
            }
        }
    }
   


   
        QtControls.ScrollView{
            id: scrolly
            width: root.width
            height: root.height
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
            contentItem :tooltip
            QtControls.BusyIndicator{
                id: busy
                width: scrolly.width
                height: scrolly.height
                running: true
                visible: false
            }
            Image{
                    id: imagen
                    fillMode: Image.PreserveAspectFit
                    width: scrolly.width
//                     height: tooltip.height
                    opacity: 0.2
                    source: imagenurl
            }
            Column{
                PlasmaCore.ToolTipArea {
                id: tooltip
                width: root.width-10
                height: root.height+20
                mainText: ""  
                
//             }{
                Image{
                    id: thumb
//                     fillMode: Image.PreserveAspectFit
                    width: root.width
//                     height: tooltip.height
                    opacity: 1.0
                    source: thumburl
                }
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
                        onTriggered: print(mouse.button);if (mouse.button == Qt.LeftButton) {time.restart()} else { Qt.openUrlExternally(root.url);print(root.url)}
                    }
                }
//                 PlasmaCore.Svg{}
                }
            }
        }
    

    
        Timer {
	  id: time
	  running: true
	  triggeredOnStart: true
	  interval: plasmoid.configuration.intervalo * 60 * 1000
	  onTriggered: {
          root.thumburl = ""
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
         busy.visible = true
// 	     root.isp = "Loading...";
         root.isp = "";
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
            root.thumburl = d["data"]["children"][N]["data"].thumbnail
            root.isp = ""
            root.isp = d["data"]["children"][N]["data"].title
            root.isp += "\n      -"+d["data"]["children"][N]["data"].author
            tooltip.mainText = d["data"]["children"][N]["data"].title
            tooltip.subText = "      -"+d["data"]["children"][N]["data"].author
            root.url = "https://www.reddit.com"+d["data"]["children"][N]["data"].permalink
            busy.visible = false
        }else{
            root.isp = "Connection failed\n      -Showerthoughts.plasmoid"
            tooltip.mainText = "Connection failed\n      -Showerthoughts.plasmoid"
            tooltip.subText = "";
            root.url = ""
            root.thumburl = ""
            busy.visible = false
	}
    }
    
    function callback_back(x){
        if (x.responseText) {
          var d = JSON.parse(x.responseText);
	      root.imagenurl = d["data"].header_img
// 	      busy.visible = false
        }else{
	      root.imagenurl = ""
        }
    }
  
}

    

