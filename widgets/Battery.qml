import Quickshell
import QtQuick

import "../services"

Rectangle {
	id: batteryBase
	width: 35
	height: 20
	radius: 3
	color: Colors.fg1
	Rectangle {
		anchors.left: parent.left
		width: Battery.percent * (batteryBase.width / 100)
		height: batteryBase.height
		radius: 5
		color: Colors.primary
	}
	Rectangle {
		anchors.left: parent.right
		anchors.leftMargin: 3
		anchors.verticalCenter: parent.verticalCenter
		width: batteryBase.width / 6.5
		height: batteryBase.height / 1.7
		radius: 3
		color: Battery.percent === 100 ? Colors.primary : Colors.fg1
	}
}
