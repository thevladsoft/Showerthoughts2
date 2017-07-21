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
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import QtQuick.Layouts 1.0 as QtLayouts
import QtQuick.Controls 1.0 as QtControls

Item {
    id: rootconf
    
    property alias cfg_tiempo_top: tiempo_cfg.fecha
    property alias cfg_index_top: tiempo_cfg.currentIndex
    property alias cfg_intervalo: spin.value
    property alias cfg_subreddit: sub.text
    property alias cfg_tit_o_img: imagen_check.checked
    property alias cfg_back_img: backcheck.checked
    
    
    QtLayouts.ColumnLayout {
        spacing: units.smallSpacing * 2
//         anchors.left: parent.left
//         anchors.horizontalCenter: parent.horizontalCenter
        QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.minimumHeight : units.smallSpacing * 2
                    text: "Mostrar:"
        }
        RowLayout{ 
            QtControls.ExclusiveGroup { id: tabPositionGroup }
            QtControls.RadioButton {
                id: titulo_check
                text: "el título del post"
                checked: true
                exclusiveGroup: tabPositionGroup
            }
            QtControls.RadioButton {
                id: imagen_check
                text: "la imágen del post"
                exclusiveGroup: tabPositionGroup
            }
        }
        
        QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.minimumHeight : units.smallSpacing * 8
                    text: "Mostrar los mensajes de:"
        }
        
        QtControls.ComboBox {
                        id: tiempo_cfg
                        property string fecha: ""
                        textRole: "label"
                        model: [
                            {
                                'label': "la última hora",
                                'name': "hour"
                            },
                            {
                                'label': "el día",
                                'name': "day"
                            },
                            {
                                'label': "la semana",
                                'name': "week"
                            },
                            {
                                'label': "el mes",
                                'name': "month"
                            },
                            {
                                'label': "el año",
                                'name': "year"
                            },
                            {
                                'label': "siempre",
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
                    
                    
        QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.minimumHeight : units.smallSpacing * 8
                    text: "Repetir cada (mins):"
        }
        
        QtControls.SpinBox {
                    id: spin
         }
         QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.minimumHeight : units.smallSpacing * 8
                    text: "subreddit a descargar:"
        }
        QtControls.TextField {
                    id: sub
//                     width: 250
                    Layout.minimumWidth : 300
//                      placeholderText: qsTr("Enter         name")
        }
        QtControls.Label {//un separador
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.minimumHeight : units.smallSpacing * 2
                    text: ""
        }
        QtControls.CheckBox {
            id: backcheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Mostrar imágen del subreddit como fondo:"
            checked: true
        }
                    
    }
    
    
    
//     Component.onDestruction:{
// //         root.time.restart();
//         print("--..--");
//     }
    
}

