import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
	anchors.fill: parent
	opacity: island.mode === "powerMenu" ? 1 : 0
	enabled: island.mode === "powerMenu" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 250 }}
	RowLayout {
		anchors {
			bottom: parent.bottom
			horizontalCenter: parent.horizontalCenter
			bottomMargin: 10
		}
		spacing: 2
		Repeater {
			model: 4
			Rectangle {
				width: 50
				height: 50
				radius: 5
				color: rowHover.hovered ? colors.primary : colors.fg
				Behavior on color { ColorAnimation { duration: 200 }}
				Text {
					anchors.centerIn: parent
					text: {
						if (index === 0 ) { return "" }
						if (index === 1 ) { return "" }
						if (index === 2 ) { return "" }
						if (index === 3 ) { return "󰃉" } }
					font.pixelSize: {
						if (index === 0 ) { return 26 }
						if (index === 1 ) { return 36 }
						if (index === 2 ) { return 32 }
						if (index === 3 ) { return 26 }
						else { return 24 }
					}
					font.family: iconFont.name
					color: rowHover.hovered ? colors.bg : colors.white
					Behavior on color { ColorAnimation { duration: 200 }}
					Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
				}
				HoverHandler { id: rowHover; enabled: island.mode === "powerMenu"}
				TapHandler { 
					enabled: island.mode === "powerMenu"
					onTapped: { 
						if (index === 0 ) { shutdownCommand.running = true }
						if (index === 1 ) { rebootCommand.running = true }
						if (index === 2 ) { logoutCommand.running = true }
						if (index === 3 ) { pickerCommand.running = true } 
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
		id: wallpaperCommand
		command: ["hyprctl", "dispatch", "exit"]
		running: false
	}
	Process {
		id: pickerCommand
		command: ["sh", "-c", "sleep 0.4 && hyprpicker -a"]
		running: false
	}
}
