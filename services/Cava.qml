import Quickshell
import Quickshell.Io
import QtQuick

pragma Singleton

Item {
	id: root
	property bool isCavaSixBarsRunning: false
	property var sixBarsData: ["0", "0", "0", "0", "0", "0"]
	Process {
		id: sixBarsProcess
		running: root.isCavaSixBarsRunning
		command: ["sh", "-c", "~/.config/quickshell/services/cava/six.sh "]
		stdout: SplitParser {
			onRead: data => {
				root.sixBarsData = data.split("#")
			}
		}
	}
}

