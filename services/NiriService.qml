import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
	id: root
	property int workspaceIndex: 1

	Process {
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/workspaceCheck"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				root.workspaceIndex = data
			}
		}
	}
}
