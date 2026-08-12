import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
		anchors.fill: parent
		opacity: island.mode === "wifi" ? 1 : 0
		Behavior on opacity { NumberAnimation { duration: 100 } }

		Item {
				anchors.fill: parent
				Rectangle {
					id: listComponent
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 100
					width: 430
					height: 285
					color: theme.fg
					radius: 15
					ScrollView {
						anchors.fill: parent
						ScrollBar.vertical.policy: ScrollBar.AsNeeded
							contentWidth: availableWidth
							Flickable {
								boundsBehavior: Flickable.DragAndOvershootBounds 
								ColumnLayout {
									id: list
									Repeater {
										model: 20
										Rectangle {
											width: 50
											height: 50
											}
											}

									}
							}
					}
				}
		}
}
