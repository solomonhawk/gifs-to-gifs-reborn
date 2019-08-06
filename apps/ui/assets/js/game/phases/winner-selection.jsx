import React from 'react'
import { shuffle } from 'lodash-es'
import { isFunmaster } from '../../data/helpers'

export default function WinnerSelection({ game, player, send }) {
  let winnerId = shuffle(Object.keys(game.reactions)).pop()

  let onClick = () =>
    send('select_winner', {
      winner: game.players[winnerId]
    })

  if (isFunmaster(game, player)) {
    return <button onClick={onClick}>Select Winner</button>
  }

  return <p>{game.funmaster.name} is picking the winner.</p>
}
