import React from 'react'
import Winner from './game-end/winner'
import Loser from './game-end/loser'
import {
  scoreFor,
  winnerCount,
  gameWinner,
  gameWinners,
  isWinner,
  isTie
} from '../../data/helpers'

export default function GameEnd({ game, player }) {
  return (
    <>
      <h3 className="center">Game Over</h3>

      <div className="pb-2">
        {winnerCount(game) === 1 ? (
          <p className="center">
            <strong>{gameWinner(game).name}</strong> wins with{' '}
            {scoreFor(game, gameWinner(game))} points!
          </p>
        ) : (
          <>
            <p className="center">Draw!</p>
            <ul>
              {gameWinners(game).map(winner => (
                <li key={winner.id}>
                  <strong>{winner.name}</strong>: {scoreFor(game, winner)}
                </li>
              ))}
            </ul>
          </>
        )}
      </div>

      {isWinner(game, player) ? <Winner isTie={isTie(game)} /> : <Loser />}

      <a href="/games/new" className="button mt-auto full-width">
        Start a new game
      </a>
    </>
  )
}
