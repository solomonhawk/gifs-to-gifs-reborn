import React from 'react'
import ReactDOM from 'react-dom'
import Game from './game'

let container = document.getElementById('app')

if (container) {
  let shortcode = container.getAttribute('data-shortcode')
  let authToken = container.getAttribute('data-auth-token')
  let player = JSON.parse(container.getAttribute('data-player'))

  ReactDOM.render(
    <Game shortcode={shortcode} authToken={authToken} player={player} />,
    container
  )
}
