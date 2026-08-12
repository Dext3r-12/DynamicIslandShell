import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs


Item {
	anchors.fill: parent
	opacity: island.mode === "settings" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 100 } }
	RowLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 85
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.primary
			radius: 10
			Image {
				source: "../icons/wifi.png"
				anchors.centerIn: parent
				fillMode: Image.PreserveAspectCrop
				height: 35
				width: height
			}
			TapHandler { onTapped: { island.mode = "wifi" } }
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.fg
			radius: 10
			Text {
				anchors.centerIn: parent
				text: "󰂯"
				color: "white"
				font.pixelSize: 30
			}
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.fg
			radius: 10
			TapHandler { onTapped: { island.mode = "battery" } }
			Text {
				text: {
					if (batteryPercent.text.slice(0, 2) >= 97) { return "󰁹" }
					else if (batteryPercent.text.slice(0, 2) >= 90) { return "󰂂" }
					else if (batteryPercent.text.slice(0, 2) >= 80) { return "󰂁" }
					else if (batteryPercent.text.slice(0, 2) >= 70) { return "󰂀" }
					else if (batteryPercent.text.slice(0, 2) >= 60) { return "󰁿" }
					else if (batteryPercent.text.slice(0, 2) >= 50) { return "󰁾" }
					else if (batteryPercent.text.slice(0, 2) >= 40) { return "󰁽" }
					else if (batteryPercent.text.slice(0, 2) >= 30) { return "󰁼" }
					else if (batteryPercent.text.slice(0, 2) >= 20) { return "󰁼" }
					else if (batteryPercent.text.slice(0, 2) >= 10) { return "󰁻" }
					else { return "󰁺" }
				}
				anchors.centerIn: parent
				font.pixelSize: 30
				color: "white"
				Process {
					running: island.mode === "settings"
					command: ["sh", "-c", "upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%'"]
					stdout: StdioCollector { id: batteryPercent }
				}
			}
		}
	}
	RowLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 25
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.fg
			radius: 10
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.fg
			radius: 10
		}
		Rectangle {
			width: 100
			height: 50
			color: theme.fg
			radius: 10
		}
	}
}
