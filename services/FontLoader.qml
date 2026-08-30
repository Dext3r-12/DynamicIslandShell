import Quickshell
import QtQuick

pragma Singleton

Singleton {
	property alias iconFont: iconFontLoader
	property alias titleFont: titleFontLoader
	// Icons
	FontLoader {
		id: iconFontLoader
		source: Qt.resolvedUrl("fonts/icons.ttf")
	}
	// title
	FontLoader {
		id: titleFontLoader
		source: Qt.resolvedUrl("fonts/Milker.otf")
	}
}
