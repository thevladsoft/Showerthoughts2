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
    
    property alias cfg_back_img: backcheck.checked
    property alias cfg_middledirect: middledirectcheck.checked
    property alias cfg_middledialog: middledialogcheck.checked
    property alias cfg_middlemouse: middlemousecheck.checked
    property alias cfg_leftmouse: leftmousecheck.checked
    property alias cfg_nsfw: nsfwcheck.checked
    
    QtLayouts.ColumnLayout {
        spacing: units.smallSpacing * 4
//         anchors.left: parent.left
//         anchors.horizontalCenter: parent.horizontalCenter

                ///////////////////////////////////////////////////////// 
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
            text: "Show the subreddit's thumbnail on background"
//             checked: true
        }
        
        QtControls.CheckBox {
            id: leftmousecheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Left click loads a new post"
//             checked: true
        }
        
        QtControls.CheckBox {
            id: middlemousecheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Middle click opens post"
//             checked: true
        }
        QtLayouts.RowLayout{
            Item{width: 20}
            Column{
                QtControls.CheckBox {
                    id: middledirectcheck
                    QtLayouts.Layout.fillWidth: true
        //             horizontalAlignment: Text.AlignLeft
        //             verticalAlignment: Text.AlignBottom
        //             Layout.minimumHeight : units.smallSpacing * 8
                    text: "Open the link pointed by the post directly, instead of the reddit one"
                    enabled: middlemousecheck.checked
        //             checked: false
        //             tooltip: "Activado: abrirá la dirección a la que apunte el post, la cual puede ser o no de reddit. \nDesactivado: botón central abrirá la página del post en reddit."
                }
                QtControls.CheckBox {
                    id: middledialogcheck
                    QtLayouts.Layout.fillWidth: true
        //             horizontalAlignment: Text.AlignLeft
        //             verticalAlignment: Text.AlignBottom
        //             Layout.minimumHeight : units.smallSpacing * 8
                    text: "Open link on a dialog window"
                    enabled: middlemousecheck.checked
        //             checked: false
                }
            }
        }
        
        QtControls.CheckBox {
                    id: nsfwcheck
                    QtLayouts.Layout.fillWidth: true
        //             horizontalAlignment: Text.AlignLeft
        //             verticalAlignment: Text.AlignBottom
        //             Layout.minimumHeight : units.smallSpacing * 8
                    text: "Allow posts marked as nsfw (for adults)"
                }
                    
    }

    
    
//     Component.onDestruction:{
// //         root.time.restart();
//         print("--..--");
//     }
    
}

