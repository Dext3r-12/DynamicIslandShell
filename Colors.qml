import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules


Item {
	id: themeColors
	property color bg: "#121317"
	property color fg: "#000000"
	property color primary: "#000000"
	property color white: "#000000"
	property color red: "#000000"
	property color green: "#000000"
	property color blue: "#000000"

	Process {
		running: true
		command: ["sh", "-c", "cat ~/.cache/wal/colors"]
		stdout: StdioCollector { 
			id: colorSource 
			onStreamFinished: {
				var lines = colorSource.text.trim().split('\n')
				themeColors.fg = Qt.lighter(lines[3], 0.25)
				themeColors.primary = lines[7]
				themeColors.white = lines[15]
				themeColors.red = lines[9]
				themeColors.green = lines[10]
				themeColors.blue = lines[12]
			}
		}
	}
}
