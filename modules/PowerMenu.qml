import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
	anchors.fill: parent
	opacity: island.mode === "powerMenu" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 250 }}
	RowLayout {
		anchors {
			bottom: parent.bottom
			horizontalCenter: parent.horizontalCenter
			bottomMargin: 10
		}
		spacing: 2
		Repeater {
			model: 5
			Rectangle {
				width: 50
				height: width
				radius: 5
				color: rowHover.hovered ? theme.primary : theme.fg
				HoverHandler { id: rowHover }
				Behavior on color { ColorAnimation { duration: 200 }}
				Text {
					anchors.centerIn: parent
					text: {
						if (index === 0 ) { return "" }
						if (index === 1 ) { return "" }
						if (index === 2 ) { return "󰍃" }
						if (index === 3 ) { return "" }
						if (index === 4 ) { return "󰃉" } }
					font.pixelSize: {
						if (index === 1 ) { return 32 }
						else { return 24 }
					}
					color: rowHover.hovered ? "#0A0E1A" : "white"
					Behavior on color { ColorAnimation { duration: 200 }}
					Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
				}
				TapHandler { 
					enabled: island.mode === "powerMenu"
					onTapped: { 
						if (index === 0 ) { shutdownCommand.running = true }
						if (index === 1 ) { rebootCommand.running = true }
						if (index === 2 ) { logoutCommand.running = true }
						if (index === 3 ) { return 0 }
						if (index === 4 ) {epickerCommand.running = true } 
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
