 import QtQuick 2.0;
 import org.kde.plasma.core 2.0 as PlasmaCore
 import org.kde.plasma.components 2.0 as PlasmaComponents
//  Item {
MouseArea {
    id:root2
    anchors.fill: parent
    onClicked: plasmoid.expanded = !plasmoid.expanded
    Image {
        anchors.fill: parent
        source: "./shower.png"
    }
     PlasmaCore.ToolTipArea {
         width: root2.width
         height: root2.height
         mainText: tooltip.mainText//"-.-.-.-.-.-.-.-.-."  
         subText: tooltip.subText
     }
}
//  }
