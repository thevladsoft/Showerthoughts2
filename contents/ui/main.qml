import QtQuick 2.0;
// import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4 as QtControls
// import QtQuick.Controls 2.1
//TODO Algunos subreddits fallan usando XMLHttpRequest, pero no con curl, que tendría que llamarlo externamente.

//TODO opcion para apuntar a la pagina del link -> Casi, pero no es 100% seguro
//TODO Traducción
//TODO opcion activar o desactivar cache?
//TODO Abrir pagina/permalink en una ventana emergente (como plasmoid comics)
//TODO Opciones con boton derecho para abrir externamente (ya) para recargar (ya) y para abrir la ventana emergente.
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
    property bool firsttry: false
//     property bool thumb_Error: false
//     property bool imagen_Error: false
    
//     signal imagen_Error()
//     signal thumb_Error()
//     onThumb_Error: {root.thumburl = root.imagenurl}
//     onImagen_Error: {root.imagenurl = "sad.png"}
    
    Component.onCompleted: {
        plasmoid.backgroundHints = 0;
//         request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/about.json',callback_back);
        if(plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = false
                root.fraccion = 1.
        }else if (plasmoid.configuration.tit_o_img ){
                thumb.visible = true
                texty.visible = true
                root.fraccion = 0.7
        }else{
                thumb.visible = false
                texty.visible = true
                root.fraccion = 0.
        }
//          Component.addEventListener('ConfigChanged', configChanged);	
        plasmoid.setAction('reload', i18n('Reload'), 'system-reboot');
        plasmoid.setAction('openexternall', i18n('Open on external application'), 'system-run');
    }
    function action_reload(){
        time.restart()
    }
    function action_openexternall(){
        if (plasmoid.configuration.middledirect){
            Qt.openUrlExternally(root.realurl);//print(plasmoid.configuration.middledirect+"**//**")
        }else{
            Qt.openUrlExternally(root.url);//print(root.url+"..--..")
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
//             root.imagenurl = ""
//             request('https://www.reddit.com/r/'+plasmoid.configuration.subreddit+'/about.json',callback_back);
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
        }
        onTryurlChanged: {
            busy.visible = true
            if (plasmoid.configuration.tryurl){
                root.firsttry = true;thumb.source = root.realurl
            }
            else{
                thumb.source = root.thumburl
            }
        }
        
        onTryhighChanged: {
            busy.visible = true
            if (plasmoid.configuration.tryhigh){//intenta usa un thumbnail de mayor calidad
                root.thumburl = root.thumbhighurl
            }else{
                root.thumburl = root.thumblowurl
            }
            thumb.source = root.thumburl
        }
        onTrylowChanged: {
            busy.visible = true
            if (plasmoid.configuration.tryhigh){//intenta usa un thumbnail de mayor calidad
                root.thumburl = root.thumbhighurl
            }else{
                root.thumburl = root.thumblowurl
            }
            thumb.source = root.thumburl
        }
        
        onBack_imgChanged: {
            if (plasmoid.configuration.back_img ) {
                imagen.visible = true
            }else{
                imagen.visible = false
            }
        }
        onMiddledirectChanged: {}
    }
    
//      Connections {
//          target: thumb
//          onStatusChanged: if (thumb.status == Image.Error) {imagenurl = "sad.png"}
//      }
       
//         onThumb_ErrorChanged: {
// //             root.firsttry
//             if (root.thumb_Error) {
// //                 if (firsttry){
//                     
// //                 root.thumburl = root.imagenurl;
//                 thumb.source = root.imagenurl;
// //                 root.thumb_Error = false
//             }
//             
//         }
//         onImagen_ErrorChanged: {if (root.imagen_Error) {root.imagenurl = "sad.png"}}

   
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
                    height: scrolly.height
