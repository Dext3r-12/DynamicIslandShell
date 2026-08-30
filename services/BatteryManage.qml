import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
	property bool pc: false
	property int percent: 0 
	property bool isRunning: false
	Process {
		running: isRunning
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/batteryInfo"]
		stdout: SplitParser {
			onRead: data => {
				if ( data === "computer" ) { pc = true }
				else { percent = Number(data.trim()) }
				}
			}
	}
}
