import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import QtQuick3D
import QtQuick3D.Helpers

import "../../services"

Item {
	anchors.fill: parent
	opacity: island.mode === "stressMenu" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 100 }}
	Binding {
		target: System
		property: "systemInfoToggle"
		value: island.mode === "stressMenu"
	}
	Binding {
		target: System
		property: "usageToggle"
		value: island.mode === "stressMenu"
	}
	Rectangle {
	 
		anchors {
			top: parent.top
			right: parent.right

			topMargin: 40
			rightMargin: 40
		}
		height: 80
		width: 260
		radius: 10
		color: Colors.fg
	}
	Row {
		spacing: 30
		anchors {
			top: parent.top
			right: parent.right

			topMargin: 50
			rightMargin: 50
		}
		Repeater {
			model: 3
			Rectangle {
				width: 60
				height: width
				radius: width / 2
				color: Colors.fg1
				HoverHandler { id: cpuUsageHover; enabled: island.mode === "stressMenu"}
				Text {
					opacity: cpuUsageHover.hovered ? 1 : 0
					color: "white"
					text: {
						switch (index) {
							case 0: return System.cpuUsage; break;
							case 1: return System.gpuUsage; break;
							case 2: return System.ramUsage; break;
							}
						}
					font.pixelSize: 30
					font.family: "Jetbrains Mono"
					anchors.centerIn: parent
					Behavior on opacity { NumberAnimation { duration: 200}}
				}

				Text {
					opacity: cpuUsageHover.hovered ? 0 : 1
					color: Colors.white
					text: {
						switch (index) {
							case 0: return "" ; break;
							case 1: return "" ; break;
							case 2: return "" ; break;
							}
						}
					font.pixelSize: index === 1 ? 42 : 30
					font.family: Fonts.iconFont.name
					anchors.centerIn: parent
					Behavior on opacity { NumberAnimation { duration: 200}}
				}

				Shape {
					anchors.centerIn: parent
					layer.samples: 6
					ShapePath {
						fillColor: "transparent"
						strokeColor: Colors.white
						strokeWidth: 4
						capStyle: ShapePath.RoundCap
						PathAngleArc {
							centerX: 33
							centerY: 34
							radiusX: 30
							radiusY: radiusX
							startAngle: -90
							Behavior on sweepAngle {NumberAnimation{ duration: 500; easing.type: Easing.OutCubic}}
							sweepAngle: {
								switch (index) {
									case 0: return System.cpuUsage * 3.6 ; break;
									case 1: return System.gpuUsage * 3.6; break;
									case 2: return System.ramUsage * 24; break;
								}
							}
						}
					}
					ShapePath {
						fillColor: "transparent"
						strokeColor: "transparent"
						strokeWidth: 4
						capStyle: ShapePath.RoundCap
						PathAngleArc {
							centerX: 31
							centerY: 34
							radiusX: 30
							radiusY: radiusX
							startAngle: -90
							sweepAngle: 360
						}
					}
				}
			}
		}

		Timer {
			running: island.mode === "stressMenu"
			repeat: true
			interval: 1500
			onTriggered: {

			}
		}
	}

	Item {
		anchors.fill: parent
		Rectangle {
			anchors {
				right: parent.right
				rightMargin: 40
				bottom: parent.bottom
				bottomMargin: 40
			}
			width: 260
			height: 120
			radius: 10
			color: Colors.fg
			Text {
				text: "CPU"
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: parent.top
					topMargin: 5
				}
				color: Colors.white
				font.pixelSize: 44
				font.family: "Jetbrains Mono"
				Text {
					anchors {
						horizontalCenter: parent.horizontalCenter
						top: parent.top
						topMargin: 45
					}
					text: "Usage"
					color: Colors.white
					font.pixelSize: 24
					font.family: "Jetbrains Mono"
				}
			}
			Shape {
				anchors.fill: parent
				anchors.bottom: parent.bottom
				ShapePath {
					id: cpuGraph
					capStyle: ShapePath.RoundCap
					startX: 10
					startY: System.cpuUsageGraphData[0] * -1 + 120
					strokeColor: Colors.white
					strokeWidth: 3
					fillColor: "transparent"
					PathSvg {
						path: {
							let dots = []
							for ( let i = 1; i < 20; i++) {
								let x = 250 - (250 - ((250 / 19) * i))
								let y = System.cpuUsageGraphData[i] * -1 + 120
								
								dots += " L " + x + " " + y + " "
							}
							return dots
						}
					}
				}
			}
		}
	}
	Item {
		anchors.fill: parent
		Rectangle {
			anchors {
				right: parent.right
				rightMargin: 40
				bottom: parent.bottom
				bottomMargin: 170
			}
			width: 260
			height: 120
			radius: 10
			color: Colors.fg
			Text {
				text: "GPU"
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: parent.top
					topMargin: 5
				}
				color: Colors.white
				font.pixelSize: 44
				font.family: "Jetbrains Mono"
				Text {
					anchors {
						horizontalCenter: parent.horizontalCenter
						top: parent.top
						topMargin: 45
					}
					text: "Usage"
					color: Colors.white
					font.pixelSize: 24
					font.family: "Jetbrains Mono"
				}
			}
			Shape {
				anchors.fill: parent
				anchors.bottom: parent.bottom
				ShapePath {
					id: gpuGraph
					property var data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
					capStyle: ShapePath.RoundCap
					startX: 10
					startY: System.gpuUsageGraphData[0] * -1 + 120
					strokeWidth: 3
					strokeColor: Colors.white
					fillColor: "transparent"
					PathSvg {
						path: {
							let dots = []
							for ( let i = 1; i < 20; i++) {
								let x = 250 - (250 - ((250 / 19) * i))
								let y = System.gpuUsageGraphData[i] * -1 + 120
								
								dots += " L " + x + " " + y + " "
							}
							return dots
						}
					}
				}
			}
		}
	}








	View3D {
		id: viewComp
		anchors {
			left: parent.left
			top: parent.top
			bottom: parent.bottom
			leftMargin: 30
		}
		width: 350

		PointLight {
			eulerRotation.x: -30
			eulerRotation.y: -10
			brightness: 10
		}
		DirectionalLight {
			eulerRotation.x: -30
			eulerRotation.y: -10
			brightness: 10
		}
		PerspectiveCamera {
			id: camera
			z: 20
			eulerRotation.x: -10
			y: 10
		}
		Connections {
			target: stress
			function onPressed() {
				computaAnim.restart()
			}
		
		}
		Computer {
			scale: Qt.vector3d(3.5, 3.5, 3.5)
			SequentialAnimation on eulerRotation.y {
				id: computaAnim
				NumberAnimation {
					from: 360
					to: 70
					duration: 1500
					easing.type: Easing.OutCubic
				}
				SequentialAnimation {
					loops: Animation.Infinite
					NumberAnimation {
						from: 70
						to: 75
						duration: 1500
						easing.type: Easing.InOutQuad
					}
					NumberAnimation {
						from: 75
						to: 70
						duration: 1500
						easing.type: Easing.InOutQuad
					}
				}
			}
		}
		Shape {
			anchors.fill: parent
				ShapePath {
					startX: 135
					startY: 130
					fillColor: "transparent"
					strokeColor: cpuHover.hovered ? Colors.primary : "transparent"
					Behavior on strokeColor { ColorAnimation { duration: 200}}
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathLine { 
						x: cpuHover.hovered ? 200 : 300; 
						y: 190
						Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
					}
					PathLine { 
						x: cpuHover.hovered ? 300 : 400; 
						y: 190
						Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
					}
				}

				// //////////////////////////////////////////////////// //
				// Cpu Information when you hovering cpu on 3d computer //
				// //////////////////////////////////////////////////// //

				Rectangle {
					opacity: cpuHover.hovered ? 1 : 0
					width: 180
					height: 70
					x: cpuHover.hovered ? 300 : 400
					y: 157
					radius: 7
					color: Colors.fg
					border.width: 5
					border.color: Colors.primary
					Behavior on opacity { NumberAnimation { duration: 200}}
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
					Text {
						anchors.centerIn: parent
						text: System.cpuName
						color: "white"
						font.pixelSize: 15
						font.family: "Jetbrains Mono"
						width: 150
						wrapMode: Text.WordWrap
						horizontalAlignment: Text.AlignHCenter
					}
				}
				Rectangle {
					width: 20
					height: 20
					x: 125
					y: 120
					color: "transparent"
					HoverHandler { id: cpuHover; enabled: island.mode === "stressMenu" }
				}

				// //////////////////////////////////////////////////// //
				// Ram Information when you hovering cpu on 3d computer //
				// //////////////////////////////////////////////////// //

			ShapePath {
				startX: 200
				startY: 130
				fillColor: "transparent"
				strokeColor: ramHover.hovered ? Colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 200}}
				PathLine { 
					x: ramHover.hovered ? 250 : 300; 
					y: 90;
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
				PathLine { 
					x: ramHover.hovered ? 300 : 400; 
					y: 90
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
			}
			Rectangle {
				opacity: ramHover.hovered ? 1 : 0
				width: 150
				height: 40
				x: ramHover.hovered ? 300 : 400
				y: 57
				color: Colors.fg
				border.width: 5
				border.color: Colors.primary
				radius: 7
				Behavior on opacity { NumberAnimation { duration: 200}}
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				Text {
					anchors.centerIn: parent
					text: System.ramAmount
					color: "white"
					font.pixelSize: 15
					font.family: "Jetbrains Mono"
					width: 200
					wrapMode: Text.WordWrap
					horizontalAlignment: Text.AlignHCenter
				}
			}
			Rectangle {
				width: 40
				height: 60
				x: 170
				y: 120
				color: "transparent"
				HoverHandler { id: ramHover; enabled: island.mode === "stressMenu"}
			}

				// ///////////////////////////////////////////////////// //
				// Gpu Information when you hovering cpu on 3d computer  //
				// ///////////////////////////////////////////////////// //

			ShapePath {
				startX: 157
				startY: 209
				fillColor: "transparent"
				strokeColor: gpuHover.hovered ? Colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 500; easing.type: Easing.OutCubic}}
				PathLine { 
					x: gpuHover.hovered ? 250 : 350; 
					y: 290
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
				PathLine { 
					x: gpuHover.hovered ? 300 : 400; 
					y: 290
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
			}
			Rectangle {
				opacity: gpuHover.hovered ? 1 : 0
				width: 250
				height: 50
				x: gpuHover.hovered ? 300 : 400
				y: 257
				radius: 7
				color: Colors.fg
				border.width: 5
				border.color: Colors.primary
				Behavior on opacity { NumberAnimation { duration: 200}}
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				Text {
					anchors.centerIn: parent
					text: System.gpuName
					color: "white"
					font.pixelSize: 15
					font.family: "Jetbrains Mono"
					width: 200
					wrapMode: Text.WordWrap
					horizontalAlignment: Text.AlignHCenter
				}
			}
			Rectangle {
				width: 100
				height: 20
				x: 90
				y: 190
				color: "transparent"
				HoverHandler { id: gpuHover; enabled: island.mode === "stressMenu" }
			}

				// ///////////////////////////////////////////////////// //
				// Disk Information when you hovering cpu on 3d computer //
				// ///////////////////////////////////////////////////// //

			ShapePath {
				startX: 290
				startY: 300
				fillColor: "transparent"
				strokeColor: diskHover.hovered ? Colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 500; easing.type: Easing.OutCubic}}
				PathLine { 
					x: diskHover.hovered ? 320 : 450; 
					y: 280
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
				PathLine { 
					x: diskHover.hovered ? 320 : 450; 
					y: 257
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
			}
			Rectangle {
				opacity: diskHover.hovered ? 1 : 0
				width: 250
				height: 250
				x: diskHover.hovered ? 300 : 400
				y: 7
				radius: 7
				color: Colors.fg
				border.width: 5
				border.color: Colors.primary
				Behavior on opacity { NumberAnimation { duration: 200}}
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				//Disks {}
			}
			Rectangle {
				width: 70
				height: 80
				x: 230
				y: 270
				color: "transparent"
				HoverHandler { id: diskHover; enabled: island.mode === "stressMenu" }
			}
		}
	}
}
