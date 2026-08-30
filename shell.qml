import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

import qs.modules
import qs.services
import qs.modules.Settings
import qs.modules.StressMenu


PanelWindow {
	id: panelWindow
	anchors {
		top: true
	}
	color: "transparent"
	exclusiveZone: 38
	implicitWidth: 760
	implicitHeight: 430

	// Keybinds
	function checkMode(mode) { island.mode === mode ? island.mode = "idle" : island.mode = mode }
	GlobalShortcut {
		id: battery
		name: "Battery"
		onPressed: checkMode("battery")
	}
	GlobalShortcut {
		id: controlPanel
		name: "ControlPanel"
		onPressed: checkMode("controlPanel")
		}
	GlobalShortcut {
		id: search
		name: "Search"
		onPressed: checkMode("search")
	}
	GlobalShortcut {
		id: stress
		name: "stressMenu"
		onPressed: checkMode("stressMenu")
	}
	mask: Region {
		item: island
	}
	Rectangle {
		id: island
		property string mode: "idle"
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		width: root.implicitWidth
		height: root.implicitHeight + 5
		opacity: 0.98
		color: "transparent"
		//SplitMode { visible: true }
		HoverHandler { 
			id: rootMouse
			enabled: (island.mode === "idle" || island.mode === "hovered")
			onHoveredChanged: {
				if (island.mode !== "idle" && island.mode !== "hovered") return;
				island.mode = hovered ? "hovered" : "idle"
			}
		}
		Rectangle {
			id: root
			anchors { topMargin: 4 }
			implicitHeight: {
				switch (island.mode) {
					case "idle":           return 33;  break;
					case "hovered":        return 85;  break;
					case "powerMenu":      return 70;  break;
					case "stressMenu":     return 420; break;
					case "controlPanel":   return 170; break;
					case "wifi":           return 400; break;
					case "battery":        return 300; break;
					case "themeSelect":    return 170; break;
					case "player":         return 170; break;
					case "search": 
						if (searchRoot.allApps.length === 1) { return 33 }
						else { return (33 * searchRoot.allApps.length) + 5} 

					default:               return 33;
				}
			}
			implicitWidth: {
				switch (island.mode) {
					case "idle":           return 250; break;
					case "hovered":        return 450; break;
					case "powerMenu":      return 400; break;
					case "stressMenu":     return 760; break;
					case "controlPanel":   return 400; break;
					case "wifi":           return 400; break;
					case "battery":        return 360; break;
					case "themeSelect":    return 430; break;
					case "player":         return 430; break;
					case "search":         return 300; break;

					default:               return 250;
				}
			}
			Behavior on implicitHeight { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
			Behavior on implicitWidth  { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top

			radius: 15

			color: Colors.bg
			Clock {
				id: clocks
				color: Colors.white
				anchors.top: parent.top
				anchors.topMargin: island.mode === "hovered" ? 0 : 7 
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: island.mode === "hovered" ? 40 : 14
				font.family: "Jetbrains Mono"
				opacity: { if (island.mode === "idle") { return 1 } 
					else if (island.mode === "hovered") { return 1 } 
					else { return 0 } }
				Behavior on opacity { NumberAnimation { duration: 100} }
				Behavior on font.pixelSize { NumberAnimation {duration: 450; easing.type: Easing.OutBack } }
				Behavior on anchors.topMargin { NumberAnimation {duration: 80} }
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
			active: island.mode === "themeSelect"
			source: "modules/ThemeSelect.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "themeSelect" ? 1 : 0
			}
			Loader {
				id: settingsMenuLoader
				property bool isOpen: false
				active: isOpen
				source: "modules/Settings/Settings.qml"
				width: item ? item.implicitWidth : 0
				height: item ? item.implicitHeight : 0
			}

			Loader {
			anchors.fill: parent
			active: island.mode === "controlPanel"
			source: "modules/ControlPanel.qml"
			width: item ? item.implicitWidth : 0
			height: item ? item.implicitHeight : 0
			Behavior on opacity { NumberAnimation { duration: 250 }}
			opacity: island.mode === "controlPanel" ? 1 : 0
			}

			Hovered {}
			Search { id: searchRoot }
		}
	}
}
