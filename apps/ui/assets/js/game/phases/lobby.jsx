import React from 'react'
import Button from '../components/button'
import { isCreator } from '../../data/helpers'
import { baseUrl } from '../../config'

function gameUrl(game) {
  return `${baseUrl}/games/${game.shortcode}`
}

/**
 * Lobby screen (pre-game)
 *
 * - shortcode / join link
 * - players in the lobby
 * - "Leave Game" link
 * - "Start Game" button (creator)
 */
export default function Lobby({ game, player, send }) {
  return (
    <>
      <h3 className="center">
        <code>{game.shortcode}</code>
      </h3>

      <input
        readOnly
        autoFocus
        type="text"
        value={gameUrl(game)}
        onFocus={event => event.target.select()}
      />

      <ul>
        {Object.values(game.players).map(player => (
          <li key={player.id}>
            {isCreator(game, player) && '🎗'}
            {player.name}
          </li>
        ))}
      </ul>

      {isCreator(game, player) && (
        <Button
          className="mt-auto full-width"
          disabled={!game.ready_to_start}
          onClick={() => send('start_game')}
        >
          Start Game
        </Button>
      )}
    </>
  )
}
