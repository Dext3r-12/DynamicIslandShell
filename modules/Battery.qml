import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../services"

Item {
	anchors.fill: parent
	opacity: island.mode === "battery" ? 1 : 0
	Item {
		anchors.left: parent.left
		anchors.leftMargin: 100
		anchors.verticalCenter: parent.verticalCenter
		Rectangle { 
			id: batteryBase
			anchors.left: parent.left
			anchors.leftMargin: -70
			width: 150 
			height: 230
			y: -105
			radius: 10
			color: Colors.fg
			Rectangle {
				width: 50
				height: 20
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottom: parent.top
				anchors.bottomMargin: 5
				radius: 5
				color: Colors.fg
			}
		}
		Rectangle { 
			id: batteryShape
			anchors.left: parent.left
			anchors.leftMargin: -70
			anchors.bottom: batteryBase.bottom
			width: 150 
			height: (Battery.percent * 230) / 100
			Behavior on height { NumberAnimation { duration: 350; easing.type: Easing.OutCubic } }
			y: -105
			radius: 10
			color: {
				if ( Battery.percent > 30 ) { return Colors.green }
				if ( Battery.percent > 20 ) { return "yellow" }
				else 			    { return Colors.red }
				}
		}
		Text {
			anchors.centerIn: batteryBase
			text: Battery.percent
			font.pixelSize: 78
			font.family: "Jetbrains Mono"
			color: Battery.percent >= 60 ? Colors.fg : Colors.white
		}
		Binding {
			target: Battery
			property: "isRunning"
			value: island.mode === "battery"
		}
	}
	Rectangle {
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 115
		anchors.rightMargin: 15
		radius: 10
		width: 150
		height: 140
		color: Colors.fg
		ColumnLayout {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: 5
			Repeater {
				model: 3
				Rectangle {
					width: 140
					height: 40
					radius: 10
					color: Battery.mode === index + 1 ? Colors.primary : Colors.fg1
					Behavior on color { ColorAnimation { duration: 200 } }
					Text {
						text: {
							switch (index) {
								case 0: return "Performance"; break;
								case 1: return "Balanced"; break;
								case 2: return "Power-saver"; break;
							}
						}
						color: Battery.mode === index + 1 ? Colors.fg : Colors.white
						anchors.centerIn: parent
						font.pixelSize: 20
						font.family: "Roboto"
						font.weight: Battery.mode === index + 1 ? Font.Bold : Font.Normal
						Behavior on color { ColorAnimation { duration: 200 } }
					}
					TapHandler {
						onTapped: Battery.mode = index + 1
					}
				}
			}
		}
	}
}
