import QtQuick


Text {
	id: clocks
	anchors.top: parent.top
	anchors.topMargin: 10
	anchors.horizontalCenter: parent.horizontalCenter
	text: "hh:mm"	
	color: "#F0F4F8"
	font.family: "Jetbrains Mono"

	Behavior on font.pixelSize { NumberAnimation {duration: 80} }
	Timer {

		interval: 2000
		running: true
		repeat: true

		onTriggered: clocks.text = Qt.formatDateTime(new Date(), "hh:mm")
	}
	Component.onCompleted: clocks.text = Qt.formatDateTime(new Date(), "hh:mm")
}

