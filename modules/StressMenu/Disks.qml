import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
	anchors.fill: parent
	ColumnLayout {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 15
		spacing: 10
		Repeater {
			id: diskList
			model: diskInfo.disks.length
			Text {
				text: diskInfo.disks[index + 1]
				font.pixelSize: 18
				font.family: "Jetbrains Mono"
				color: "white"
			}
		}
		Repeater {
			model: diskInfo.partitions.length
			Text {
				text: diskInfo.partitions[index]
				color: "white"
				font.pixelSize: 10
				font.family: "Jetbrains Mono"
			}
		}
	}
	Process {
		id: diskInfo
		property var disks: []
		property var partitions: []
		command: ["sh", "-c", "~/.config/quickshell/scripts/diskInfo"]
		running: island.mode === "stressMenu"
		stdout: StdioCollector {
			id: disksOutput
			onStreamFinished: {
				var source = disksOutput.text.trim().split("|")
				var disks = source.filter(item => item.includes("#")).toString().split("#")
				var partitions = source.filter(item => !item.includes("#")).slice(1)
				diskInfo.disks = disks
				diskInfo.partitions = partitions
			}
		}
	}
}
