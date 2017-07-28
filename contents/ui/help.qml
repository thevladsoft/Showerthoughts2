import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Controls 1.0 as QtControls

Item {
    id: help
    
   
    PlasmaCore.Dialog {
        id: linktip
        hideOnWindowDeactivate: true
        PlasmaComponents.TextField{
            readOnly:  true
            style: Text.Outline
            width: 650
            text:"https://www.reddit.com/r/linux/comments/4jx4oh/get_a_random_rshowerthoughts_post_as_your_shell/"
        }
    }
    QtLayouts.ColumnLayout {
        id: helptext
        spacing: units.smallSpacing * 2
        anchors.fill: parent
        width: help.width
        QtControls.ScrollView{
            anchors.fill: parent
            width: help.width
            QtControls.Label {
                elide: Text.ElideLeft
                width: helptext.width-20
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                onLinkActivated:{Qt.openUrlExternally(hoveredLink);}
                onLinkHovered: {linktip.visible= true}
                enabled : true
                text: "<h3>Showerthoughts.plasmoid:</h3>
Shows a randomly chosen post  (or post's thumbnail) from one or several reddit's subreddits.<br>
<br>
You can make it load a new post by left clicking and open it by middle click.<br>
<br>
It was inspired in <a href='https://www.reddit.com/r/linux/comments/4jx4oh/get_a_random_rshowerthoughts_post_as_your_shell/'> this post</a>... and somehow became much more than initially expected.
<br>
<br>
The options are self explaining. However, there are some necessary notes:<br>
<br>
<br>
<b>Images:</b>
<br>
When asked to show an image, the plasmoid will <u>try</u> to find it. There is no guaranty it will get a link to a image from reddit. This depends on many thinks. Remember that it's impossible to know how every mod configures their subreddit.
<br><br>
If it fails to find an image, it will try to show a lower resolution image. If no thumbnail of the post is found, it will default to the subreddit thumbnail. If it can't be found... well that is it. It will show nothing.
<br><br>
Also, trying to be as low resource consuming as possible, it will not download images in the background. So if your connection isn't very fast, don't wonder if it takes a while to show anything.
<br><br>
Right now it doesn't play animated images, though it should be able to show some animated formats as a static picture.
<br><br>
<b>Authentication:</b>
<br>
Right now the plasmoid doesn't know how to log in. This means that some subreddits are inaccessible. Also, some public subreddits apparently will show thumbnails to registered users only.
<br><br>
<b>Multireddits:</b><br> There is no multireddit support, and there is no intention to add it. Sorry.
"
            }
                
        }
    }


}
