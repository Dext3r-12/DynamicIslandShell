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
	ColumnLayout {
		id: buttonsGrid
		width: 300
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 60
		}


		// First row --- Wifi and Bluetooth

		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			Repeater {
				model: 2
				Rectangle {
					Layout.fillWidth: true
					height: 50
					radius: 10
					color: controlPanelHoverButtons.hovered ? colors.primary : colors.fg
					Text {
						anchors.centerIn: parent
						text: index === 0 ? "" : ""
						color: controlPanelHoverButtons.hovered ? colors.bg : colors.white
						font.pixelSize: index === 0 ? 32 : 36
						font.family: iconFont.name
						Behavior on color { ColorAnimation { duration: 150 }}
					}
					HoverHandler { id: controlPanelHoverButtons; enabled: island.mode === "controlPanel" }
					Behavior on color { ColorAnimation { duration: 150 }}
					TapHandler {
						enabled: island.mode === "controlPanel"
						onTapped: index === 0 ? island.mode = "wifi" : island.mode = "bluetooth"
					}
				}
			}
		}

		// Second row --- stress, wallpaper and palette

		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			Repeater {
				model: 3
				Rectangle {
					Layout.fillWidth: true
					height: 50
					radius: 10
					color: controlPanelHoverButtons.hovered ? colors.primary : colors.fg
					Text {
						color: controlPanelHoverButtons.hovered ? colors.bg : colors.white
						text: {
							switch (index) {
								case 0: return ""; break;
								case 1: return ""; break;
								case 2: return ""; break;
							}
						}
						anchors.centerIn: parent
						font.pixelSize: {
							switch (index) {
								case 0: return 32; break;
								case 1: return 34; break;
								case 2: return 28; break;
							}
						}
						font.family: iconFont.name
						Behavior on color { ColorAnimation { duration: 150 }}
					}
					HoverHandler { id: controlPanelHoverButtons; enabled: island.mode === "controlPanel" }
					Behavior on color { ColorAnimation { duration: 150 }}
					TapHandler {
						enabled: island.mode === "controlPanel"
						onTapped: {
							switch (index) {
								case 0: island.mode = "stressMenu"; break;
								case 1: island.mode = "wallpaper"; break;
								case 2: island.mode = "themeSelect"; break;
							}
						}
					}
				}
			}
		}
	}

	// Third row --- power options, settings and battery
	
	RowLayout {
		anchors {
			bottom: parent.bottom
			left: buttonsGrid.left
			right: buttonsGrid.right
			bottomMargin: 10
		}
		spacing: 4
		Repeater {
			model: 5// battery.charge === "computer" ? 4 : 5
			Rectangle {
				height: 45
				radius: 10
				Layout.fillWidth: true
				color: {
					if (index === 0 || index === 1 || index === 2) { return rowHover.hovered ? colors.red : colors.fg } 
					else { return rowHover.hovered ? colors.primary : colors.fg }
				}
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutCubic }}
				Text {
					anchors.centerIn: parent
					text: {
						switch (index) {
							case 0: return ""; break;
							case 1: return ""; break;
							case 2: return ""; break;
							case 3: return ""; break;
							case 4: return ""; break;
						}
					}
					font.pixelSize: {
						switch (index) {
							case 0: return 26; break;
							case 1: return 36; break;
							case 2: return 32; break;
							case 3: return 28; break;
							case 4: return 32; break;
						}
					}
					font.family: iconFont.name
					color: rowHover.hovered ? colors.bg : colors.white
					Behavior on color { ColorAnimation { duration: 200 }}
					Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
				}
				HoverHandler { id: rowHover; enabled: island.mode === "controlPanel"}
				TapHandler { 
					enabled: island.mode === "controlPanel"
					onTapped: { 
						switch (index) {
							case 0: shutdownCommand.running = true; break
							case 1: rebootCommand.running   = true; break
							case 2: logoutCommand.running   = true; break
							case 3: island.mode             = "settings"; break
							case 4: island.mode             = "battery"; break
						}
					}
				}
			}
		}
		Process {
			id: shutdownCommand
			command: ["poweroff"]
			running: false
		}
		Process {
			id: rebootCommand
			command: ["reboot"]
			running: false
		}
		Process {
			id: logoutCommand
			command: ["sh", "-c", "hyprctl dispatch 'hl.dsp.exit()'"]
			running: false
		}
		Process {
			id: battery
			property var charge: ""
			command: ["sh", "-c", "~/.config/quickshell/scripts/battery"]
			running: island.mode === "controlPanel"
			stdout: StdioCollector { onStreamFinished: { battery.charge = text.trim()} }
		}
	}

	// Second row 
}
