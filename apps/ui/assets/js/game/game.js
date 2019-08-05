import React from 'react'
import PropTypes from 'prop-types'
import Transport from './transport'

class Game extends React.Component {
  static propTypes = {
    shortcode: PropTypes.string.isRequired,
    authToken: PropTypes.string.isRequired
  }

  componentDidMount() {
    this.transport = new Transport(this.props.authToken, this.props.shortcode)
  }

  render() {
    return <div>Welcome to the game!</div>
  }
}

export default Game
