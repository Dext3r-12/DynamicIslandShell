import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules


Item {
	id: themes
	property color bg: {
		if (activeTheme === "catppuccin") { return catppuccin[2] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[0] }
		if (activeTheme === "rosepine"  ) { return rosepine[0] }
		else { return activeTheme[13]}
	}
	property color fg:  {
		if (activeTheme === "catppuccin") { return catppuccin[3] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[1] }
		if (activeTheme === "rosepine"  ) { return rosepine[1] }
		else { return activeTheme[13]}
	}
	property color fg1:  {
		if (activeTheme === "catppuccin") { return catppuccin[4] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[2] }
		if (activeTheme === "rosepine"  ) { return rosepine[2] }
		else { return activeTheme[13]}
	}
	property color primary:  {
		if (activeTheme === "catppuccin") { return catppuccin[8] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[8] }
		if (activeTheme === "rosepine"  ) { return rosepine[4] }
		else { return activeTheme[13]}
	}
	property color white: {
		if (activeTheme === "catppuccin") { return catppuccin[11] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[10] }
		if (activeTheme === "rosepine"  ) { return rosepine[5] }
		else { return activeTheme[13]}
	}
	property color red: {
		if (activeTheme === "catppuccin") { return catppuccin[12] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[11] }
		if (activeTheme === "rosepine"  ) { return rosepine[8] }
		else { return activeTheme[13]}
	}
	property color green: {
		if (activeTheme === "catppuccin") { return catppuccin[14] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[13] }
		if (activeTheme === "rosepine"  ) { return rosepine[10] }
		else { return activeTheme[13]}
	}
	property color blue: {
		if (activeTheme === "catppuccin") { return catppuccin[13] }
		if (activeTheme === "gruvbox"   ) { return gruvbox[12] }
		if (activeTheme === "rosepine"  ) { return rosepine[9] }
		else { return activeTheme[13]}
	} 

	property string activeTheme: "gruvbox"


	property var rosepine: [
	"#191724", // Base
	"#1f1d2e", // Surface
	"#26233a", // Overlay
	"#6e6a86", // Muted
	"#908caa", // Subtle
	"#e0def4", // Text / White
	"#eb6f92", // Love
	"#f6c177", // Gold
	"#ebbcba", // Rose
	"#31748f", // Pine
	"#9ccfd8", // Foam
	"#c4a7e7", // Iris
	"#21202e", // Highlight Low
	"#403d52", // Highlight Med
	"#524f67"  // Highlight High
]


	property var catppuccin: [
	"#11111b", // Crust
	"#181825", // Mantle
	"#1e1e2e", // Base
	"#313244", // Surface0
	"#45475a", // Surface1
	"#585b70", // Surface2
	"#6c7086", // Overlay0
	"#7f849c", // Overlay1
	"#9399b2", // Overlay2
	"#a6adc8", // Subtext0
	"#bac2de", // Subtext1
	"#cdd6f4", // Text / White
	"#f38ba8", // Red
	"#89b4fa", // Blue
	"#a6e3a1"  // Green
]


	property var gruvbox: [
	"#282828",
	"#3c3836",
	"#504945",
	"#665c54",
	"#7c6f64",
	"#928374",
	"#a89984",
	"#bdae93",
	"#d5c4a1",
	"#ebdbb2",
	"#fbf1c7",
	"#cc241d",
	"#458588",
	"#98971a"
]

	Process {
		running: false
		command: ["sh", "-c", "cat ~/.cache/wal/colors"]
		stdout: StdioCollector { 
			id: colorSource 
			onStreamFinished: {
				var lines = colorSource.text.trim().split('\n')
				themes.fg = Qt.lighter(lines[3], 0.25)
				themes.primary = lines[7]
				themes.white = lines[15]
				themes.red = lines[9]
				themes.green = lines[10]
				themes.blue = lines[12]
				console.log(lines[7])
			}
		}
	}
}
