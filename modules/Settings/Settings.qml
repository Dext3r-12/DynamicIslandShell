import Quickshell
import QtQuick
import QtQuick.Layouts

import "../../services"

FloatingWindow {
	color: Colors.bg

	property int activePage: 1
	
	title: "Settings-menu-quickshell"

	Rectangle {
		anchors {
			left: parent.left
			top: parent.top
			bottom: parent.bottom
		}
		width: 300
		color: Colors.bg
		ColumnLayout {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter

			anchors.leftMargin: 15
			spacing: 5
			Repeater {
				model: 10
				Rectangle {
					color: activePage === index + 1 ? Colors.primary : (pageHover.hovered ? Colors.fg : Colors.bg)
					radius: width / 2
					width: 180
					height: 55
					HoverHandler { id: pageHover }
					TapHandler {
						onTapped: activePage = index + 1
					}
					Text {
						anchors.centerIn: parent

						text: index + " page"
						color: activePage === index + 1 ? Colors.bg : Colors.white
						font.pixelSize: 18
						font.family: "Roboto"
					}
				}
			}
		}
	}
	Rectangle {
		anchors {
			right: parent.right
			top: parent.top
			bottom: parent.bottom
		}
	}
}
