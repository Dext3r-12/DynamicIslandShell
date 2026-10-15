import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
	id: root
	property int workspaceIndex: 1
	property int targetWorkspace: 1
	property bool changeWorkspace: false

	Process {
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/workspaceCheck"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				root.workspaceIndex = data
			}
		}
	}
	Process {
		command: ["sh", "-c", "niri msg action focus-workspace " + root.targetWorkspace]
		running: changeWorkspace
	}
}
