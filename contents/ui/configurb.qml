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
    property alias cfg_transback: transbackcheck.checked
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
//         QtControls.Label {//un separador
//                     QtLayouts.Layout.fillWidth: true
//                     horizontalAlignment: Text.AlignLeft
//                     verticalAlignment: Text.AlignBottom
//                     QtLayouts.Layout.minimumHeight : units.smallSpacing * 2
//                     text: ""
//         }
//         

        QtControls.CheckBox {
            id: transbackcheck
            QtLayouts.Layout.fillWidth: true
//             horizontalAlignment: Text.AlignLeft
//             verticalAlignment: Text.AlignBottom
//             Layout.minimumHeight : units.smallSpacing * 8
            text: "Transparent background"
//             checked: true
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

