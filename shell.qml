import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

PanelWindow {
	margins { top: 4 }
	anchors {
		top: true
	}
	color: "transparent"
	exclusionMode: exclusionMode.Normal
	exclusiveZone: 33
	implicitHeight: power.pmenu ? 70 : (stress.smenu ? 420 : (island.isHovered ? 85 : 33))
	implicitWidth: power.pmenu ? 400 : (stress.smenu ? 760 : (island.isHovered ? 450 : 250))
	Behavior on implicitHeight { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
	Behavior on implicitWidth  { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
	GlobalShortcut {
		id: power
		property bool pmenu: false
		name: "powerMenu"
		onPressed: {
			pmenu = !pmenu
			stress.smenu = false
		}
	}
	GlobalShortcut {
		id: stress
		property bool smenu: false
		name: "stressMenu"
		onPressed: {
			smenu = !smenu
			power.pmenu = false
		}
	}
	Item {
		id: island
		property bool isHovered: rootMouse.hovered

		anchors.fill: parent
		Rectangle {
			id: root

			anchors.fill: parent

			radius: 15

			color: "#0A0E1A"
			Clock {
				id: clocks
				anchors.top: parent.top
				anchors.topMargin: island.isHovered ? 3 : 7 
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: island.isHovered ? 40 : 14
				font.family: "Jetbrains Mono"
				opacity: power.pmenu ? 0 : (stress.smenu ? 0 : 1)
				Behavior on opacity { NumberAnimation { duration: 50} }
				Behavior on font.pixelSize { NumberAnimation {duration: 80} }
				Behavior on anchors.topMargin { NumberAnimation {duration: 80} }
			}

			HoverHandler { id: rootMouse }

			Stress {}
			Hovered {}
			PowerMenu {}
		}
	}
}




