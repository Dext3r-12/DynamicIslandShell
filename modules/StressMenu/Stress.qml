import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import QtQuick3D
import QtQuick3D.Helpers
import qs



Item {
	anchors.fill: parent
	opacity: island.mode === "stressMenu" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 100 }}
	Process {
		id: systemStats
		property string gpuName: "undefined"
		property string cpuName: "undefined"
		property string ramAmount: "undefined"
		command: ["sh", "-c", "~/.config/quickshell/scripts/systemInfo"]
		running: true
		stdout: StdioCollector { 
			id: systemStat
				onStreamFinished: {
					var statistics = systemStat.text.trim().split('|')
					systemStats.cpuName = statistics[0]
					systemStats.gpuName = statistics[1]
					systemStats.ramAmount = statistics[2]
				}
			}
		}
	Process {
		id: usageStats
		running: true
		property string cpuUsage: "nan"
		property string gpuUsage: "nan"
		property string ramUsage: "nan"
		command: ["sh", "-c", "~/.config/quickshell/scripts/usageInfo"]
		stdout: StdioCollector { 
				id: usageStatistics 
				onStreamFinished: {
					var usageStat = usageStatistics.text.trim().split('|')
					usageStats.cpuUsage = usageStat[0].slice(0, -2)
					usageStats.gpuUsage = usageStat[1].slice(1, -2)
					usageStats.ramUsage = usageStat[2].slice(1, -1)
				}
			}
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
		color: colors.fg
	}
	Row {
		spacing: 30
		anchors {
			top: parent.top
			right: parent.right

			topMargin: 50
			rightMargin: 50
		}
		Rectangle {
			width: 60
			height: width
			radius: width / 2
			color: colors.fg1
			Text {
				opacity: cpuUsageHover.hovered ? 1 : 0
				color: "white"
				text: usageStats.cpuUsage
				font.pixelSize: 30
				font.family: "Jetbrains Mono"
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			Text {
				
				opacity: cpuUsageHover.hovered ? 0 : 1
				color: "white"
				text: ""
				font.pixelSize: 30
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			HoverHandler { id: cpuUsageHover; enabled: island.mode === "stressMenu"}

			Shape {
				anchors.centerIn: parent
				//layer.enabled: true
				layer.samples: 6
				ShapePath {
					fillColor: "transparent"
					strokeColor: "white"
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathAngleArc {
						centerX: 33
						centerY: 34
						radiusX: 30
						radiusY: radiusX
						startAngle: -90
						sweepAngle: usageStats.cpuUsage * 3.6
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

		Rectangle {
			width: 60
			height: width
			radius: width / 2
			color: colors.fg1
			Text {
				opacity: gpuUsageHover.hovered ? 1 : 0
				color: "white"
				text: usageStats.gpuUsage
				font.pixelSize: 30
				font.family: "Jetbrains Mono"
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			Text {
				
				opacity: gpuUsageHover.hovered ? 0 : 1
				color: "white"
				text: "󰢮" 
				font.pixelSize: 30
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			HoverHandler { id: gpuUsageHover; enabled: island.mode === "stressMenu"}

			Shape {
				anchors.centerIn: parent
				//layer.enabled: true
				layer.samples: 6
				ShapePath {
					fillColor: "transparent"
					strokeColor: "white"
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathAngleArc {
						centerX: 31
						centerY: 31
						radiusX: 30
						radiusY: radiusX
						startAngle: -90
						sweepAngle: usageStats.gpuUsage * 3.6
					}
				}
				ShapePath {
					fillColor: "transparent"
					strokeColor: "transparent"
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathAngleArc {
						centerX: 31
						centerY: 31
						radiusX: 30
						radiusY: radiusX
						startAngle: -90
						sweepAngle: 360
					}
				}
			}
		}
		Rectangle {
			width: 60
			height: width
			radius: width / 2
			color: colors.fg1
			Text {
				opacity: ramUsageHover.hovered ? 1 : 0
				color: "white"
				text: usageStats.ramUsage
				font.pixelSize: 24
				font.family: "Jetbrains Mono"
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			Text {
				
				opacity: ramUsageHover.hovered ? 0 : 1
				color: "white"
				text: "" 
				font.pixelSize: 30
				anchors.centerIn: parent
				Behavior on opacity { NumberAnimation { duration: 200}}
			}
			HoverHandler { id: ramUsageHover; enabled: island.mode === "stressMenu"}

			Shape {
				anchors.centerIn: parent
				//layer.enabled: true
				layer.samples: 6
				ShapePath {
					fillColor: "transparent"
					strokeColor: "white"
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathAngleArc {
						centerX: 31
						centerY: 31
						radiusX: 30
						radiusY: radiusX
						startAngle: -90
						sweepAngle: usageStats.ramUsage * 24
					}
				}
				ShapePath {
					fillColor: "transparent"
					strokeColor: "transparent"
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathAngleArc {
						centerX: 31
						centerY: 31
						radiusX: 30
						radiusY: radiusX
						startAngle: -90
						sweepAngle: 360
					}
				}
			}
		}
		Timer {
			running: island.mode === "stressMenu"
			repeat: true
			interval: 1500
			onTriggered: {
				usageStats.running = false
				usageStats.running = true

				l1.y = l2.y
				l2.y = l3.y
				l3.y = l4.y
				l4.y = l5.y
				l5.y = l6.y
				l6.y = l7.y
				l7.y = l8.y
				l8.y = l9.y
				l9.y = l10.y

				g1.y = g2.y
				g2.y = g3.y
				g3.y = g4.y
				g4.y = g5.y
				g5.y = g6.y
				g6.y = g7.y
				g7.y = g8.y
				g8.y = g9.y
				g9.y = g10.y
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
			color: colors.fg
			Text {
				text: "CPU"
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: parent.top
					topMargin: 5
				}
				color: colors.white
				font.pixelSize: 44
				font.family: "Jetbrains Mono"
				Text {
					anchors {
						horizontalCenter: parent.horizontalCenter
						top: parent.top
						topMargin: 45
					}
					text: "Usage"
					color: colors.white
					font.pixelSize: 24
					font.family: "Jetbrains Mono"
				}
			}
			Shape {
				anchors.fill: parent
				anchors.bottom: parent.bottom
				ShapePath {
					capStyle: ShapePath.RoundCap
					startX: 10 
					startY: l1.y
					strokeWidth: 3
					fillColor: "transparent"
					PathLine { x: 10; y: 120; id: l1 }
					PathLine { x: 30; y: 120; id: l2 }
					PathLine { x: 60; y: 120; id: l3  }
					PathLine { x: 90; y: 120; id: l4  }
					PathLine { x: 120; y: 120; id: l5  }
					PathLine { x: 150; y: 120; id: l6  }
					PathLine { x: 180; y: 120; id: l7  }
					PathLine { x: 210; y: 120; id: l8  }
					PathLine { x: 240; y: 120; id: l9  }
					PathLine { x: 250; y: usageStats.cpuUsage * -1 + 120; id: l10 }
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
			color: colors.fg
			Text {
				text: "GPU"
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: parent.top
					topMargin: 5
				}
				color: colors.white
				font.pixelSize: 44
				font.family: "Jetbrains Mono"
				Text {
					anchors {
						horizontalCenter: parent.horizontalCenter
						top: parent.top
						topMargin: 45
					}
					text: "Usage"
					color: colors.white
					font.pixelSize: 24
					font.family: "Jetbrains Mono"
				}
			}
			Shape {
				anchors.fill: parent
				anchors.bottom: parent.bottom
				ShapePath {
					capStyle: ShapePath.RoundCap
					startX: 10 
					startY: g1.y
					strokeWidth: 3
					fillColor: "transparent"
					PathLine { x: 10; y: 120; id: g1 }
					PathLine { x: 30; y: 120; id: g2 }
					PathLine { x: 60; y: 120; id: g3  }
					PathLine { x: 90; y: 120; id: g4  }
					PathLine { x: 120; y: 120; id: g5  }
					PathLine { x: 150; y: 120; id: g6  }
					PathLine { x: 180; y: 120; id: g7  }
					PathLine { x: 210; y: 120; id: g8  }
					PathLine { x: 240; y: 120; id: g9  }
					PathLine { x: 250; y: usageStats.gpuUsage * -1 + 120; id: g10 }
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
					strokeColor: cpuHover.hovered ? colors.primary : "transparent"
					Behavior on strokeColor { ColorAnimation { duration: 200}}
					strokeWidth: 4
					capStyle: ShapePath.RoundCap
					PathLine { x: cpuHover.hovered ? 200 : 300; 
					y: 190
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				}
				PathLine { x: cpuHover.hovered ? 300 : 400; 
				y: 190
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
			}
				}
				Rectangle {
					opacity: cpuHover.hovered ? 1 : 0
					width: 180
					height: 70
					x: cpuHover.hovered ? 300 : 400
					y: 157
					radius: 7
					color: colors.fg
					border.width: 5
					border.color: colors.primary
					Behavior on opacity { NumberAnimation { duration: 200}}
					Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
					Text {
						anchors.centerIn: parent
						text: systemStats.cpuName
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


			ShapePath {
				startX: 200
				startY: 130
				fillColor: "transparent"
				strokeColor: ramHover.hovered ? colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 200}}
				PathLine { x: ramHover.hovered ? 250 : 300; 
				y: 90;
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
			       }
			       PathLine { x: ramHover.hovered ? 300 : 400; y: 90
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
		       }
			}
			Rectangle {
				opacity: ramHover.hovered ? 1 : 0
				width: 150
				height: 40
				x: ramHover.hovered ? 300 : 400
				y: 57
				color: colors.fg
				border.width: 5
				border.color: colors.primary
				radius: 7
				Behavior on opacity { NumberAnimation { duration: 200}}
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				Text {
					anchors.centerIn: parent
					text: systemStats.ramAmount
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


			ShapePath {
				startX: 157
				startY: 209
				fillColor: "transparent"
				strokeColor: gpuHover.hovered ? colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 500; easing.type: Easing.OutCubic}}
				PathLine { x: gpuHover.hovered ? 250 : 350; 
				y: 290
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
			}
			PathLine { x: gpuHover.hovered ? 300 : 400; y: 290
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
				color: colors.fg
				border.width: 5
				border.color: colors.primary
				Behavior on opacity { NumberAnimation { duration: 200}}
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
				Text {
					anchors.centerIn: parent
					text: systemStats.gpuName
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
			ShapePath {
				startX: 290
				startY: 300
				fillColor: "transparent"
				strokeColor: diskHover.hovered ? colors.primary : "transparent"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				Behavior on strokeColor { ColorAnimation { duration: 500; easing.type: Easing.OutCubic}}
				PathLine { x: diskHover.hovered ? 320 : 450; 
				y: 280
				Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutCubic}}
			}
			PathLine { x: diskHover.hovered ? 320 : 450; y: 257
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
				color: colors.fg
				border.width: 5
				border.color: colors.primary
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
