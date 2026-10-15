import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "../services"
import "../widgets"

PanelWindow {
	implicitWidth: 1920
	implicitHeight: 1080
	visible: true
    WlrLayershell.layer: WlrLayer.Background
	color: "transparent"
	ClockWidget {}
	GifWidget {}    
	CavaWidget {}    
}
