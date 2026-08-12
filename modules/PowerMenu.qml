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
		Rectangle {
			width: 50
			height: width
			radius: h1.hovered ? 10 : 5
			color: h1.hovered ? theme.primary : theme.fg
			Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCubic} }
			Text {
				anchors.centerIn: parent
				text: ""
				font.pixelSize: h1.hovered ? 38 : 24
				color: h1.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h1 }
			TapHandler { onTapped: { shutdownCommand.running = true } enabled: island.mode === "powerMenu" ? true : false }


			Behavior on color { ColorAnimation { duration: 200 }}
		}
		Process {
			id: shutdownCommand
			command: ["poweroff"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: h2.hovered ? 10 : 5
			color: h2.hovered ? theme.primary : theme.fg
			Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCubic} }
			Text {
				anchors.centerIn: parent
				text: "󰜉"
				font.pixelSize: h2.hovered ? 38 : 24
				color: h2.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h2 }
			TapHandler { onTapped: { rebootCommand.running = true } enabled: island.mode === "powerMenu" ? true : false }
			Behavior on color { ColorAnimation { duration: 200 }}
		}
		Process {
			id: rebootCommand
			command: ["reboot"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: h3.hovered ? 10 : 5
			color: h3.hovered ? theme.primary : theme.fg
			Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCubic} }
			Text {
				anchors.centerIn: parent
				text: "󰍃"
				font.pixelSize: h3.hovered ? 38 : 24
				color: h3.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h3 }

			TapHandler { onTapped: { logoutCommand.running = true } enabled: island.mode === "powerMenu" ? true : false }
			Behavior on color { ColorAnimation { duration: 400 }}
		}
		Process {
			id: logoutCommand
			command: ["sh", "-c", "hyprctl dispatch 'hl.dsp.exit()'"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: h4.hovered ? 10 : 5
			color: h4.hovered ? theme.primary : theme.fg
			Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCubic} }
			Text {
				anchors.centerIn: parent
				text: ""
				font.pixelSize: h4.hovered ? 38 : 24
				color: h4.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h4 }

			TapHandler { onTapped: { wallpaperCommand.running = true } enabled: island.mode === "powerMenu" ? true : false }
			Behavior on color { ColorAnimation { duration: 200 }}
		Process {
			id: wallpaperCommand
			command: ["hyprctl", "dispatch", "exit"]
			running: false
		}
		}
		Rectangle {
			width: 50
			height: width
			radius: h5.hovered ? 10 : 5
			color: h5.hovered ? theme.primary : theme.fg
			Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCubic} }
			Text {
				anchors.centerIn: parent
				text: "󰃉"
				font.pixelSize: h5.hovered ? 38 : 24
				color: h5.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 200 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 400; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h5 }

			Behavior on color { ColorAnimation { duration: 200 }}
			TapHandler { onTapped: { pickerCommand.running = true; island.mode = "idle" } enabled: island.mode === "powerMenu" ? true : false }
		Process {
			id: pickerCommand
			command: ["sh", "-c", "sleep 0.4 && hyprpicker -a"]
			running: false
		}
		}
	}

}
