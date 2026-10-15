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
				model: 5
				Rectangle {
					color: activePage === index + 1 ? Qt.lighter(Colors.primary, 0.3) : (pageHover.hovered ? Colors.fg : Colors.bg)
					radius: 25
					width:  180
					height: 75
					HoverHandler { id: pageHover }
					Behavior on color { ColorAnimation { duration: 200 } }
					TapHandler {
						onTapped: activePage = index + 1
					}
					Text {
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: parent.left
						anchors.leftMargin: 20

						text: {
							switch (index) {
								case 0: return "Experimental"; break;
								case 1: return "Apearance"; break;
								case 2: return "Fonts"; break;
								case 3: return "Region"; break;
								case 4: return "Other"; break;
							}
						}
						color: activePage === index + 1 ? Colors.primary : Colors.white
						Behavior on color { ColorAnimation { duration: 200 } }
						font.pixelSize: 18
						font.family: "Roboto"
						font.weight: 500
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
			topMargin: 10
			bottomMargin: 10
			rightMargin: 10
		}
		width: 470
		radius: 10
		color: Colors.fg
		Loader {
			anchors.fill: parent
			source: {
				switch (activePage) {
					case 1: return "./ExperimentalPage.qml"; break;
					case 2: return "./ApearancePage.qml"; break;
					default: return ""; break;
				}
			}
		}
	}
}
