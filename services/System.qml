import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
	id: root

	property string gpuName: "undefined"
	property string cpuName: "undefined"
	property string ramAmount: "undefined"


	property int cpuUsage: 0
	property int gpuUsage: 0
	property real ramUsage: 0


	property bool usageToggle: false
	property bool systemInfoToggle: false

	property var cpuUsageGraphData: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	property var gpuUsageGraphData: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]


	Process {
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/systemInfo"]
		running: systemInfoToggle
		stdout: StdioCollector { 
			id: systemStat
			onStreamFinished: {
				var statistics = systemStat.text.trim().split('|')
				root.cpuName = statistics[0]
				root.gpuName = statistics[1]
				root.ramAmount = statistics[2]
			}
		}
	}

	Process {
		id: usageStats
		running: usageToggle
		command: ["sh", "-c", "~/.config/quickshell/services/scripts/monitor 1"]
		stdout: SplitParser {
			onRead: usageStatistics => {
				var usageStat = usageStatistics.split('|')
				root.cpuUsage = usageStat[0].slice(0, -3).trim()
				root.gpuUsage = usageStat[1].trim()
				root.ramUsage = usageStat[2].trim().slice(0, -1)

				let cpuGraphData = Array.from(root.cpuUsageGraphData)
				let gpuGraphData = Array.from(root.gpuUsageGraphData)
				cpuGraphData.push(System.cpuUsage)
				gpuGraphData.push(System.gpuUsage)

				if ( cpuGraphData.length > 19 ) {
					cpuGraphData.shift()
				}
				if ( gpuGraphData.length > 19 ) {
					gpuGraphData.shift()
				}

				root.cpuUsageGraphData = cpuGraphData
				root.gpuUsageGraphData = gpuGraphData

			}
		}
	}
}
