import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects
import qs

Item {
	anchors.fill: parent
	opacity: island.mode === "battery" ? 1 : 0
	Colors { id: theme }
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
			color: theme.fg
			Rectangle {
				width: 50
				height: 20
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottom: parent.top
				anchors.bottomMargin: 5
				radius: 5
				color: theme.fg
			}
		}
		Rectangle { 
			id: batteryShape
			anchors.left: parent.left
			anchors.leftMargin: -70
			anchors.bottom: batteryBase.bottom
			width: 150 
			height: (batteryPercent.text.trim() * 230) / 100
			Behavior on height { NumberAnimation { duration: 350; easing.type: Easing.OutCubic } }
			y: -105
			radius: 10
			color: theme.green
		}
		Text {
			anchors.centerIn: batteryBase
			text: batteryPercent.text.trim()
			font.pixelSize: 78
			font.family: "Jetbrains Mono"
			color: batteryPercent.text.trim() >= 40 ? theme.fg : theme.white
		}
	}
	Process {
		id: batteryProcess
		running: island.mode === "battery"
		command: ["sh", "-c", "upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%'"]
		stdout: StdioCollector { id: batteryPercent }
	}
	Timer {
		running: island.mode === "battery"
		repeat: true
		interval: 1000
		onTriggered: { batteryProcess.running = false; batteryProcess.running = true; }
	}
}

