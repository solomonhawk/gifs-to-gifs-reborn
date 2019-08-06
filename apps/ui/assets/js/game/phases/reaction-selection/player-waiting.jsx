import React from 'react'
import Media from '../../media'
import {reactionFor} from '../../../data/helpers'

export default function PlayerWaiting({ game, player }) {
  return (
    <>
      <Media src={game.prompt} />

      <p>Your reaction is:</p>

      <Media src={reactionFor(game, player)} />
    </>
  )
}
