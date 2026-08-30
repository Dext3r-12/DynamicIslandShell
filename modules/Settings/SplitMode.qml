import QtQuick
import QtQuick.Shapes
import "../../services"
Item {
	anchors.fill: parent
	Rectangle {
		id: upperConnection
		anchors.horizontalCenter: parent.horizontalCenter
		height: 23
		width: root.implicitWidth
		color: Colors.bg
	}
	Shape {
		anchors.top: parent.top
		layer.enabled: true
		layer.samples: 6
		ShapePath {
			fillColor: "transparent"
			strokeColor: Colors.bg
			strokeWidth: 10
			PathAngleArc {
				centerX: 391 + (root.implicitWidth / 2)
				centerY: 11
				radiusX: 17
				radiusY: 17
				startAngle: -180
				sweepAngle: 90
				Behavior on sweepAngle { NumberAnimation { duration: 150; easing.type: Easing.OutCubic }}
			}
		}
	}
	Shape {
		anchors.top: parent.top
		layer.enabled: true
		layer.samples: 6
		ShapePath {
			fillColor: "transparent"
			strokeColor: Colors.bg
			strokeWidth: 10
			PathAngleArc {
				centerX: 367 - (root.implicitWidth / 2)
				centerY: 11
				radiusX: 17
				radiusY: 17
				startAngle: -90
				sweepAngle: 90
				Behavior on sweepAngle { NumberAnimation { duration: 150; easing.type: Easing.OutCubic }}
			}
		}
	}
}
