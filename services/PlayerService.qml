import Quickshell
import Quickshell.Io
import QtQuick
pragma Singleton

Singleton {
	id: root
	property bool playToggle: true
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
		id: playCommand
		command: ["sh", "-c", "playerctl play"]
		running: playToggle
	}
	Process {
		id: pauseCommand
		command: ["sh", "-c", "playerctl pause"]
		running: !playToggle
	}
	IpcHandler {
		target: "Player"
		function play() {
			root.isPlaying = true
		}
		function stop() {
			root.isPlaying = false
		}
		function toggle() {
			root.isPlaying = !root.isPlaying
		}
		
	}
}
