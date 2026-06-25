import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import QtQuick.Shapes

Item {
	id: menuHovered
	anchors.fill: parent
	opacity: power.pmenu ? 0 : (stress.smenu ? 0 : (island.isHovered ? 1 : 0))
	Behavior on opacity { NumberAnimation { duration: 100 } }
	RowLayout {
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 50
		}
		spacing: 5
		
		Repeater {
			model: 5
			Rectangle {
				id: workspace
				property bool whover: false
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				width: 30
				height: 30
				radius: 6
				color: workspace.isActive ? "#A855F7" : "#151B2D"
				Behavior on color { ColorAnimation { duration: 100 } }
				Text {
					anchors.centerIn: parent
					text: index + 1
					color: workspace.isActive ? "#0A0E1A" : "white"
					Behavior on color { ColorAnimation { duration: 100 } }
					font.pixelSize: 18
					font.family: "Jetbrains Mono"
				}	
				HoverHandler { 
					id: workpaceHitbox 
					onHoveredChanged: workspace.whover = hovered
				}
				TapHandler { onTapped: {
					let wnum = index + 1
					Hyprland.dispatch("workspace " + (index + 1))
				}}


			}
		}
	}
	Player {}

	//////////
	//VOLUME//
	//////////
	
	Rectangle {
		id: volBG
		anchors {
		    verticalCenter: parent.verticalCenter
		    left: parent.left
		    leftMargin: 15
		}
		width: 55
		height: 55
		radius: width / 2
		color: "#151B2D"
		HoverHandler { id: volHover }
		MouseArea {
			anchors.fill: parent
			onWheel: (wheel) => {
				if (wheel.angleDelta.y > 0) {
					volWheel.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"]
				} else if (wheel.angleDelta.y < 0) {
					volWheel.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]
				}
				volWheel.running = false
				volWheel.running = true
				wheel.accepted = true
			}
			onClicked: {
				volWheel.command = ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
				volWheel.running = false
				volWheel.running = true
			}
		}
		Process { id: volWheel }
		Rectangle {
			width: 3
			height: isMuted ? 40 : 0
			radius: 5
			anchors.centerIn: parent

			rotation: 40

			Behavior on height { NumberAnimation { duration: 200; easing.type: Easing.OutCubic} }
		}
		Shape {
			anchors.centerIn: parent
			layer.enabled: true
			layer.samples: 6
			ShapePath {
				fillColor: "transparent"
				strokeColor: "white"
				strokeWidth: 4
				capStyle: ShapePath.RoundCap
				PathAngleArc {
					centerX: 31
					centerY: 31
					radiusX: 27
					radiusY: 27

					startAngle: -90
					sweepAngle: volumeText * 3.6
					Behavior on sweepAngle { NumberAnimation { duration: 150; easing.type: Easing.OutCubic }}
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
					radiusY: 30

					startAngle: -90
					sweepAngle: 360
				}
			}
		}
	}
	    property bool isExpanded: false
	    property bool isMuted: false

	    property string volumeText: "0"

	    Text {
		id: volValue
		color: "white"
		font.pixelSize: 22
		font.family: "Jetbrains Mono"
		anchors {
		    centerIn: volBG
		}
		text: volumeText
		opacity: volHover.hovered ? 1 : 0
		Behavior on opacity { NumberAnimation { duration: 150}}
	    }
	    Text {
		color: "white"
		font.pixelSize: 20
		anchors {
		    centerIn: volBG
		}
		text: ""
		opacity: volHover.hovered ? 0 : 1
		Behavior on opacity { NumberAnimation { duration: 150}}
	    }

	    Process {
		id: volReader
		command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

		stdout: SplitParser {
		    onRead: data => {
			let trimmed = data.trim();
			if (!trimmed) return;

			if (trimmed.includes("[MUTED]")) {
			    //volumeText = "M";
			    isMuted = true
			} else {
			    isMuted = false
			    let match = trimmed.match(/Volume:\s+([0-9.]+)/);
			    if (match) {
				volumeText = String(Math.round(parseFloat(match[1]) * 100));
			    }
			}
		    }
		}
	    }

	    onIsExpandedChanged: {
		if (isExpanded) {
		    volReader.running = false;
		    volReader.running = true;
		}
	    }

	    Timer {
		interval: 60
		repeat: true

		running: island.isHovered

		onTriggered: {
		    volReader.running = false;
		    volReader.running = true;

		}
	}
}
