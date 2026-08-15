import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import qs.modules
import qs.modules.StressMenu

PanelWindow {
	id: panelWindow
	margins { top: 4 }
	anchors {
		top: true
	}
	color: "transparent"
	exclusiveZone: 33
	implicitWidth: 760
	implicitHeight: 430
	GlobalShortcut {
		id: controlPanel
		name: "ControlPanel"
		onPressed: {
			if (island.mode === "controlPanel") { island.mode = "idle" }
			else { island.mode = "controlPanel" }
		}
	}
	GlobalShortcut {
		id: power
		name: "powerMenu"
		onPressed: {
			if (island.mode === "powerMenu") { island.mode = "idle" }
			else { island.mode = "powerMenu" }
		}
	}
	GlobalShortcut {
		id: search
		name: "Search"
		onPressed: {
			if (island.mode === "search") { island.mode = "idle" }
			else { island.mode = "search" }
		}
	}
	GlobalShortcut {
		id: stress
		name: "stressMenu"
		onPressed: {
			if (island.mode === "stressMenu") { island.mode = "idle" }
			else { island.mode = "stressMenu" }
		}
	}
	mask: Region {
		item: root
	}
	Item {
		id: island
		property string mode: "idle"
		anchors.fill: parent
		Rectangle {
			id: root
			implicitHeight: {
				if (island.mode === "idle") { return 33 } 
				else if (island.mode === "hovered") { return 85 } 
				else if (island.mode === "powerMenu") { return 70 } 
				else if (island.mode === "stressMenu") { return 420 } 
				else if (island.mode === "controlPanel") { return 160 } 
				else if (island.mode === "wifi") { return 400 } 
				else if (island.mode === "battery") { return 300 } 
				else if (island.mode === "themeSelect") { return 255 } 
				else if (island.mode === "search") { 
					if (searchRoot.allApps.length === 1) { return 33 }
					else { return (33 * searchRoot.allApps.length) + 5} }
				else { return 33 } }
			implicitWidth: {
				if (island.mode === "idle") { return 250 } 
				else if (island.mode === "hovered") { return 450 } 
				else if (island.mode === "powerMenu") { return 400 } 
				else if (island.mode === "stressMenu") { return 760 } 
				else if (island.mode === "controlPanel") { return 400 } 
				else if (island.mode === "battery") { return 360 } 
				else if (island.mode === "themeSelect") { return 300 } 
				else if (island.mode === "search") { return 300 } 
				else { return 250 } }
			Behavior on implicitHeight { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
			Behavior on implicitWidth  { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top

			radius: 15

			color: colors.bg
			Clock {
				id: clocks
				color: colors.white
				anchors.top: parent.top
				anchors.topMargin: island.mode === "hovered" ? 0 : 7 
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: island.mode === "hovered" ? 40 : 14
				font.family: "Jetbrains Mono"
				opacity: { if (island.mode === "idle") { return 1 } 
					else if (island.mode === "hovered") { return 1 } 
					else { return 0 } }
				Behavior on opacity { NumberAnimation { duration: 100} }
				Behavior on font.pixelSize { NumberAnimation {duration: 250; easing.type: Easing.OutCubic} }
				Behavior on anchors.topMargin { NumberAnimation {duration: 80} }
			}
			HoverHandler { 
				id: rootMouse
				enabled: {
					if (island.mode === "idle") { return true } 
					else if (island.mode === "hovered") { return true }
					else { return false } }
				onHoveredChanged: {
					if (hovered) {
						island.mode = "hovered"
					} else {
						island.mode = "idle"
					}
				}
			}

			Loader {
			anchors.fill: parent
			active: island.mode === "stressMenu"
			source: "modules/StressMenu/Stress.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "stressMenu" ? 1 : 0
			}
			Loader {
			anchors.fill: parent
			active: island.mode === "battery"
			source: "modules/Battery.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "battery" ? 1 : 0
			}
			Loader {
			anchors.fill: parent
			active: island.mode === "powerMenu"
			source: "modules/PowerMenu.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "powerMenu" ? 1 : 0
			}
			Loader {
			anchors.fill: parent
			active: island.mode === "themeSelect"
			source: "modules/ThemeSelect.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "themeSelect" ? 1 : 0
			}
			Hovered {}
			ControlPanel {}
			Search { id: searchRoot }
			Colors { id: colors }
		}
	}
}




