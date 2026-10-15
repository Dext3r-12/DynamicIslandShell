import Quickshell
import QtQuick
import QtQuick.Layouts

import "../../services"
import "../../widgets"


Item {
	anchors.fill: parent
	ColumnLayout {
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.rightMargin: 30
		anchors.topMargin: 20
		spacing: 10
		Repeater {
			model: 2
			RowLayout {
				spacing: 30
				Layout.alignment: Qt.AlignRight
				Text {
					text: {
						switch (index) {
							case 0: return "Split Mode";  break;
							case 1: return "Flexable Player"; break;
						}
					}
					color: Colors.white
					Layout.alignment: Qt.AlignLeft
					horizontalAlignment: Text.AlignRight
					font.pixelSize: 18
					font.family: "Roboto"
					font.weight: 500
				}
				ToggleSwitch {
					Component.onCompleted: {
						switch (index) {
							case 0: toggle = Configuration.splitMode; break;
							case 1: toggle = Configuration.flexPlayer; break;
						}
					}
					TapHandler {
						onTapped: {
							switch (index) {
								case 0: Configuration.splitMode = parent.toggleSwitch(); break;
								case 1: Configuration.flexPlayer = parent.toggleSwitch(); break;
							}
						}
					}
				}
			}
		}
	}
}
