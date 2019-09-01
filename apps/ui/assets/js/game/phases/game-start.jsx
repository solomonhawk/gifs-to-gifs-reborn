import React from 'react'
import { isCreator } from '../../data/helpers'

/**
 * Game Start screen (pre-first-round)
 *
 *    game has started
 *    lasts for 10 rounds
 *    winner has the highest score at the end
 *    each round a different person will be the judge
 *    judge picks prompt, players pick reactions, time is limited!
 *
 * - "Get ready to play!"
 * - Try to make the funmaster laugh, earn points, and crush the competition.
 */
export default function GameStart({ game, player, send }) {
  return (
    <>
      <p>Get ready to play!</p>

      <p>
        <small>
          Try to make the funmaster laugh, win points, and crush the
          competition.
        </small>
      </p>

      {isCreator(game, player) && (
        <button type="button" onClick={() => send('start_round')}>
          Start First Round
        </button>
      )}
    </>
  )
}
