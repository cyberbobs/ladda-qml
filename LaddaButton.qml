import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
  id: button

  property alias text: label.text
  property bool running: false
  property string mode: "expand-left"

  property var overlayTarget
  property real progress : 0.0

  signal clicked

  width: label.contentWidth + 30
  height: label.contentHeight + 30

  color: "#999"
  radius: 4
//  clip: true
  state: "static"


  Rectangle {
    id: progressIndicator
    opacity: 0
    visible: button.progress > 0

    anchors.centerIn: button
    width: button.height
    height: button.width
    radius: button.radius
    color: button.color
    rotation: -90

    gradient: Gradient {
      GradientStop { position: 0.0; color: "#aaa" }
      GradientStop { position: button.progress - 0.001; color: "#aaa" }
      GradientStop { position: button.progress + 0.001; color: progressIndicator.color }
      GradientStop { position: 1.0; color: progressIndicator.color }
    }
  }


  Text {
    id: label
    text: "Button"
    color: "white"

    font {
      pointSize: 12
      family: "Segoe UI"
    }

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 15
  }

  BusyIndicator {
    id: spinner
    width: 30
    height: 30
    opacity: 0

    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 10
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    onClicked: button.clicked()
  }


  Rectangle {
    id: overlay
    z: 253

    opacity: 0
    color: "black"
    visible: (mode == "contract-overlay") && running

    Behavior on opacity { PropertyAnimation { duration: 150 } }
    MouseArea { anchors.fill: parent }
  }


  states: [
    State {
      name: "static"
    },
    State {
      name: "running"
      PropertyChanges { target: spinner; opacity: 1 }
      PropertyChanges { target: button; color: "#d6d6d6" }
      PropertyChanges { target: progressIndicator; opacity: 1 }
    },

    State {
      name: "expand-left"
      extend: "running"
      PropertyChanges { target: button; width: label.contentWidth + spinner.width + 45 }
      AnchorChanges { target: label; anchors.left: undefined; anchors.right: button.right }
      AnchorChanges { target: spinner; anchors.left: button.left }
    },
    State {
      name: "expand-right"
      extend: "running"
      PropertyChanges { target: button; width: label.contentWidth + spinner.width + 45 }
      AnchorChanges { target: spinner; anchors.right: button.right }
    },
    State {
      name: "expand-up"
      extend: "running"
      PropertyChanges { target: button; height: label.contentHeight + spinner.height + 45 }
      AnchorChanges { target: spinner; anchors.horizontalCenter: button.horizontalCenter; anchors.verticalCenter: undefined; anchors.top: button.top }
      AnchorChanges { target: label; anchors.verticalCenter: undefined; anchors.bottom: button.bottom }
    },
    State {
      name: "expand-down"
      extend: "running"
      PropertyChanges { target: button; height: label.contentHeight + spinner.height + 45 }
      AnchorChanges { target: spinner; anchors.horizontalCenter: button.horizontalCenter; anchors.verticalCenter: undefined; anchors.bottom: button.bottom }
      AnchorChanges { target: label; anchors.verticalCenter: undefined; anchors.top: button.top }
    },
    State {
      name: "contract"
      extend: "running"
      PropertyChanges { target: button; width: button.height; radius: height / 2; }
      PropertyChanges { target: button; color: "#ddd"; }
      PropertyChanges { target: label; opacity: 0 }
      AnchorChanges { target: spinner; anchors.horizontalCenter: button.horizontalCenter; anchors.verticalCenter: button.verticalCenter; }
    },
    State {
      name: "contract-overlay"
      extend: "contract"
      PropertyChanges { target: button; z: 254 }
      PropertyChanges { target: overlay; opacity: 0.7; visible: true }
    }
  ]

  transitions: [
    Transition {
      from: "static";
      SequentialAnimation {
        AnchorAnimation { targets: spinner; duration: 0 }
        ParallelAnimation {
          AnchorAnimation { targets: label; duration: 150 }
          PropertyAnimation { target: button; properties: "color,width,height,radius"; duration: 150 }
          PropertyAnimation { target: spinner; properties: "scale,opacity"; duration: 150 }
          PropertyAnimation { target: label; properties: "opacity"; duration: 100 }
          PropertyAnimation { target: progressIndicator; property: "opacity"; duration: 150 }
        }
      }
    },

    Transition {
      to: "static"
      SequentialAnimation {
        ParallelAnimation {
          PropertyAnimation { target: progressIndicator; property: "opacity"; duration: 150 }
          PropertyAnimation { target: spinner; properties: "scale,opacity"; duration: 150 }
          AnchorAnimation { targets: label; duration: 150 }
          PropertyAnimation { target: label; properties: "opacity"; duration: 100 }
          PropertyAnimation { target: button; properties: "color,width,height,radius"; duration: 150 }
        }
        AnchorAnimation { targets: spinner; duration: 0 }
      }
    }
  ]

  onRunningChanged: {
    // Находим цель для оверлея и лезем к ней
    if (!overlayTarget) {
      var newTarget = parent
      do {
        overlayTarget = newTarget
        newTarget = overlayTarget.parent
      }
      while (newTarget && newTarget.width != 0 && newTarget.height != 0);
    }

    overlay.parent = overlayTarget
    overlay.x = overlayTarget.x
    overlay.y = overlayTarget.y
    overlay.width = overlayTarget.width
    overlay.height = overlayTarget.height

    if (!running)
      state = "static"
    else
      state = mode
  }
}
