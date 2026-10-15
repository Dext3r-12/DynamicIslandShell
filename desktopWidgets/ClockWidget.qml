import Quickshell
import QtQuick
import QtQuick.Layouts

import "../services"
import "../widgets"


Rectangle {
	width: 230
	height: 110
	radius: 15
	opacity: 0.97
	color: Colors.bg
	anchors {
		left: parent.left
		top: parent.top
		leftMargin: 40
		topMargin: 30
	}
	Text {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		text: Qt.formatDateTime(new Date(), "hh:mm")
		color: Colors.white
		font.pixelSize: 62
		RowLayout {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: 70
			spacing: 5
			Text {
				text: Battery.percent
				color: Colors.white
				font.pixelSize: 24
				font.family: "Jetbrains Mono"
			}
			Battery {}
		}
	}
}
