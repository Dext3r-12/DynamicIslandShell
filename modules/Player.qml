import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import QtQuick
import qs

Item {
	Colors { id: theme }
	id: playerWidget
	Repeater {
		model: 8
		Rectangle {
			color: playerStat.text.trim() === "Playing" ? colors.primary : colors.fg
			Behavior on color { ColorAnimation { duration: 150 }}
			anchors.centerIn: playerButton
			width: 25
			height: 60
			radius: width / 2
			rotation: (index * 45)
			RotationAnimation on rotation {
				id: musicIndicator
				loops: Animation.Infinite
				from: rotation
				to: rotation + 360
				duration: 20000
				running: playerStat.text.trim() === "Playing"
			}
		}
	}
	anchors.fill: parent
	Rectangle {
		id: playerButton
		color: playerStat.text.trim() === "Playing" ? colors.primary : colors.fg
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
			text: playerStat.text.trim() === "Playing" ? "" : (playerStat.text.trim() === "Paused" ? "" : "󰎇")
			color: playerStat.text.trim() === "Playing" ? colors.bg : (playerStat.text.trim() === "Paused" ? colors.white : colors.white)
			Behavior on color { ColorAnimation { duration: 150 }}
			font.pixelSize: playerStat.text.trim() === "Playing" ? 30 : (playerStat.text.trim() === "Paused" ? 27 : 28)
		}
	}
	Process {
		id: playerToggle
		command: ["sh", "-c", "playerctl play-pause"]
		running: false
	}

	Process {
		id: playerStatus
		command: ["playerctl", "status"]
		stdout: StdioCollector { id: playerStat }
		running: true
	}

	    Timer {
		interval: 100
		repeat: true

		running: island.mode === "hovered"

		onTriggered: {
		    playerStatus.running = false;
		    playerStatus.running = true;
		}
	}
}
