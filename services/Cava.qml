import Quickshell
import Quickshell.Io
import QtQuick

pragma Singleton

Item {
	id: root
	property bool isCavaSixBarsRunning: true
	property var barsData: ["0", "0", "0", "0", "0", "0"]
	Process {
		id: sixBarsProcess
		running: root.isCavaSixBarsRunning
		command: ["sh", "-c", "~/.config/quickshell/services/cava/cava_config.sh "]
		stdout: SplitParser {
			onRead: data => {
				root.barsData = data.split("#")
			}
		}
	}
}

