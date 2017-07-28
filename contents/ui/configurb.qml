import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
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

        QtControls.CheckBox {
            id: transbackcheck
            QtLayouts.Layout.fillWidth: true
            text: "Transparent background"
        }
        
        QtControls.CheckBox {
            id: backcheck
            QtLayouts.Layout.fillWidth: true
            text: "Show the subreddit's thumbnail on background"
        }
        
        QtControls.CheckBox {
            id: leftmousecheck
            QtLayouts.Layout.fillWidth: true
            text: "Left click loads a new post"
        }
        
        QtControls.CheckBox {
            id: middlemousecheck
            QtLayouts.Layout.fillWidth: true
            text: "Middle click opens post"
        }
        QtLayouts.RowLayout{
            Item{width: 20}
            Column{
                QtControls.CheckBox {
                    id: middledirectcheck
                    QtLayouts.Layout.fillWidth: true
                    text: "Open the link pointed by the post directly, instead of the reddit one"
                    enabled: middlemousecheck.checked
                }
                QtControls.CheckBox {
                    id: middledialogcheck
                    QtLayouts.Layout.fillWidth: true
                    text: "Open link on a dialog window"
                    enabled: middlemousecheck.checked
                }
            }
        }
        
        QtControls.CheckBox {
                    id: nsfwcheck
                    QtLayouts.Layout.fillWidth: true
                    text: "Allow posts marked as nsfw (for adults)"
                }
                    
    }
}

