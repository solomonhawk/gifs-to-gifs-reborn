import React, { useMemo } from 'react'
import Countdown from '../../components/countdown'
import Media from '../../components/media'
import { reactionCount, allPlayersReacted } from '../../../data/helpers'
import { getRandomThinkingImage } from '../../../data/images'

export default function Funmaster({ game }) {
  if (allPlayersReacted(game)) {
    return (
      <>
        <p className="center">
          Reactions are in, <em>get ready to pick a winner</em>
        </p>

        <h2 className="center">{reactionCount(game)}</h2>

        <Countdown ms={game.config.winner_selection_timeout}>
          {({ remainder }) => (
            <p className="center">
              Starting winner selection in{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          )}
        </Countdown>
      </>
    )
  }

  let image = useMemo(getRandomThinkingImage, [])

  return (
    <>
      <p className="center">Waiting for players to choose their reactions</p>

      <Countdown ms={game.config.reaction_selection_timeout}>
        {({ remainder }) => (
          <p className="center">
            Time remaining{' '}
            <strong key={remainder} className="zoop">
              {remainder}
            </strong>
          </p>
        )}
      </Countdown>

      <h2 className="center">{reactionCount(game)}</h2>

      <Media src={image} />
    </>
  )
}
