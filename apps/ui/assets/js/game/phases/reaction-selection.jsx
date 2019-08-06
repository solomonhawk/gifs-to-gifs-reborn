import React from 'react'
import Funmaster from './reaction-selection/funmaster'
import PlayerSelecting from './reaction-selection/player-selecting'
import PlayerWaiting from './reaction-selection/player-waiting'
import { isFunmaster, reactionFor } from '../../data/helpers'

export default function ReactionSelection({ game, player, send }) {
  if (isFunmaster(game, player)) {
    return <Funmaster game={game} />
  }

  if (reactionFor(game, player)) {
    return <PlayerWaiting game={game} player={player} />
  }

  return <PlayerSelecting game={game} send={send} />
}
