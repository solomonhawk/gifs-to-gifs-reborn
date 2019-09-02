import React from 'react'
import { scoreFor } from '../../data/helpers'

export default function GameEnd({ game }) {
  return (
    <>
      <h3>All done.</h3>

      {game.winners.length === 1 ? (
        <p>
          <strong>{game.winners[0].name}</strong> wins with{' '}
          {scoreFor(game, game.winners[0])} points!
        </p>
      ) : (
        <>
          <p>Draw!</p>
          <ul>
            {game.winners.map(winner => (
              <li key={winner.id}>
                <strong>{winner.name}</strong>: {scoreFor(game, winner)}
              </li>
            ))}
          </ul>
        </>
      )}

      <a href="/games/new" className="button full-width">
        Start a new game
      </a>
    </>
  )
}
