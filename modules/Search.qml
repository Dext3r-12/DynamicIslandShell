import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


Item {
	Rectangle {
		id: selection
		anchors.horizontalCenter: parent.horizontalCenter
		width: 290
		height: 33
		y: 33 * selected
		color: allApps.length === 1 ? "transparent" : theme.fg
		radius: 10
	}
	id: searchRoot
	property int selected: 1
	property string appPrompt: ""
	property var allApps: [""]
	anchors.fill: parent
	opacity: island.mode === "search" ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 100 } }
	Text {
		anchors.left: parent.left
		anchors.leftMargin: 14
		anchors.top: parent.top
		anchors.topMargin: 4
		text: ""
		color: "white"
		font.pixelSize: 14
	}
	TextField {
		id: searchText
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 4
		width: 200
		focus: true
		placeholderText: "Search.."
		placeholderTextColor: "#6e6e6e"
		color: "white"
		horizontalAlignment: TextInput.AlignHCenter
		background: Rectangle { color: "transparent" }
		Keys.onPressed: (event) => {
			console.log("key")
			if (event.key === Qt.Key_Down) {
				console.log("down")
				if (selected >= allApps.length - 1) { return 0 }
				else { selected += 1 }
			}
			else if (event.key === Qt.Key_Up) {
				console.log("up")
				if (selected <= 1) { return 0 }
				else { selected -= 1 }
			}
			else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
				console.log("enter", allApps[selected - 1])
				launchApp.running = false
				launchApp.running = true
				island.mode = "idle"
			}
		}
		onActiveFocusChanged: {
			if (!activeFocus) { island.mode = "idle" }
			else { text = "" }
		}
		onTextChanged: {
			appPrompt = searchText.text 
			checkApps.running = false
			checkApps.running = true
		}
	}
	HyprlandFocusGrab {
		windows: [ panelWindow ]
		active: island.mode === "search"
	}
	Process {
		id: launchApp
		running: false
		command: ["sh", "-c", ` ~/.config/quickshell/scripts/launch_app <<<  "${allApps[selected - 1].trim()}"`]
	}
	Process {
		id: checkApps
		command: ["sh", "-c", ` ~/.config/quickshell/scripts/search <<<  "${appPrompt.trim()}"`]
		running: false
		stdout: StdioCollector {
			onStreamFinished: {
			var list = text.split("\n")
			allApps = list
			selected = 1
			}
		}
	}
	ColumnLayout {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 33
		spacing: 0
		Repeater {
			model: allApps.length - 1
			Rectangle {
				width: 200
				height: 33
				color: "transparent"
				Text {
					text: allApps[index]
					anchors.left: parent.left
					//verticalAlignment: Text.AlignVCenter
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: 15
					font.pixelSize: 14
					color: "white"
				}
			}
		}
	}
}


