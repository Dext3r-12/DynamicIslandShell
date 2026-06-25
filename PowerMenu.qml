import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
	anchors.fill: parent
	opacity: power.pmenu ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 150 }}
	RowLayout {
		anchors {
			top: parent.top
			horizontalCenter: parent.horizontalCenter
			topMargin: 10
		}
		spacing: 10
		Rectangle {
			width: 50
			height: width
			radius: 10
			color: h1.hovered ? "#A855F7" : "#151B2D"
			Text {
				anchors.centerIn: parent
				text: ""
				font.pixelSize: h1.hovered ? 38 : 24
				color: h1.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 100 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 300; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h1 }
			TapHandler { onTapped: { shutdownCommand.running = true } enabled: power.pmenu ? true : false }


			Behavior on color { ColorAnimation { duration: 100 }}
		}
		Process {
			id: shutdownCommand
			command: ["poweroff"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: 10
			color: h2.hovered ? "#A855F7" : "#151B2D"
			Text {
				anchors.centerIn: parent
				text: "󰜉"
				font.pixelSize: h2.hovered ? 38 : 24
				color: h2.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 100 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 300; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h2 }

			TapHandler { onTapped: { rebootCommand.running = true } enabled: power.pmenu ? true : false }
			Behavior on color { ColorAnimation { duration: 100 }}
		}
		Process {
			id: rebootCommand
			command: ["reboot"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: 10
			color: h3.hovered ? "#A855F7" : "#151B2D"
			Text {
				anchors.centerIn: parent
				text: "󰍃"
				font.pixelSize: h3.hovered ? 38 : 24
				color: h3.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 100 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 300; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h3 }

			TapHandler { onTapped: { logoutCommand.running = true } enabled: power.pmenu ? true : false }
			Behavior on color { ColorAnimation { duration: 100 }}
		}
		Process {
			id: logoutCommand
			command: ["hyprctl", "dispatch", "exit"]
			running: false
		}
		Rectangle {
			width: 50
			height: width
			radius: 10
			color: h4.hovered ? "#A855F7" : "#151B2D"
			Text {
				anchors.centerIn: parent
				text: ""
				font.pixelSize: h4.hovered ? 38 : 24
				color: h4.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 100 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 300; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h4 }

			TapHandler { onTapped: { wallpaperCommand.running = true } enabled: power.pmenu ? true : false }
			Behavior on color { ColorAnimation { duration: 100 }}
		Process {
			id: wallpaperCommand
			command: ["hyprctl", "dispatch", "exit"]
			running: false
		}
		}
		Rectangle {
			width: 50
			height: width
			radius: 10
			color: h5.hovered ? "#A855F7" : "#151B2D"
			Text {
				anchors.centerIn: parent
				text: "󰃉"
				font.pixelSize: h5.hovered ? 38 : 24
				color: h5.hovered ? "#0A0E1A" : "white"
				Behavior on color { ColorAnimation { duration: 100 }}
				Behavior on font.pixelSize { NumberAnimation { duration: 300; easing.type: Easing.OutCubic; }}
			}
			HoverHandler { id: h5 }

			Behavior on color { ColorAnimation { duration: 100 }}
			TapHandler { onTapped: { pickerCommand.running = true; power.pmenu = false } enabled: power.pmenu ? true : false }
		Process {
			id: pickerCommand
			command: ["sh", "-c", "sleep 0.4 && hyprpicker -a"]
			running: false
		}
		}
	}

}
