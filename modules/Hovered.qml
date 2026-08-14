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
	opacity: {
		if (island.mode === "hovered") {
			return 1
		} else { return 0 }
	}
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
				color: theme.fg
				Behavior on color { ColorAnimation { duration: 100 } }
				Text {
					anchors.centerIn: parent
					text: index + 1
					color: workspace.isActive ? "#0A0E1A" : theme.white
					Behavior on color { ColorAnimation { duration: 100 } }
					font.pixelSize: 18
					font.family: "Jetbrains Mono"
				}	
				HoverHandler { 
					id: workpaceHitbox 
					onHoveredChanged: workspace.whover = hovered
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
		color: theme.primary // "#A855F7"
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
			color: theme.bg
			Behavior on color { ColorAnimation { duration: 100 } }
			font.pixelSize: 18
			font.family: "Jetbrains Mono"
		}	
	}
	Volume {}
	Player {}
}
