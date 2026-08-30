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
			color: playerStatus.isPlaying ? Colors.primary : Colors.fg
			Behavior on color { ColorAnimation { duration: 150 }}
			Behavior on height { NumberAnimation { duration: 20 }}
			anchors.centerIn: playerButton
			width: 25
			height: 60 + (CavaService.sixBarsData[index] / 6)
			radius: width / 2
			rotation: (index * 45)
			RotationAnimation on rotation {
				id: musicIndicator
				loops: Animation.Infinite
				from: rotation
				to: rotation + 360
				duration: 20000
				running: playerStatus.isPlaying			}
		}
	}
	anchors.fill: parent
	Rectangle {
		id: playerButton
		color: playerStatus.isPlaying ? Colors.primary : Colors.fg
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
			onTapped: {
				playerToggle.running = false
				playerToggle.running = true
			}
		}
		property bool musicPlaying: false

		Text {
			anchors.centerIn: parent
			text: playerStatus.isPlaying ? "" : ( playerStatus.isPaused ? "" : "󰎇")
			color: playerStatus.isPlaying ? Colors.bg : Colors.white
			Behavior on color { ColorAnimation { duration: 150 }}
			font.pixelSize: playerStatus.isPlaying ? 30 : ( playerStatus.isPlaying ? 27 : 28)
		}
	}
	Process {
		id: playerToggle
		command: ["sh", "-c", "playerctl play-pause"]
		running: false
	}

	Process {
		property bool isPlaying: false
		property bool isPaused: false
		id: playerStatus
		command: ["playerctl", "status", "-F"]
		stdout: SplitParser {
			onRead: data => {
				playerStatus.isPlaying = data === "Playing" ? true : false
				playerStatus.isPaused = data === "Paused" ? true : false
				}
			}
		running: island.mode === "hovered"
	}
}

