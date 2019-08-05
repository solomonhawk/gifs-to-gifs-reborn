import React from 'react'
import ReactDOM from 'react-dom'
import Game from './game'

let container = document.getElementById('app')
let shortcode = container.getAttribute('data-shortcode')
let authToken = container.getAttribute('data-auth-token')

ReactDOM.render(<Game shortcode={shortcode} authToken={authToken} />, container)
