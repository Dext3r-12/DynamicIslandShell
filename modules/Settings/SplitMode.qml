import QtQuick
import QtQuick.Shapes
import "../../services"
Item {
	anchors.fill: parent
	Rectangle {
		id: upperConnection
		height: 23
		width: island.implicitWidth
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
				centerX: 11 + island.implicitWidth
				centerY: 11
				radiusX: 17
				radiusY: 17
				startAngle: 180
				sweepAngle: 90
			}
		}
	}
	Shape {
		anchors.top: parent.top
		layer.enabled: true
		layer.samples: 6
		x: -23
		ShapePath {
			fillColor: "transparent"
			strokeColor: Colors.bg
			strokeWidth: 10
			PathAngleArc {
				centerX: 10
				centerY: 11
				radiusX: 17
				radiusY: 17
				startAngle: -90
				sweepAngle: 90
			}
		}
	}
}
