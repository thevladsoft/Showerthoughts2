import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Controls 1.0 as QtControls
import QtQuick.Dialogs 1.0

Item {
    id: rootconf
    
    property alias cfg_back_img: backcheck.checked
    property alias cfg_transback: transbackcheck.checked
    property alias cfg_middledirect: middledirectcheck.checked
    property alias cfg_middledialog: middledialogcheck.checked
    property alias cfg_middlemouse: middlemousecheck.checked
    property alias cfg_leftmouse: leftmousecheck.checked
    property alias cfg_nsfw: nsfwcheck.checked
    property alias cfg_cleaner: cleanercheck.checked
    property alias cfg_cleanersize: cleanerspin.value
    
    property alias cfg_barras: barrascheck.checked
    
    property alias cfg_delay: spindelay.value
    
     property alias cfg_colortext: _textcolor.text
     property alias cfg_colorshadow: _shadowcolor.text
    
    ColorDialog {
            id: colorDialog
            title: "Please choose a color"
            //En el orden de los cuatros botones
            property int boton
            onAccepted: {
                switch(boton){
                    case 0:
                        _textcolor.text = colorDialog.color
                        break
                    case 1:
                        _shadowcolor.text = colorDialog.color
                        break
                }
            }
    }
    
    
    
    QtLayouts.ColumnLayout {
        spacing: units.smallSpacing * 4

        QtControls.CheckBox {
            id: transbackcheck
            QtLayouts.Layout.fillWidth: true
            text: "Transparent background"
        }
        
        QtLayouts.RowLayout{
            QtControls.Button {
                text: "Text color"
                onClicked: {colorDialog.boton = 0;colorDialog.color = _textcolor.text;colorDialog.visible = true;}
            }
            QtControls.TextField {
                id: _textcolor
                PlasmaCore.ToolTipArea{
                    width: 100
                    height: 100
                    mainText: "You can write 'transparent' as color"
                }
            }
        }
        QtLayouts.RowLayout{
            QtControls.Button {
                text: "Text shadow color"
                onClicked: {colorDialog.boton = 1;colorDialog.color = _shadowcolor.text;colorDialog.visible = true;}
            }
            
            QtControls.TextField {
                id: _shadowcolor
                PlasmaCore.ToolTipArea{
                    width: 100
                    height: 100
                    mainText: "You can write 'transparent' as color"
                }
            }
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
                
        QtLayouts.RowLayout{     
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
                        text: "Wait "
            }
            
            QtControls.SpinBox {
                        id: spindelay
            }
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
                        text: "seconds before starting."
            }
        }
        QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignTop
                        text: "(could help plasma to start faster in very slow connections.)"
        }
                
        QtLayouts.RowLayout{
            //Item{width: 20}        
//             Column{
                QtControls.CheckBox {
                        id: cleanercheck
                        //QtLayouts.Layout.fillWidth: true
                        text: "Erase disk cache if larger than:  "
                }
                QtControls.SpinBox {
                        id: cleanerspin
                        minimumValue: 5
                        enabled: cleanercheck.checked
                }
                QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
                        text: "mb"
                        enabled: cleanercheck.checked
                }
//             }
        }
        QtControls.CheckBox {
                    id: barrascheck
                    //QtLayouts.Layout.fillWidth: true
                    text: "Hide vertical scrollbars"
            }
                    
    }
}

