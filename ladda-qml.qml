import QtQuick 2.1
import QtQuick.Window 2.0

Window {
  id: root
  title: qsTr("Hello World")
  width: 900
  height: 480

  LaddaButton {
    x: 180 - width / 2
    y: 40
    text: "Expand left"
    mode: "expand-left"
    color: "#33b5e5"

    id: b1
    Timer {
      id: t1
      interval: 2000
      onTriggered: b1.running = false
    }

    onClicked: {
      b1.running = true; t1.running = true;
    }
  }

  LaddaButton {
    x: 360 - width / 2
    y: 40
    text: "Expand right"
    mode: "expand-right"
    color: "#aa66cc"

    id: b2
    Timer {
      id: t2
      interval: 2000
      onTriggered: b2.running = false
    }

    onClicked: {
      b2.running = true; t2.running = true;
    }
  }

  LaddaButton {
    x: 720 - width / 2
    y: 40
    text: "Expand up"
    mode: "expand-up"
    color: "#ffbb33"

    id: b3
    Timer {
      id: t3
      interval: 2000
      onTriggered: b3.running = false
    }

    onClicked: {
      b3.running = true; t3.running = true;
    }
  }

  LaddaButton {
    x: 540 - width / 2
    y: 40
    text: "Expand down"
    mode: "expand-down"
    color: "#99cc00"

    id: b4
    Timer {
      id: t4
      interval: 2000
      onTriggered: b4.running = false
    }

    onClicked: {
      b4.running = true; t4.running = true;
    }
  }


  LaddaButton {
    x: 180 - width / 2
    y: 200
    text: "Contract"
    mode: "contract"

    id: b5
    Timer {
      id: t5
      interval: 2000
      onTriggered: b5.running = false
    }

    onClicked: {
      b5.running = true; t5.running = true;
    }
  }


  LaddaButton {
    x: 360 - width / 2
    y: 200
    text: "Contract overlay"
    mode: "contract-overlay"

    id: b6
    Timer {
      id: t6
      interval: 2000
      onTriggered: b6.running = false
    }

    onClicked: {
      b6.running = true; t6.running = true;
    }
  }


  LaddaButton {
    x: 180 - width / 2
    y: 360
    text: "Expand progress"
    mode: "expand-left"

    id: b7
    Timer {
      id: t7
      interval: 200
      repeat: true
      onTriggered: {
        b7.progress += 0.1
        if (b7.progress > 1.0) {
          b7.running = false
          running = false
        }
      }
    }

    onClicked: {
      b7.progress = 0;
      b7.running = true;
      t7.running = true;
    }
  }


  LaddaButton {
    x: 360 - width / 2
    y: 360
    text: "Contract progress"
    mode: "contract"

    id: b8
    Timer {
      id: t8
      interval: 200
      repeat: true
      onTriggered: {
        b8.progress += 0.1
        if (b8.progress > 1.0) {
          b8.running = false
          running = false
        }
      }
    }

    onClicked: {
      b8.progress = 0;
      b8.running = true;
      t8.running = true;
    }
  }


  LaddaButton {
    x: 540 - width / 2
    y: 360
    text: "Overlay progress"
    mode: "contract-overlay"

    id: b9
    Timer {
      id: t9
      interval: 200
      repeat: true
      onTriggered: {
        b9.progress += 0.1
        if (b9.progress > 1.0) {
          b9.running = false
          running = false
        }
      }
    }

    onClicked: {
      b9.progress = 0;
      b9.running = true;
      t9.running = true;
    }
  }
}
