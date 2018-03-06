import QtWebSockets 1.1

WebSocket {
    property string port: sport
    property string host: shost
    url: "ws://" + host + ":" + port
}
