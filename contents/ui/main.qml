import QtQuick 1.0;
import org.kde.plasma.core 0.1 as PlasmaCore

Item {
    id:root

    width: 250
    height: 300

    property string isp: ""
    property string url: ""
    
    Component.onCompleted: {
	plasmoid.backgroundHints = 0;
//         plasmoid.addEventListener('ConfigChanged', configChanged);	
    }
   


    Column{
        
        Text {  
// 		verticalAlignment: Text.AlignVCenter
		style: Text.Outline
		styleColor: "black"
		color: "white"
		wrapMode : Text.WordWrap
		width: root.width
		text: root.isp 
	}
	
    }
    
    PlasmaCore.ToolTip {
      id: tooltip
      target: root
      mainText: ""
      
    }
    
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        onClicked: {
	  onTriggered: print(mouse.button);if (mouse.button == Qt.LeftButton) {time.restart()} else { Qt.openUrlExternally(root.url);}
	}
    }
    
        Timer {
	  id: time
	  running: true
	  triggeredOnStart: true
	  interval: 15 * 60 * 1000
	  onTriggered: request('https://www.reddit.com/r/showerthoughts/top.json?sort=top&t=week&limit=100',callback)
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
	    N=Math.floor(Math.random()*100)
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

    

