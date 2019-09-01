import React from 'react'
import Funmaster from './winner-selection/funmaster'
import PlayerWaiting from './winner-selection/player-waiting'
import { isFunmaster } from '../../data/helpers'

export default function WinnerSelection({ game, player, send }) {
  if (isFunmaster(game, player)) {
    return <Funmaster game={game} send={send} />
  }

  return <PlayerWaiting game={game} />
}
