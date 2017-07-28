import QtQuick 2.0
import org.kde.plasma.configuration 2.0
ConfigModel {
    ConfigCategory {
         name: "General"
         icon: "plasma"
         source: "configura.qml"
    }
    ConfigCategory {
         name: "Advanced"
         icon: "system-run"
         source: "configurb.qml"
    }
    ConfigCategory {
         name: "Info"
         icon: "help-about"
         source: "help.qml"
    }
}
