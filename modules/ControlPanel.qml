import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs


Item {
	anchors.fill: parent
	opacity: island.mode === "controlPanel" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 100 } }
	GridLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 50
		}
		rows: 2
		columns: 3
		rowSpacing: 3
		columnSpacing: 3
		Repeater {
			model: 6
			Rectangle {
				width: 100
				height: 50
				radius: 10
				color: controlPanelHoverButtons.hovered ? colors.primary : colors.fg
				Text {
					color: controlPanelHoverButtons.hovered ? colors.bg : colors.white
					text: {
						if (index === 0) { return "" }
						if (index === 1) { return "" }
						if (index === 2) { return "" }
						if (index === 3) { return "" }
						if (index === 4) { return "" }
						if (index === 5) { return "" }
					}
					anchors.centerIn: parent
					font.pixelSize: {
						if (index === 1 ) { return 32 }
						if (index === 2 ) { return 34 }
						if (index === 3 ) { return 28 }
						else { return 28 }
					}
					font.family: iconFont.name
					Behavior on color { ColorAnimation { duration: 150 }}
				}
				HoverHandler { id: controlPanelHoverButtons; enabled: island.mode === "controlPanel" }
				Behavior on color { ColorAnimation { duration: 150 }}
				TapHandler {
					enabled: island.mode === "controlPanel"
					onTapped: {
						if (index === 0) { island.mode = "wifi" }
						if (index === 1) { island.mode = "wifi" }
						if (index === 2) { island.mode = "wifi" }
						if (index === 3) { island.mode = "stressMenu" }
						if (index === 4) { island.mode = "wifi" }
						if (index === 5) { island.mode = "themeSelect" }
					}
				}
			}
		}
	}
	RowLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 10
		}
		spacing: 10
		Repeater {
			model: battery.percent === "computer" ? 3 : 3
			Rectangle {
				height: 30
				width: height
				radius: width / 2
				color: colors.fg
				Text {
					text: {
						if ( index === 0 ) { return "" }
						if ( index === 1 ) { return "󰍃" }
						if ( index === 2 ) { 
							if (battery.Percent >= 97) { return "󰁹" }
							else if (battery.percent >= 90) { return "󰂂" }
							else if (battery.percent >= 80) { return "󰂁" }
							else if (battery.percent >= 70) { return "󰂀" }
							else if (battery.percent >= 60) { return "󰁿" }
							else if (battery.percent >= 50) { return "󰁾" }
							else if (battery.percent >= 40) { return "󰁽" }
							else if (battery.percent >= 30) { return "󰁼" }
							else if (battery.percent >= 20) { return "󰁼" }
							else if (battery.percent >= 10) { return "󰁻" }
							else { return "󰁺" }
					       	}
					}
					anchors.centerIn: parent
					color: colors.white
					font.pixelSize: 16
				}
				TapHandler {
					enabled: island.mode === "controlPanel"
					onTapped: {
						if ( index === 0 ) { shutdownCommand.running = true }
						if ( index === 1 ) { logoutCommand.running = true }
						if ( index === 2 ) { island.mode = "battery" }
					}
				}
			}
		}
		Process {
			id: battery
			property string percent: ""
			running: island.mode === "controlPanel"
			command: ["sh", "-c", "~/.config/quickshell/scripts/battery"]
			stdout: StdioCollector { 
				onStreamFinished: {
					battery.percent = text.trim()
				}
			}
		}
	}
}
