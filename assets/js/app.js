import "../css/app.css"

import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import Hooks from "./hooks"

let room = document.querySelector("meta[name='room']").getAttribute("content")
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: Hooks,
  metadata: {
    keydown: (e, el) => ({
      key: e.key,
      mod: e.metaKey || e.ctrlKey || e.altKey
    })
  }
})

liveSocket.connect()
let channel = liveSocket.channel("events:" + room, {})

// liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

window.refocus = () => {
  const input = document.getElementById("input")
  input.click()
  input.focus({preventScroll: true})
}

window.show = (selector) => {
  const el = document.querySelector(selector)
  if (el) el.style.display = "block";
}

window.hide = (selector) => {
  const el = document.querySelector(selector)
  if (el) el.style.display = "none";
}

window.addEventListener("phx:store", event => {
  const date = new Date(Date.now() + 2592000000);
  document.cookie = `${event.detail.key}=${event.detail.value}; expires=${date.toUTCString()}; path=/`;
})
