 
import QtQuick 2.0
import org.kde.plasma.configuration 2.0
ConfigModel {
    ConfigCategory {
         name: "General"
         icon: "plasma"
         source: "configura.qml"
    }
    ConfigCategory {
         name: "Help"
         icon: "help-about"
         source: "help.qml"
    }
}