//                     height: tooltip.height
                    opacity: 0.2
                    source: root.imagenurl
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
                    Image{
                        id: thumb
                        fillMode: Image.PreserveAspectFit
                        width: scrolly.width
                         height: scrolly.height*fraccion
                        opacity: 1.0
//                         source: root.thumburl
                        onStatusChanged: {
                            if (thumb.status == Image.Error || thumb.status == Image.Null) {//print(thumb.status,root.firsttry)
                                if (root.firsttry){
                                    root.firsttry = false
                                    thumb.source = root.thumburl
                                    
                                }else{
                                    thumb.source = root.imagenurl;/*root.thumb_Error = true;*/
                                }
                            }
                            if (thumb.status == Image.Ready || thumb.status == Image.Error || thumb.status == Image.Null) {busy.visible = false}
                            
                            //print(thumb.status+"*-*-*",root.thumb_Error)
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
//                         var a = "a,b,,c,"
//                         var b = a.split(",")
//                         print("-.-"+b.filter(function lambda(x){ return x > ""}),a.length,b.filter(function lambda(x){ return x > ""}).length,typeof(a),typeof(b),b[2],b[2]>"");
                        onTriggered: {
                            if (mouse.button == Qt.LeftButton) {
                                time.restart()
                            } else if (mouse.button == Qt.MidButton){ 
                                action_openexternall()
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
//            texty.anchors.top = scrolly.top
//           print(texty.y+"-.-");
//           print('https://www.reddit.com/r/showerthoughts/top.json?sort=top&t='+plasmoid.configuration.tiempo_top+'&limit=100',plasmoid.configuration.intervalo,interval);
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
         thumb.source = ""
	  }
         });
       xhr.open('GET', url, true);
       xhr.setRequestHeader('User-Agent','/u/thevladsoft');
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
//        xhr.setRequestHeader('User-Agent','/u/thevladsoft');
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
              thumb.source = "sad.png"
              busy.visible = false
          }else if (d["error"] == "403"){
              root.isp = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
              tooltip.mainText = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
//               root.thumburl = "sad.png"
              thumb.source = "sad.png"
              busy.visible = false
          }else{
            var N=Math.floor(Math.random()*d.data.children.length)
            root.firsttry = false
//             root.thumb_Error = false
//             print (d["error"],d.data.children.length)
//              print("**--**"+d.data.children[N].data.thumbnail+d["data"]["children"][N]["data"]["preview"]["images"][0]["source"].url,N,d.data.children.length)
//             print(d["data"]["children"][N]["data"].thumbnail)
            if (d["data"]["children"][N]["data"]["preview"]){
                root.thumbhighurl = d["data"]["children"][N]["data"]["preview"]["images"][0]["source"].url
            }else{
                root.thumbhighurl = d["data"]["children"][N]["data"].thumbnail
            }
            root.thumblowurl = d["data"]["children"][N]["data"].thumbnail
            
            if (plasmoid.configuration.tryhigh){//intenta usa un thumbnail de mayor calidad
                root.thumburl = root.thumbhighurl
            }else{
                root.thumburl = root.thumblowurl
            }
            
            root.isp = d["data"]["children"][N]["data"].title
            root.isp += "\n      -/u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            tooltip.mainText = d["data"]["children"][N]["data"].title
            tooltip.subText = "      /u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            root.url = "https://www.reddit.com"+d["data"]["children"][N]["data"].permalink
            root.realurl = d["data"]["children"][N]["data"].url
            if (plasmoid.configuration.tryurl){
                root.firsttry = true;thumb.source = root.realurl/*root.thumburl = d["data"]["children"][N]["data"].url;*/
            }
//             else if (d["data"]["children"][N]["data"].thumbnail == "self") { root.thumburl = root.imagenurl}
            else{
                thumb.source = root.thumburl/*root.thumburl = d["data"]["children"][N]["data"].thumbnail*/
            }
//             print(plasmoid.configuration.tit_o_img)
            if (!plasmoid.configuration.tit_o_img && !plasmoid.configuration.tit_e_img) { busy.visible = false}
//             print(root.thumburl,root.realurl,thumb.source,"**--**",N)
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

    

