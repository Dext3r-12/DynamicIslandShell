import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
	anchors.fill: parent
	opacity: island.mode === "themeSelect" ? 1 : 0
	enabled: island.mode === "powerMenu" ? 1 : 0
	GridLayout {
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15
		anchors.horizontalCenter: parent.horizontalCenter
		rows: 2
		columns: 3
		Repeater {
			id: themeBoxes
			model: 6
			Rectangle {
				width: 130
				height: 70
				radius: 10
				color: colors.fg
				TapHandler {
					enabled: island.mode === "themeSelect"
					onTapped: {
						if ( index === 0 ) { colors.activeTheme = "catppuccin"}
						if ( index === 1 ) { colors.activeTheme = "gruvbox"}
						if ( index === 2 ) { colors.activeTheme = "cherryblossom"}
						if ( index === 3 ) { colors.activeTheme = "Nord"}
						if ( index === 4 ) { colors.activeTheme = "rosepine"}
						if ( index === 5 ) { colors.activeTheme = "catppuccin"}
					}
				}
				Text {
					id: themeText
					text: {
						if ( index === 0 ) { return "Catppuccin" }
						if ( index === 1 ) { return "Gruvbox" }
						if ( index === 2 ) { return "Cherry-Blossom"}
						if ( index === 3 ) { return "Nord"}
						if ( index === 4 ) { return "Rose-Pine"}
						if ( index === 5 ) { return "TokyoNight"}
					}
					anchors.top: parent.top
					anchors.topMargin: 5
					anchors.horizontalCenter: parent.horizontalCenter
					font.pixelSize: 18
					font.family: "Jetbrains Mono"
					color: colors.white
					RowLayout {
						spacing: 10
						anchors.horizontalCenter: parent.horizontalCenter
						anchors.top: parent.bottom
						anchors.topMargin: 10
						Repeater {
							model: 4
							Rectangle {
								width: 10
								height: width
								radius: width / 2
								color: {
									if ( themeText.text === "Gruvbox" ) { 
										if ( index === 0 ) { return colors.gruvbox[0] }
										if ( index === 1 ) { return colors.gruvbox[5] }
										if ( index === 2 ) { return colors.gruvbox[8] }
										if ( index === 3 ) { return colors.gruvbox[10] }
									}
									else if ( themeText.text === "Catppuccin" ) { 
										if ( index === 0 ) { return colors.catppuccin[2] }
										if ( index === 1 ) { return colors.catppuccin[5] }
										if ( index === 2 ) { return colors.catppuccin[8] }
										if ( index === 3 ) { return colors.catppuccin[10] }
									}
									else if ( themeText.text === "Rose-Pine" ) { 
										if ( index === 0 ) { return colors.rosepine[0] }
										if ( index === 1 ) { return colors.rosepine[1] }
										if ( index === 2 ) { return colors.rosepine[2] }
										if ( index === 3 ) { return colors.rosepine[4] }
									}
									else if ( themeText.text === "Cherry-Blossom" ) { 
										if ( index === 0 ) { return colors.cherryblossom[0] }
										if ( index === 1 ) { return colors.cherryblossom[1] }
										if ( index === 2 ) { return colors.cherryblossom[2] }
										if ( index === 3 ) { return colors.cherryblossom[4] }
									}
									else { return "purple" }
								}
							}
						}
					}
				}
			}
		}
	}
}
