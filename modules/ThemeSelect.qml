import Quickshell
import QtQuick
import QtQuick.Layouts

import "../services"

Item {
	anchors.fill: parent
	opacity: island.mode === "themeSelect" ? 1 : 0
	enabled: island.mode === "themeSelect" ? 1 : 0
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
				color: Colors.fg
				TapHandler {
					enabled: island.mode === "themeSelect"
					onTapped: {
						switch (index) {
							case 0: Colors.activeTheme = "catppuccin"; break;
							case 1: Colors.activeTheme = "gruvbox"; break;
							case 2: Colors.activeTheme = "cherryblossom"; break;
							case 3: Colors.activeTheme = "cherryblossom"; break;
							case 4: Colors.activeTheme = "rosepine"; break;
							case 5: Colors.activeTheme = "wallpaper"; break;
						}
					}
				}
				Text {
					id: themeText
					text: {
						switch (index) {
							case 0: return "Catppuccin"; break;
							case 1: return "Gruvbox"; break;
							case 2: return "Cherry-Blossom"; break;
							case 3: return "TokyoNight"; break;
							case 4: return "Rose-Pine"; break;
							case 5: return "Auto"; break;
						}
					}
					anchors.top: parent.top
					anchors.topMargin: 5
					anchors.horizontalCenter: parent.horizontalCenter
					font.pixelSize: 18
					font.family: "Jetbrains Mono"
					color: {
						switch (index) {
							case 0: return Colors.catppuccin[11]; break;
							case 1: return Colors.gruvbox[10]; break;
							case 2: return Colors.cherryblossom[5]; break;
							case 3: return Colors.white; break;
							case 4: return Colors.rosepine[8]; break;
							case 5: return Colors.wallpaperColors[7]; break;
						}
					}
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
										if ( index === 0 ) { return Colors.gruvbox[0] }
										if ( index === 1 ) { return Colors.gruvbox[5] }
										if ( index === 2 ) { return Colors.gruvbox[8] }
										if ( index === 3 ) { return Colors.gruvbox[10] }
									}
									else if ( themeText.text === "Catppuccin" ) { 
										if ( index === 0 ) { return Colors.catppuccin[2] }
										if ( index === 1 ) { return Colors.catppuccin[5] }
										if ( index === 2 ) { return Colors.catppuccin[8] }
										if ( index === 3 ) { return Colors.catppuccin[10] }
									}
									else if ( themeText.text === "Rose-Pine" ) { 
										if ( index === 0 ) { return Colors.rosepine[0] }
										if ( index === 1 ) { return Colors.rosepine[1] }
										if ( index === 2 ) { return Colors.rosepine[2] }
										if ( index === 3 ) { return Colors.rosepine[4] }
									}
									else if ( themeText.text === "Cherry-Blossom" ) { 
										if ( index === 0 ) { return Colors.cherryblossom[0] }
										if ( index === 1 ) { return Colors.cherryblossom[1] }
										if ( index === 2 ) { return Colors.cherryblossom[2] }
										if ( index === 3 ) { return Colors.cherryblossom[4] }
									}
									else if ( themeText.text === "Auto" ) { 
										if ( index === 0 ) { return Colors.wallpaperColors[0] }
										if ( index === 1 ) { return Colors.wallpaperColors[1] }
										if ( index === 2 ) { return Colors.wallpaperColors[2] }
										if ( index === 3 ) { return Colors.wallpaperColors[4] }
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
