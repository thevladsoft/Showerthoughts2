/*
 *   Copyright 2015 Marco Martin <mart@kde.org>
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
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.0
// import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
// import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Controls 1.0 as QtControls

Item {
    id: rootconf
    
    property alias cfg_tiempo_top: tiempo_cfg.fecha
    property alias cfg_index_top: tiempo_cfg.currentIndex
    property alias cfg_really_top: really_cfg.donde
    property alias cfg_intervalo: spin.value
    property alias cfg_subreddit: sub.text
    property alias cfg_tit_o_img: imagen_check.checked
    property alias cfg_tit_e_img: both_check.checked
    property alias cfg_tryurl: urlres_check.checked
    property alias cfg_trylow: lowres_check.checked
    property alias cfg_tryhigh: highres_check.checked
    property alias cfg_back_img: backcheck.checked
    property alias cfg_middledirect: middledirectcheck.checked
    property alias cfg_middledialog: middledialogcheck.checked
    
    
    QtLayouts.ColumnLayout {
        spacing: units.smallSpacing * 2
//         anchors.left: parent.left
//         anchors.horizontalCenter: parent.horizontalCenter

        QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    QtLayouts.Layout.minimumHeight : units.smallSpacing * 8
                    text: 'subreddit to download (multiple subredits separated with , ):'
        }
        QtControls.TextField {
                    id: sub
//                     width: 250
                    QtLayouts.Layout.minimumWidth : 300
//                      placeholderText: qsTr("Enter         name")
        }
        
        QtLayouts.RowLayout{
            QtLayouts.ColumnLayout{ 
                QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    QtLayouts.Layout.minimumHeight : units.smallSpacing * 2
                    text: "Show:"
                }            
                QtControls.ExclusiveGroup { id: mostrar }
                QtControls.RadioButton {
                    id: titulo_check
                    text: "the post title"
                    checked: true
                    exclusiveGroup: mostrar
                }
                QtControls.RadioButton {
                    id: imagen_check
                    text: "the post image"
                    exclusiveGroup: mostrar
                }
                QtControls.RadioButton {
                    id: both_check
                    text: "both"
                    exclusiveGroup: mostrar
                }
            }
            QtLayouts.ColumnLayout{
                QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    QtLayouts.Layout.minimumHeight : units.smallSpacing * 2
                    text: "Images from:"
                }
             
                QtControls.ExclusiveGroup { id: resolution }
                QtControls.RadioButton {
                    id: lowres_check
                    text: "low resolution thumbnail"
    //                 checked: true
                    exclusiveGroup: resolution
                }
                QtControls.RadioButton {
                    id: highres_check
                    text: "high resolution thumbnail"
                    checked: true
                    exclusiveGroup: resolution
                }
                QtControls.RadioButton {
                    id: urlres_check
                    text: "use the post's url instead of a thumbnail"
                    exclusiveGroup: resolution
                }
            }
        }
        /*
        QtControls.CheckBox {
            id: trycheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Try to use url instead of thumbnail:"
            checked: false
        }*/
        QtLayouts.RowLayout{
//             QtLayouts.Layout.alignment: Text.AlignCenter
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
//                         horizontalAlignment: Text.AlignCenter
//                         horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignBottom
//                         QtLayouts.Layout.minimumHeight : units.smallSpacing * 8
                        text: "Show the"
            }
            
            QtControls.ComboBox {
                        id: really_cfg
                        property string donde: ""
                        textRole: "label"
                        model: [
                            {
                                'label': "top",
                                'name': "top"
                            },
                            {
                                'label': "new",
                                'name': "new"
                            },
                            {
                                'label': "hot",
                                'name': "hot"
                            },
                            {
                                'label': "rising",
                                'name': "rising"
                            },
                            {
                                'label': "controversial",
                                'name': "controversial"
                            }
                        ]
                        onCurrentIndexChanged: {
//                              print(model[currentIndex]["name"],cfg_tiempo_top);//cfg_dateFormat = model[currentIndex]["name"]
                            donde= model[currentIndex]["name"];
//                              cfg_tiempo = model[currentIndex]["name"];
                            if(model[currentIndex]["name"] == "top" || model[currentIndex]["name"] == "controversial" ){
                                tiempo_cfg.visible = true
                                postde.text= "posts of:"
                            }else{
                                tiempo_cfg.visible = false
                                postde.text= "posts"
                            }
//                             print(currentText,textRole,modelcurrentIndex]["name"])
                        }
                        Component.onCompleted:{currentIndex = find(plasmoid.configuration.really_top)}
            }
            QtControls.Label {
                        id:postde
                        QtLayouts.Layout.fillWidth: true
//                         horizontalAlignment: Text.AlignCenter
//                         horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignBottom
//                         QtLayouts.Layout.minimumHeight : units.smallSpacing * 8
                        text: "posts of:"
            }
            
            QtControls.ComboBox {
                        id: tiempo_cfg
                        property string fecha: ""
                        textRole: "label"
                        model: [
                            {
                                'label': "the last hour",
                                'name': "hour"
                            },
                            {
                                'label': "the day",
                                'name': "day"
                            },
                            {
                                'label': "the week",
                                'name': "week"
                            },
                            {
                                'label': "the mont",
                                'name': "month"
                            },
                            {
                                'label': "the year",
                                'name': "year"
                            },
                            {
                                'label': "allways",
                                'name': "all"
                            }
                        ]
                        onCurrentIndexChanged: {
//                              print(model[currentIndex]["name"],cfg_tiempo_top);//cfg_dateFormat = model[currentIndex]["name"]
                            fecha= model[currentIndex]["name"];
//                              cfg_tiempo = model[currentIndex]["name"];
                        }

//                           Component.onCompleted: {
//                               print(plasmoid.configuration.tiempo_top+".,.,.");
// //                               tiempo_cfg.currentIndex = 4;//tiempo_cfg.find("week")
// //                              print(model[currentIndex]["name"]);
// //                             for (var i = 0; i < model.length; i++) {
// //                                 if (model[i]["name"] == plasmoid.configuration.dateFormat) {
// //                                     dateFormat.currentIndex = i;
// //                                 }
// //                             }
//                           }
                        }
        }
                    
        QtLayouts.RowLayout{     
//             QtLayouts.Layout.alignment: Text.AlignCenter
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
//                         horizontalAlignment: Text.AlignCenter
                        verticalAlignment: Text.AlignBottom
//                         QtLayouts.Layout.minimumHeight : units.smallSpacing * 8
                        text: "Repeat every (minutes):"
            }
            
            QtControls.SpinBox {
                        id: spin
            }
        }
         
        QtControls.Label {//un separador
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    QtLayouts.Layout.minimumHeight : units.smallSpacing * 2
                    text: ""
        }
        
        QtControls.CheckBox {
            id: backcheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Show the subreddit's thumbnail as background:"
            checked: true
        }
        
        QtControls.CheckBox {
            id: middledirectcheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Open directly the link pointed by the post, instead of the reddit one."
            checked: false
            tooltip: "Activado: abrirá la dirección a la que apunte el post, la cual puede ser o no de reddit. \nDesactivado: botón central abrirá la página del post en reddit."
        }
        QtControls.CheckBox {
            id: middledialogcheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Open link on a dialog window:"
            checked: false
        }
                    
    }

    
    
//     Component.onDestruction:{
// //         root.time.restart();
//         print("--..--");
//     }
    
}

