import React from 'react'
import Countdown from '../../components/countdown'
import renderIf from 'render-if'
import { reactionFor, allPlayersReacted } from '../../../data/helpers'
import GifWithReaction from '../../components/gif-with-reaction'

export default function PlayerWaiting({ game, player }) {
  let timeout = game.config.reaction_selection_timeout
  let advancingToWinnerSelection = allPlayersReacted(game)

  return (
    <>
      {renderIf(advancingToWinnerSelection)(
        <Countdown ms={game.config.winner_selection_timeout}>
          {({ remainder }) => (
            <p className="center">
              Winner selection begins in{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          )}
        </Countdown>
      )}

      {renderIf(!advancingToWinnerSelection)(
        <p className="center">
          Waiting for other players to choose their reactions
        </p>
      )}

      {/* TODO(shawk): calculate countdown time remaining based on time phase started */}
      {renderIf(timeout && !advancingToWinnerSelection)(
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

      <span>Your reaction to {game.funmaster.name}'s Prompt:</span>

      <GifWithReaction upper={game.prompt} lower={reactionFor(game, player)} />
    </>
  )
}
