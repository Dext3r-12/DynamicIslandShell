import Quickshell
import QtQuick
import QtQuick.Layouts

import "../services"

Rectangle {
	width: 350
	height: 150
	radius: 15
	opacity: 0.97
	color: Colors.bg
	anchors.bottom: parent.bottom
	anchors.left: parent.left
	anchors.bottomMargin: 100
	anchors.leftMargin: 55
	RowLayout {
		anchors.centerIn: parent
		Repeater {
			Layout.alignment: Qt.AlignVCenter
			model: 6
			Rectangle {
				anchors.verticalCenter: parent.verticalCenter
				height: CavaService.barsData[index]
				width: 350 / 7
			}
		}
	}
}
