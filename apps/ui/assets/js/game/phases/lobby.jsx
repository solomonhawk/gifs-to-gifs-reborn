import React from 'react'
import { isCreator } from '../../data/helpers'

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
      <h3>Welcome to the game!</h3>

      <ul>
        {Object.values(game.players).map(player => (
          <li key={player.id}>{player.name} {isCreator(game, player) && "(creator)"}</li>
        ))}
      </ul>

      {isCreator(game, player) && (
        <button
          type="button"
          disabled={!game.ready_to_start}
          onClick={() => send('start_game')}
        >
          Start Game
        </button>
      )}
    </>
  )
}
