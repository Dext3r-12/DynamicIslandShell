import Quickshell
import QtQuick

import "../services"

Rectangle {
	id: toggleWidget

	property bool toggle: false

	function toggleSwitch() {
		toggle = !toggle
		return toggle
	}
	width: 50
	height: 28
	radius: height / 2
	color: toggle ? Colors.primary : Colors.fg1
	Behavior on color { 
		ColorAnimation { 
			duration: 250
			easing.type: Easing.OutCubic
		} 
	}
	Rectangle {
		width: height
		height: toggleWidget.height - 5
		radius: height / 2
		anchors.verticalCenter: parent.verticalCenter
		x: toggle ? toggleWidget.width - (width * 1.2) : width / 5
		color: toggle ? Colors.fg1 : Colors.primary
		Behavior on color { 
			ColorAnimation { 
				duration: 250
				easing.type: Easing.OutCubic
			} 
		}
		Behavior on x { 
			NumberAnimation { 
				duration: 350
				easing.type: Easing.OutBack
			} 
		}
		/*
		Rectangle {
			anchors.centerIn: parent
			width: 10
			height: 2
			color: toggle ? Colors.primary : Colors.fg1
			rotation: toggle ? -45 : 0
			radius: width / 2
			Behavior on rotation { 
				NumberAnimation { 
					duration: 350
					easing.type: Easing.OutBack
				} 
			}
			Rectangle {
				anchors.bottom: parent.left
				width: 10
				height: 2
				color: toggle ? Colors.primary : Colors.fg1
				rotation: toggle ? -90 : 0
				radius: width / 2
				Behavior on rotation { 
					NumberAnimation { 
						duration: 350
						easing.type: Easing.OutBack
					} 
				}
			}
		}
		*/
	}
}
