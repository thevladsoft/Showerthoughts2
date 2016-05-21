import QtQuick 1.0;
import org.kde.plasma.core 0.1 as PlasmaCore

Item {
    id:root

    width: 250
    height: 300
//     property bool backgroundHints:true
// onClicked: statusSource.restart()
    property string isp: ""
    property int running: 1
    
//     Component.onClicked: {
// 	  statusSource.restart()
//       
//     }
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
		text: root.isp 
	}
	
    }
    MouseArea {
        anchors.fill: parent
        //Al hacer el interval cero se apaga, al hacerlo >0 se vuelve a prender
        //Habra una mejor forma de hacer reset?
        onClicked: {
 	  root.running=0
 	  root.running=1
	}
    }

    
    PlasmaCore.DataSource {
        id: statusSource
        engine: 'executable'
        //Usa el top 100, por eso necesita un número entre 0 y 99
	//Esto se podría hacer más facilmente en qml puro, pero no se como.
	connectedSources: [ 'curl -s --connect-timeout 15 -A "/u/thevladsoft" "https://www.reddit.com/r/showerthoughts/top.json?sort=top&t=week&limit=100" | python -c \'import sys, random, json, textwrap; randnum = random.randint(0,99); response = json.load(sys.stdin)["data"]["children"][randnum]["data"];\
	print( textwrap.fill(response["title"],40) + "\\n    -" + response["author"] );\' 2>/dev/null || echo "No connection" ' ]
        //Trato de conectarme a la fuente, en este caso, ejecutar la linea anterior
        onSourceConnected: {
	    root.isp = "Loading..."
	    tooltip.mainText = "Loading..."
	}
        //La data cambio
        onNewData: {
            root.isp = data.stdout;
	    //Si no dio error, pone el nombre del autor en el subtext del tooltip
	    if (data.stdout.split("\n").length > 2){
	      //Lo separa en lines, agarra todo menos las dos ultimas linea
	      //(La ultima está en blanco), y las vuelve a unir.
		tooltip.mainText = data.stdout.split("\n").slice(0,data.stdout.split("\n").length-2).join(" ");
		tooltip.subText = data.stdout.split("\n")[0,data.stdout.split("\n").length-2];
	    }else{
	        tooltip.mainText = data.stdout;
		tooltip.subText = "";
	    }
        }
        //cada 25 min
        interval: 25 * 60 * 1000 * root.running
    }
    
    PlasmaCore.ToolTip {
      id: tooltip
      target: root
      mainText: ""
      
    }
}


