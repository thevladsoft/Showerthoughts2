import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Controls 1.0 as QtControls

Item {
    id: rootconf
    
    property alias cfg_tiempo_top: tiempo_cfg.fecha
    property alias cfg_index_top: tiempo_cfg.currentIndex
    property alias cfg_really_top: really_cfg.donde
    property alias cfg_intervalo: spin.value
    property alias cfg_subreddit: sub.text
    property alias cfg_tit_no_img: titulo_check.checked
    property alias cfg_tit_o_img: imagen_check.checked
    property alias cfg_tit_e_img: both_check.checked
    property alias cfg_tryurl: urlres_check.checked
    property alias cfg_trylow: lowres_check.checked
    property alias cfg_tryhigh: highres_check.checked
    
    QtLayouts.ColumnLayout {
        spacing: units.smallSpacing * 4

        QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    QtLayouts.Layout.minimumHeight : units.smallSpacing * 8
                    text: 'subreddit to download (separate multiple subredits  with , ):'
        }
        QtControls.TextField {
                    id: sub
                    QtLayouts.Layout.minimumWidth : 400
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
                    exclusiveGroup: resolution
                }
                QtControls.RadioButton {
                    id: highres_check
                    text: "high resolution thumbnail"
                    exclusiveGroup: resolution
                }
                QtControls.RadioButton {
                    id: urlres_check
                    text: "use the linked url instead of a thumbnail"
                    exclusiveGroup: resolution
                }
            }
        }
        
        QtLayouts.RowLayout{
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
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
                            donde= model[currentIndex]["name"];
                            if(model[currentIndex]["name"] == "top" || model[currentIndex]["name"] == "controversial" ){
                                tiempo_cfg.visible = true
                                postde.text= "posts of:"
                            }else{
                                tiempo_cfg.visible = false
                                postde.text= "posts"
                            }
                        }
                        Component.onCompleted:{currentIndex = find(plasmoid.configuration.really_top)}
            }
            QtControls.Label {
                        id:postde
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
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
                            fecha= model[currentIndex]["name"];
                        }
            }
        }
                    
        QtLayouts.RowLayout{     
            QtControls.Label {
                        QtLayouts.Layout.fillWidth: true
                        verticalAlignment: Text.AlignBottom
                        text: "Repeat every (minutes):"
            }
            
            QtControls.SpinBox {
                        id: spin
            }
        }
                   
    }
 
}

