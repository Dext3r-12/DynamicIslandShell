import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import QtQuick

import "../services"

Item {
	id: playerWidget
	Repeater {
		model: 8
		Rectangle {
			id: playerPetals
			color: Player.isPlaying ? Colors.primary : Colors.fg
			Behavior on color { ColorAnimation { duration: 150 }}
			Behavior on height { NumberAnimation { duration: 20 }}
			anchors.centerIn: playerButton
			width: 25
			height: Configuration.flexPlayer ? 60 + (CavaService.barsData[index] / 6) : 60
			radius: width / 2
			rotation: (index * 45)
			RotationAnimation on rotation {
				id: musicIndicator
				loops: Animation.Infinite
				from: rotation
				to: rotation + 360
				duration: 20000
				running: Player.isPlaying			
			}
		}
	}
	anchors.fill: parent
	Rectangle {
		id: playerButton
		color: Player.isPlaying ? Colors.primary : Colors.fg
		Behavior on color { ColorAnimation { duration: 150 }}
		anchors {
			right: parent.right
			verticalCenter: parent.verticalCenter
			rightMargin: 15
		}
		width: 50
		height: 50
		radius: 25
		TapHandler { 
			enabled: island.mode === "hovered"
			onTapped: Player.playToggle = !Player.playToggle
		}

		Text {
			anchors.centerIn: parent
			text: Player.isPlaying ? "" : ( !Player.isPlaying ? "" : "󰎇")
			color: Player.isPlaying ? Colors.bg : Colors.white
			Behavior on color { ColorAnimation { duration: 150 }}
			font.pixelSize: Player.isPlaying ? 30 : ( Player.isPlaying ? 27 : 28)
		}
	}
}

