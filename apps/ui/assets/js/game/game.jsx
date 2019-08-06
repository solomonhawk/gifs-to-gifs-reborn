import React from 'react'
import PropTypes from 'prop-types'
import Transport from './transport'
import Phases from './phases'

class Game extends React.Component {
  static propTypes = {
    shortcode: PropTypes.string.isRequired,
    authToken: PropTypes.string.isRequired,
    player: PropTypes.shape({
      name: PropTypes.string.isRequired,
      id: PropTypes.string.isRequired
    }).isRequired
  }

  state = {
    game: null,
    presences: {}
  }

  componentDidMount() {
    this.transport = new Transport(
      this.props.authToken,
      this.props.shortcode,
      this.onGameStateChange
    )
  }

  render() {
    if (!this.state.game) {
      return 'Loading...'
    }

    let Phase = Phases[this.state.game.phase]

    return (
      <Phase
        game={this.state.game}
        player={this.props.player}
        send={this.transport.send}
      />
    )
  }

  onGameStateChange = (game, presences) => {
    this.setState({
      game,
      presences
    })
  }
}

export default Game
