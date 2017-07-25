import QtQuick 2.0;
// import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4 as QtControls

import QtWebKit 3.0
import QtQuick.Dialogs 1.2
// import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1 as QtLayouts
// import QtQuick.Controls 2.1
//TODO Algunas imagenes fallan por no estar logeado. La solucion seria incluir usuario y contraseña en el encabesado
//De momento no me interesa.

//TODO Traducción y ayuda
//TODO Opciones con boton derecho para abrir externamente (ya) para recargar (ya) y para abrir la ventana emergente(?).
//TODO cambiar entre top,new, etc?
Item {
    id:root

    width: 250
//     height: 300

    property string isp: ""
    property string url: ""
    property string realurl: ""
//     property string tiempo_top
    property string imagenurl: ""
    property string thumburl: ""
    property string thumblowurl: ""
    property string thumbhighurl: ""
    property string cursubreddit: ""
    property real fraccion: 0
//     property bool firsttry: false
//     property bool thumb_Error: false
//     property bool imagen_Error: false
    
//     signal imagen_Error()
//     signal thumb_Error()
//     onThumb_Error: {root.thumburl = root.imagenurl}
//     onImagen_Error: {root.imagenurl = "sad.png"}
// QtControls.ApplicationWindow {
//     id: root2
//     width: 300; height: 300
//     visible: true
// //     style: ApplicationWindowStyle {
// //         background: null
// //     }
//     Text {
//         anchors.centerIn: parent
//         text: qsTr("Hello World.")
//     }
//     PlasmaComponents.Button {
//         anchors.centerIn: parent
//         text: qsTr("Click me")
//         style: ButtonStyle {
//         background: Rectangle {
//             implicitWidth: 100
//             implicitHeight: 25
//             border.width: control.activeFocus ? 2 : 1
//             border.color: "#888"
//             radius: 4
//             opacity: 0.2
//             gradient: Gradient {
//                 GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
//                 GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
//             }
//         }
//         }
//     }
// }
    Dialog{
        id: dialogo
        visible: false
        width: 800
        height: 600
        modality:  Qt.NonModal
        title: root.isp
        standardButtons : StandardButton.Close|StandardButton.Reset
        onReset: {
            if(plasmoid.configuration.middledirect){
                web.url= root.realurl
            }else{
                web.url= root.url
            }
        }
        QtLayouts.ColumnLayout{
            QtControls.ScrollView{
                id: webscrolly
                width: dialogo.width-20
                height: dialogo.height-45-progres.height
    //             anchors.horizontalCenter: dialogo.horizontalCenter
                anchors.top: dialogo.top+20
                anchors.left: dialogo.left
    //             anchors.topMargin: 0
    //             anchors.bottomMargin: 55
    //             anchors.leftMargin: 0
    //             anchors.rightMargin: 5
                contentItem :web
                
                WebView {
                    id: web
                    anchors.fill: parent
                    url: ""
                    visible:true
                }
            }
            QtControls.ProgressBar {
                    id: progres
                    minimumValue: 0
                    maximumValue: 100
                    height: 5
                    width: dialogo.width-20
                    value: web.loadProgress
                    anchors.top: webscrolly.bottom
            }
        }
        
        onVisibleChanged: {
            if(!dialogo.visible){
                web.url=""
            }
            else {
                if(plasmoid.configuration.middledirect){
                    web.url= root.realurl
                }else{
                    web.url= root.url
                }
            }
        }
    }
    
    Component.onCompleted: {
        plasmoid.backgroundHints = 0;
//         request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/about.json',callback_back);
        if(plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = false
                root.fraccion = 1.
        }else if (plasmoid.configuration.tit_e_img ){
                thumb.visible = true
                texty.visible = true
                root.fraccion = 0.7
        }else{
                thumb.visible = false
                texty.visible = true
                root.fraccion = 0.
        }
        if(thumb.visible){busy.visible = true;load_thumb()}
//         print("***-**"+plasmoid.configuration.back_img+imagen.visible+plasmoid.configuration.tit_o_img)
        if (plasmoid.configuration.back_img) {
            imagen.source = root.imagenurl
        }else{
            imagen.source = ""
        }
//         if(plasmoid.configuration.middledirect){
//             web.url= root.realurl
//         }else{
//             web.url= root.url
//         }
//          Component.addEventListener('ConfigChanged', configChanged);	
        plasmoid.setAction('reload', i18n('New post'), 'system-reboot');
        plasmoid.setAction('openexternall', i18n('Open on external application'), 'system-run');
        plasmoid.setAction('opendialog', i18n('Open on a window'), 'system-run');
        
    }
    function action_reload(){
        time.restart()
    }
    function action_openexternall(){
        if (plasmoid.configuration.middledirect){
            Qt.openUrlExternally(root.realurl);
        }else{
            Qt.openUrlExternally(root.url);
        }
    }
    function action_opendialog(){
        dialogo.visible = true
        
    }
    
    function load_thumb(){
        if (plasmoid.configuration.tryhigh){
            if(root.thumbhighurl && root.thumbhighurl != "self"){
                thumb.source = root.thumbhighurl
            }else{
                thumb.source = root.imagenurl
            }
        }else if (plasmoid.configuration.trylow){
            if(root.thumbhighurl && root.thumbhighurl != "self"){
                thumb.source = root.thumblowurl
            }else{
                thumb.source = root.imagenurl
            }
        }else{
//             root.firsttry = true
            thumb.source = root.realurl
        }
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
        onTit_o_imgChanged: {
//             time.restart();
            if(plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = false
                root.fraccion = 1.
            }else if (plasmoid.configuration.tit_e_img ){
                thumb.visible = true
                texty.visible = true
                root.fraccion = 0.7
            }else{
                thumb.visible = false
                texty.visible = true
                root.fraccion = 0.
            }
        }
        onTit_e_imgChanged: {
//             time.restart();
            if(plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = false
                root.fraccion = 1.
            }else if (plasmoid.configuration.tit_e_img ){
                thumb.visible = true
                texty.visible = true
                root.fraccion = 0.7
            }else{
                thumb.visible = false
                texty.visible = true
                root.fraccion = 0.
            }
//             if(thumb.visible){busy.visible = true;load_thumb()}
        }
        onTryurlChanged: {
            if(thumb.visible){busy.visible = true;load_thumb()}
//             if (plasmoid.configuration.tryurl){
//                 root.firsttry = true;thumb.source = root.realurl
//             }
//             else{
//                 thumb.source = root.thumburl
//             }
        }
        
        onTryhighChanged: {
            if(thumb.visible){busy.visible = true;load_thumb()}
//             if (plasmoid.configuration.tryhigh){//intenta usar un thumbnail de mayor calidad
//                 root.thumburl = root.thumbhighurl
//             }else{
//                 root.thumburl = root.thumblowurl
//             }
//             thumb.source = root.thumburl
        }
        onTrylowChanged: {
            
            if(thumb.visible){busy.visible = true;load_thumb()}
//             if (plasmoid.configuration.tryhigh){//intenta usar un thumbnail de mayor calidad
//                 root.thumburl = root.thumbhighurl
//             }else{
//                 root.thumburl = root.thumblowurl
//             }
//             thumb.source = root.thumburl
        }
        
        onBack_imgChanged: {
            if (plasmoid.configuration.back_img ) {
                imagen.visible = true
                imagen.source = root.imagenurl
            }else{
                imagen.visible = false
                imagen.source = ""
            }
        }
        onMiddledirectChanged: {
//             print(plasmoid.configuration.middledirect,root.realurl,root.url)
//             if(plasmoid.configuration.middledirect){
//                 web.url= root.realurl
//             }else{
//                 web.url= root.url
//             }
        }
        onMiddledialogChanged: {
        }
    }
    
    onImagenurlChanged:{
        if (plasmoid.configuration.back_img && imagen.visible) {
            imagen.source = root.imagenurl
        }else{
            imagen.source = ""
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
                    cache: false
                    fillMode: Image.PreserveAspectFit
                    width: scrolly.width
                    height: scrolly.height
//                     height: tooltip.height
                    opacity: 0.2
//                     source: root.imagenurl
//                    onStatusChanged: {if (imagen.status == Image.Error) {root.imagen_Error = true;}}//que?
            }
//             Column{
            PlasmaCore.ToolTipArea {
                 id: tooltip
                 width: root.width-10
                 height: root.height+20
                 mainText: ""  
                 Column{
                    id: col
                    AnimatedImage{
                        id: thumb
//                         paused: true
                        playing: false
                        cache: false
                        fillMode: Image.PreserveAspectFit
                        width: scrolly.width
                         height: scrolly.height*fraccion
                        opacity: 1.0
//                         source: root.thumburl
                        onVisibleChanged:{
                            if(thumb.visible){busy.visible = true;load_thumb()}
                        }
                        onStatusChanged: {
//                             if (thumb.status == Image.Error || thumb.status == Image.Null) {//print(thumb.status,root.firsttry)
//                                 if (root.firsttry){
//                                     root.firsttry = false
//                                     thumb.source = root.thumburl
//                                     
//                                 }else{
//                                     thumb.source = root.imagenurl;/*root.thumb_Error = true;*/
//                                 }
//                             }
                            if (thumb.status == Image.Ready || thumb.status == Image.Error || thumb.status == Image.Null) {
                                if(thumb.status == Image.Error){
                                    if(thumb.source == root.realurl){//print("a----")
                                        if(root.thumbhighurl){
                                            thumb.source = root.thumbhighurl
                                        }else{
                                            thumb.source = root.imagenurl
                                        }
                                    }else if(thumb.source == root.thumbhighurl){//print("b-----"+root.thumblowurl)
                                        if(root.thumblowurl){
                                            thumb.source = root.thumblowurl
                                        }else{
                                            thumb.source = root.imagenurl
                                        }
                                    }else{print("c")
                                        thumb.source = root.imagenurl
                                    }
                                }
                                busy.visible = false
                            }
//                             playing = true
//                             paused = false
                        }
                    }
                    Text {  
                        id: texty
                // 		verticalAlignment: Text.AlignVCenter
                        style: Text.Outline
                        styleColor: "black"
                        color: "white"
                        wrapMode : Text.WordWrap
                        width: tooltip.width
                        height: tooltip.height*(1.-fraccion)
                        text: root.isp 
                    }
                 }
                 MouseArea {
                    anchors.fill: col
                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                    onClicked: {
                        onTriggered: {
                            print(thumb.source)
                            if (mouse.button == Qt.LeftButton) {
                                time.restart()
                            } else if (mouse.button == Qt.MidButton){ 
//                                 action_openexternall()
                                if (plasmoid.configuration.middledialog){
                                    action_opendialog()
                                }else{
                                    action_openexternall()
                                }
                            }
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
//           root.thumburl = ""
          thumb.source = ""
          root.imagenurl = ""
          var arreddit = plasmoid.configuration.subreddit.split(",").filter(function lambda(x){ return x > ""})
          if (arreddit.length) {
//             print(plasmoid.configuration.subreddit.split(",").filter(function lambda(x){ return x > ""}).length)
              root.cursubreddit = arreddit[Math.floor(Math.random()*arreddit.length)]
          }else{ 
              root.cursubreddit = "showerthoughts"
          }
          request('http://www.reddit.com/r/'+root.cursubreddit+'/top.json?sort=top&t='+plasmoid.configuration.tiempo_top+'&limit=100',callback);
          request('https://www.reddit.com/r/'+root.cursubreddit+'/about.json',callback_back);
      }
    }

    
    function request(url, callback) {
      //XMLHttpRequest hace cache de la data. Sin embargo, después de un rato esta
      //caduca (creo) y descarga data nueva, asi que todo esta bien
       var xhr = new XMLHttpRequest();
//        xhr.responseType = "document"
       
       xhr.onreadystatechange = (function f() {
	   if (xhr.readyState == 4) { callback(xhr);/*print("####"+xhr.status)*/}
	   else{
         busy.visible = true
// 	     root.isp = "Loading...";
         root.isp = "";
	     tooltip.mainText = "Loading...";
	     tooltip.subText = "";
//          thumb.source = ""
	  }
         });
       xhr.open('GET', url, true);
       xhr.setRequestHeader('User-Agent','/u/thevladsoft');
//        xhr.setRequestHeader('User-Agent','Mozilla/5.0 (X11; Linux i686 on x86_64; rv:54.0) Gecko/20100101 Firefox/54.0');
//        xhr.setRequestHeader('Accept','application/json');
       XMLHttpRequest.timeout = 15000
       xhr.send();
   }
   
   function request2(url, callback) {
       var xhr = new XMLHttpRequest();
       
       xhr.onreadystatechange = (function f() {
            if (xhr.readyState == 4) { callback(xhr);}
            else{
                root.imagenurl = ""
            }
       });
       xhr.open('GET', url, true);
       xhr.setRequestHeader('User-Agent','Showerthoughts.plasmoid');
       XMLHttpRequest.timeout = 15000
       xhr.send();
   }
   
   function callback(x){
        if (x.responseText) {
          var d = JSON.parse(x.responseText);
          if  (d["error"] == "404"){
              root.isp = "Subreddit not found\n      -Showerthoughts.plasmoid"
              tooltip.mainText = "Subreddit not found\n      -Showerthoughts.plasmoid"
//               root.thumburl = "sad.png"
//               thumb.source = "sad.png"
              root.thumbhighurl = "sad.png"
              root.thumblowurl = "sad.png"
              root.realurl = ""
              busy.visible = false
              web.url= ""
          }else if (d["error"] == "403"){
              root.isp = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
              tooltip.mainText = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
//               thumb.source = "sad.png"
              root.thumbhighurl = "sad.png"
              root.thumblowurl = "sad.png"
              root.realurl = ""
              busy.visible = false
              web.url= ""
          }else{
            var N=Math.floor(Math.random()*d.data.children.length)
//             root.firsttry = false
            if (d["data"]["children"][N]["data"]["preview"]){
                root.thumbhighurl = d["data"]["children"][N]["data"]["preview"]["images"][0]["source"].url
            }else{
                root.thumbhighurl = d["data"]["children"][N]["data"].thumbnail
            }
            root.thumblowurl = d["data"]["children"][N]["data"].thumbnail
            
//             if (plasmoid.configuration.tryhigh){//intenta usa un thumbnail de mayor calidad
//                 root.thumburl = root.thumbhighurl
//             }else{
//                 root.thumburl = root.thumblowurl
//             }
            
            root.isp = d["data"]["children"][N]["data"].title
            root.isp += "\n      -/u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            tooltip.mainText = d["data"]["children"][N]["data"].title
            tooltip.subText = "      /u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            root.url = "https://www.reddit.com"+d["data"]["children"][N]["data"].permalink
            root.realurl = d["data"]["children"][N]["data"].url
//             if (plasmoid.configuration.tryurl){
// //                 root.firsttry = true;thumb.source = root.realurl
//             }
//             else{
// //                 thumb.source = root.thumburl
//             }
            if (!plasmoid.configuration.tit_o_img && !plasmoid.configuration.tit_e_img) { busy.visible = false}
            if(thumb.visible)load_thumb()
            if(!dialogo.visible){
                web.url=""
            }
            else {
                if(plasmoid.configuration.middledirect){
                    web.url= root.realurl
                }else{
                    web.url= root.url
                }
            }
          }
        }else{
            root.isp = "Connection failed\n      -Showerthoughts.plasmoid"
            tooltip.mainText = "Connection failed\n      -Showerthoughts.plasmoid"
            tooltip.subText = "";
            root.url = ""
            root.realurl = ""
//             root.thumburl = ""
            thumb.source = ""
            busy.visible = false
            web.url= ""
        }
    }
    
    function callback_back(x){
        if (x.responseText) {
          var d = JSON.parse(x.responseText);
//           root.imagen_Error = false
	      root.imagenurl = d["data"].header_img
// 	      if (root.imagen_Error) {root.imagenurl = "sad.png"}
// 	      busy.visible = false
        }else{
	      root.imagenurl = ""
        }
//         onImagen_Error: {root.imagenurl = "sad.png"}
    }
  
}

    

