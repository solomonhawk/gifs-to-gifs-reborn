import React from 'react'
import Countdown from '../../components/countdown'
import { reactionCount, allPlayersReacted } from '../../../data/helpers'

export default function Funmaster({ game }) {
  if (allPlayersReacted(game)) {
    return (
      <>
        <p className="center">
          Reactions are in, <em>get ready to pick a winner!</em>
        </p>

        <h2 className="center">{reactionCount(game)}</h2>

        <Countdown ms={game.config.winner_selection_timeout}>
          {({ remainder }) => (
            <p className="center">Starting winner selection in {remainder}.</p>
          )}
        </Countdown>
      </>
    )
  }

  return (
    <>
      <p className="center">Waiting for players to choose their reactions!</p>

      <h2 className="center">{reactionCount(game)}</h2>
    </>
  )
}