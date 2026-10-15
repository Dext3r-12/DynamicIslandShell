import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
	property bool pc: false
	property int percent: 0 
	property bool isRunning: false
	property int mode: 2
	Process {
		running: true
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/batteryInfo"]
		stdout: SplitParser {
			onRead: data => {
				if ( data === "computer" ) { pc = true }
				else { percent = Number(data.trim()) }
				}
			}
	}
	Process {
		running: mode === 1
		command: ["sh", "-c", "powerprofilesctl set performance"]
	}
	Process {
		running: mode === 2
		command: ["sh", "-c", "powerprofilesctl set balanced"]
	}
	Process {
		running: mode === 3
		command: ["sh", "-c", "powerprofilesctl set power-saver"]
	}
}
