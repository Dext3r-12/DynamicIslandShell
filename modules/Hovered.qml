import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import QtQuick.Shapes
import qs

Item {
	id: menuHovered
	anchors.fill: parent
	opacity: island.mode === "hovered"
	Behavior on opacity { NumberAnimation { duration: 100 } }

	Text {
		opacity: batteryPercent.text === "computer" ? 1 : 0
		text: batteryPercent.text
		font.pixelSize: 24
		font.family: "Jetbrains Mono"
		color: "white"
		verticalAlignment: Text.AlignVCenter
		anchors {
			right: parent.right
			rightMargin: 120
			top: parent.top
			topMargin: 10
		}
		Text {
			text: {
				if (batteryPercent.text.slice(0, 2) >= 80) { return "" } 
				else if (batteryPercent.text.slice(0, 2) >= 60) { return "" } 
				else if (batteryPercent.text.slice(0, 2) >= 40) { return "" } 
				else if (batteryPercent.text.slice(0, 2) >= 20) { return "" } 
				else if (batteryPercent.text.slice(0, 2) >= 5) { return "" }
				else { return "" }
			}
			font.pixelSize: 48
			font.family: "Jetbrains Mono"
			color: "white"
			x: 30
			y: 5
			anchors {
				centerIn: parent
				horizontalCenterOffset: 30
			}
		}
	}
	Process {
		running: island.mode === "hovered"
		command: ["sh", "-c", "~/.config/quickshell/scripts/battery"]
		stdout: StdioCollector { id: batteryPercent }
	}

	// Workspaces
	RowLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 5
		}
		spacing: 5
		
		Repeater {
			model: 5
			Rectangle {
				id: workspace
				property bool whover: false
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				width: 30
				height: 30
				radius: 6
				color: colors.fg
				Behavior on color { ColorAnimation { duration: 100 } }
				Text {
					anchors.centerIn: parent
					text: index + 1
					color: colors.primary
					font.pixelSize: 18
					font.family: "Jetbrains Mono"
				}	
				TapHandler { 
					enabled: island.mode === "hovered"
					onTapped: {
					let wnum = index + 1
					Hyprland.dispatch(`hl.dsp.focus({ workspace = "${wnum}" })`)
				}}


			}
		}
	}
	Rectangle {
		width: 30
		height: 30
		radius: 6
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 5
		color: colors.primary
		x: {
			if (Hyprland.focusedWorkspace?.id >= 5) {
				return 105 + 35 * 5
			}
			return 105 + 35 * Hyprland.focusedWorkspace?.id
		
		}
		Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutCubic}}
		Text {
			anchors.centerIn: parent
			text: Hyprland.focusedWorkspace.id
			color: colors.bg
			Behavior on color { ColorAnimation { duration: 100 } }
			font.pixelSize: 18
			font.family: "Jetbrains Mono"
		}	
	}


	// Equalizer
	RowLayout {
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 90
		rotation: 180
		Repeater {
			model: 3
			Rectangle {
				color: colors.fg
				width: 10
				height: (eqInfo[index + 3] / 2.5) + 10
				radius: width / 2
				Behavior on height { NumberAnimation { duration: 20 }}
			}
		}
	}
	RowLayout {
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 90
		rotation: 180
		Repeater {
			model: 3
			Rectangle {
				color: colors.fg
				width: 10
				height: (eqInfo[index] / 2.5) + 10
				radius: width / 2
				Behavior on height { NumberAnimation { duration: 20 }}
			}
		}
	}
	property var eqInfo: []
	Process {
		id: eqGet
		running: island.mode === "hovered"
		command: ["sh", "-c", "~/.config/quickshell/scripts/equalizer.sh "]
		stdout: SplitParser {
			onRead: data => {
				eqInfo = data.split("#")
			}
		}
	}

	// Other
	Volume {}
	Player {}
}
