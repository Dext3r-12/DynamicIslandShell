import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
	anchors.fill: parent
	RowLayout {
		property var wallpapers: []
		Process {
			command: ["find", "~/Pictures/Wallpapers", "-maxdepth", "1", "-type f"]
			running: true
			stdout: SplitParser {
				onRead: (line) => {
					console.log(wallpapers)
					if (line.trim() !== "") {
						wallpapers.push(line)
					}
				}
			}
		}
		anchors.centerIn: parent
		spacing: 10
		Repeater {
			model: 3
			Image {
				source: "~/Pictures/lake.jpg"
				width: 150
				height: 100
			}
		}
	}
}
