import React, { useMemo } from 'react'
import Countdown from '../../components/countdown'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import renderIf from 'render-if'
import { reactionCountText, allPlayersReacted } from '../../../data/helpers'
import { getRandomThinkingImage } from '../../../data/images'

export default function Funmaster({ game }) {
  let timeout = game.config.reaction_selection_timeout

  if (allPlayersReacted(game)) {
    return (
      <>
        <p className="center">
          Reactions are in, <em>get ready to pick a winner</em>
        </p>

        <h2 className="center">{reactionCountText(game)}</h2>

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

      {renderIf(timeout)(
        <Countdown ms={timeout}>
          {({ remainder }) => (
            <p className="center">
              Time remaining{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          )}
        </Countdown>
      )}

      <h2 className="center">{reactionCountText(game)}</h2>

      <FixedRatio ratio={16 / 9}>
        <Media src={image} />
      </FixedRatio>
    </>
  )
}
