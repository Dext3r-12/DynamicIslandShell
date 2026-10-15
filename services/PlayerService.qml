import Quickshell
import Quickshell.Io
import QtQuick
pragma Singleton

Singleton {
	id: root
	property bool playToggle: false
	property bool isPlaying: false
	Process {
		id: playerStatus
		command: ["playerctl", "status", "-F"]
		stdout: SplitParser {
			onRead: data => {
				root.isPlaying = data === "Playing" ? true : false
				}
			}
		running: true
	}
	Process {
		id: toggleCommand
		command: ["sh", "-c", "playerctl play-pause"]
		running: playToggle
	}
	IpcHandler {
		target: "Player"
		function play() {
			root.playToggle = true
		}
		function stop() {
			root.playToggle = false
		}
		function toggle() {
			root.playToggle = !root.playToggle
		}
		
	}
}
