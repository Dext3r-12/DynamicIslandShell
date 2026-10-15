import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import "../services"

Item {
	id: menuHovered
	anchors.fill: parent
	opacity: island.mode === "hovered"
	Behavior on opacity { NumberAnimation { duration: 100 } }


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
				property bool isActive: Niri.workspaceIndex?.id === (index + 1)
				width: 30
				height: 30
				radius: 6
				color: Colors.fg
				Behavior on color { ColorAnimation { duration: 100 } }
				Text {
					anchors.centerIn: parent
					text: index + 1
					color: Colors.primary
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
		color: Colors.primary
		x: {
			if (Niri.workspaceIndex >= 5) {
				return 105 + 35 * 5
			}
			return 105 + 35 * Niri.workspaceIndex
		}
		Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutCubic}}
		Text {
			anchors.centerIn: parent
			text: Niri.workspaceIndex
			color: Colors.bg
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
				color: Colors.fg
				width: 10
				height: (CavaService.barsData[index + 3] / 2.5) + 10
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
				color: Colors.fg
				width: 10
				height: (CavaService.barsData[index] / 2.5) + 10
				radius: width / 2
				Behavior on height { NumberAnimation { duration: 20 }}
			}
		}
	}
/*
	Binding {
		target: CavaService
		property: "isCavaSixBarsRunning"
		value: island.mode === "hovered"
	}*/


	// Other
	Volume {}
	PlayerModule { id: playerWidget }
}
