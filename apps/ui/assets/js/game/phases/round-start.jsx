import React from 'react'
import PlayerList from '../player-list'

/**
 * Round Start screen (pre-round)
 *
 * -
 */
export default function RoundStart({ game }) {
  return (
    <>
      <div>Round {game.round_number}</div>
      <small>{game.funmaster.name} is the funmaster!</small>

      <PlayerList game={game} />
    </>
  )
}
