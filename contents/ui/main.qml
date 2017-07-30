/*
 *   Copyright 2017 thevladsoft <thevladsoft2@gmail.com>
 *
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 */

import QtQuick 2.0;
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4 as QtControls

import QtWebKit 3.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Controls.Styles 1.4
//TODO Algunas imagenes fallan por no estar logeado. La solucion seria incluir usuario y contraseña en el encabesado
//De momento no me interesa.

Item {
    id:root

    width: 250

    property string isp: ""
    property string url: ""
    property string realurl: ""
    property string imagenurl: ""
    property string thumburl: ""
    property string thumblowurl: ""
    property string thumbhighurl: ""
    property string cursubreddit: ""
    property real fraccion: 0

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
            QtControls.ProgressBar {
                    id: progres
                    minimumValue: 0
                    maximumValue: 100
                    height: 5
                    width: webscrolly.width
                    value: web.loadProgress
                    anchors.top: dialogo.top
                    style: ProgressBarStyle {
                                background: Rectangle {
                                    radius: 100
                                    color: "#ececec"
                                    border.color: "lightgray"
                                    border.width: 1
                                    implicitWidth: 200
                                    implicitHeight: 5
                                }
                                progress: Rectangle {
                                    color: "#4da4ac"
                                    border.color: "lightgray"
                                    radius: 100
                                }
                           }
            }
            QtControls.ScrollView{
                id: webscrolly
                width: dialogo.width-20
                height: dialogo.height-progres.height-55
                anchors.top: progres.bottom
                anchors.left: dialogo.left
                contentItem :web
                
                WebView {
                    id: web
                    anchors.fill: parent
                    url: ""
                    visible:true
                }
            }
            
        }
        
        onVisibleChanged: {
            if(!dialogo.visible){
                web.stop()
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
        plasmoid.backgroundHints = plasmoid.configuration.transback ? 0 : 1;
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
        if (plasmoid.configuration.back_img) {
            imagen.source = root.imagenurl
        }else{
            imagen.source = ""
        }
        plasmoid.setAction('reload', i18n('New post'), 'system-reboot');
        plasmoid.setAction('openexternallurl', i18n('Open reddit post on external application'), 'system-run');
        plasmoid.setAction('openexternallrealurl', i18n('Open linked url on external application'), 'system-run');
        plasmoid.setAction('opendialogurl', i18n('Open reddit post on a window'), 'system-run');
        plasmoid.setAction('opendialogrealurl', i18n('Open linked url on a window'), 'system-run');
        
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
    function action_openexternallurl(){
        Qt.openUrlExternally(root.url);
    }
    function action_openexternallrealurl(){
        Qt.openUrlExternally(root.realurl);
    }
    
    function action_opendialog(){
        dialogo.visible = true
    }
    function action_opendialogurl(){
        dialogo.visible = true
        web.url= root.url
    }
    function action_opendialogrealurl(){
        dialogo.visible = true
        web.url= root.realurl
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
            thumb.source = root.realurl
        }
    }
    
    Connections {
        target: plasmoid.configuration
        onIntervaloChanged: {
            time.restart();
        }
        onTiempo_topChanged: {
            time.restart();
        }
        onReally_topChanged: {
            time.restart();
        }
        onSubredditChanged: {
            time.restart();
        }
        onTit_no_imgChanged: {
        }
        onTit_o_imgChanged: {
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
            if(thumb.visible){busy.visible = true;load_thumb()}
        }
        
        onTryhighChanged: {
            if(thumb.visible){busy.visible = true;load_thumb()}
        }
        onTrylowChanged: {
            
            if(thumb.visible){busy.visible = true;load_thumb()}
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
        onTransbackChanged: {
            plasmoid.backgroundHints = plasmoid.configuration.transback ? 0 : 1;
        }
        onMiddledirectChanged: {
        }
        onMiddledialogChanged: {
        }
        
        onMiddlemouseChanged: {
        }
        onLeftmouseChanged: {
        }
        onNsfwChanged: {
            time.restart()
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
                    opacity: 0.2
            }
            PlasmaCore.ToolTipArea {
                 id: tooltip
                 width: root.width-10
                 height: root.height+20
                 mainText: ""  
                 Column{
                    id: col
                    AnimatedImage{
                        id: thumb
                        playing: false
                        cache: false
                        fillMode: Image.PreserveAspectFit
                        width: scrolly.width
                         height: scrolly.height*fraccion
                        opacity: 1.0
                        onVisibleChanged:{
                            if(thumb.visible){busy.visible = true;load_thumb()}
                        }
                        onStatusChanged: {
                            if (thumb.status == Image.Ready || thumb.status == Image.Error || thumb.status == Image.Null) {
                                if(thumb.status == Image.Error){
                                    if(thumb.source == root.realurl){
                                        if(root.thumbhighurl){
                                            thumb.source = root.thumbhighurl
                                        }else{
                                            thumb.source = root.imagenurl
                                        }
                                    }else if(thumb.source == root.thumbhighurl){
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
                        }
                    }
                    Text {  
                        id: texty
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
                            if (mouse.button == Qt.LeftButton && plasmoid.configuration.leftmouse) {
                                time.restart()
                            } else if (mouse.button == Qt.MidButton && plasmoid.configuration.middlemouse){ 
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
          thumb.source = ""
          root.imagenurl = ""
          var arreddit = plasmoid.configuration.subreddit.split(",").filter(function lambda(x){ return x > ""})
          if (arreddit.length) {
              root.cursubreddit = arreddit[Math.floor(Math.random()*arreddit.length)]
          }else{ 
              root.cursubreddit = "showerthoughts"
          }
          request('http://www.reddit.com/r/'+root.cursubreddit+'/'+plasmoid.configuration.really_top+'.json?sort=top&t='+plasmoid.configuration.tiempo_top+'&limit=100',callback);
          request('https://www.reddit.com/r/'+root.cursubreddit+'/about.json',callback_back);
      }
    }

    
    function request(url, callback) {
       var xhr = new XMLHttpRequest();
       
       xhr.onreadystatechange = (function f() {
	   if (xhr.readyState == 4) { callback(xhr);/*print("####"+xhr.status)*/}
	   else{
         busy.visible = true
         root.isp = "";
	     tooltip.mainText = "Loading...";
	     tooltip.subText = "";
	  }
         });
       xhr.open('GET', url, true);
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
          if  (d["error"] == "404" || d["data"]["children"] == ""){
              root.isp = "Subreddit not found\n      -Showerthoughts.plasmoid"
              tooltip.mainText = "Subreddit not found\n      -Showerthoughts.plasmoid"
              root.thumbhighurl = "./sad.png"
              root.thumblowurl = "./sad.png"
              root.realurl = ""
              root.url = ""
              busy.visible = false
              web.url= ""
          }else if (d["error"] == "403"){
              root.isp = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
              tooltip.mainText = "Subreddit is private, and I don't know how to enter :(\n      -Showerthoughts.plasmoid"
              root.thumbhighurl = "./sad.png"
              root.thumblowurl = "./sad.png"
              root.realurl = ""
              root.url = ""
              busy.visible = false
              web.url= ""
          }else{
              if (!plasmoid.configuration.nsfw){
                for (var i=0;i<d.data.children.length;i++){
                    if (d.data.children[i]["data"].over_18){delete d.data.children[i]}
                }
              }
            var N=Math.floor(Math.random()*d.data.children.length)
            if (d["data"]["children"][N]["data"]["preview"]){
                root.thumbhighurl = d["data"]["children"][N]["data"]["preview"]["images"][0]["source"].url
            }else{
                root.thumbhighurl = d["data"]["children"][N]["data"].thumbnail
            }
            root.thumblowurl = d["data"]["children"][N]["data"].thumbnail
            
            root.isp = d["data"]["children"][N]["data"].title
            root.isp += "\n      -/u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            tooltip.mainText = d["data"]["children"][N]["data"].title
            tooltip.subText = "      /u/"+d["data"]["children"][N]["data"].author+"\n            /r/"+root.cursubreddit
            root.url = "https://www.reddit.com"+d["data"]["children"][N]["data"].permalink
            root.realurl = d["data"]["children"][N]["data"].url
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
            root.thumbhighurl = "./sad.png"
            root.thumblowurl = "./sad.png"
            if(thumb.visible)load_thumb()
            root.realurl = ""
            root.url = ""
            busy.visible = false
            web.url= ""
        }
    }
    
    function callback_back(x){
        if (x.responseText) {
          var d = JSON.parse(x.responseText);
	      root.imagenurl = d["data"].header_img
        }else{
	      root.imagenurl = ""
        }
    }
  
}

    

