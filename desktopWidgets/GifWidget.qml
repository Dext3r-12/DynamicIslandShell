import Quickshell
import QtQuick

import "../services"

Rectangle {
	anchors.left: parent.left
	anchors.top: parent.top
	anchors.leftMargin: 90
	anchors.topMargin: 230
	width: 250
	height: 170
	radius: 15
	opacity: 0.97
	color: Colors.bg
	AnimatedImage {
		source: "/home/dext3r/.config/quickshell/assets/Bongo-cat.gif"
		anchors.centerIn: parent
		fillMode: Image.PreserveAspectFit
		width: 200
		playing: Player.isPlaying
	}
}
