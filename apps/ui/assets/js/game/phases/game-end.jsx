import React from 'react'
import Winner from './game-end/winner'
import Loser from './game-end/loser'
import { scoreFor } from '../../data/helpers'

export default function GameEnd({ game, player }) {
  let isWinner = game.winners.find(w => w.id === player.id)

  return (
    <>
      <h3 className="center">Game Over</h3>

      <div className="pb-2">
        {game.winners.length === 1 ? (
          <p className="center">
            <strong>{game.winners[0].name}</strong> wins with{' '}
            {scoreFor(game, game.winners[0])} points!
          </p>
        ) : (
          <>
            <p className="center">Draw!</p>
            <ul>
              {game.winners.map(winner => (
                <li key={winner.id}>
                  <strong>{winner.name}</strong>: {scoreFor(game, winner)}
                </li>
              ))}
            </ul>
          </>
        )}
      </div>

      {isWinner ? <Winner /> : <Loser />}

      <a href="/games/new" className="button mt-auto full-width">
        Start a new game
      </a>
    </>
  )
}
