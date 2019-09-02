import React from 'react'
import Media from '../../components/media'
import Countdown from '../../components/countdown'
import FixedRatio from '../../components/fixed-ratio'
import { reactionFor, allPlayersReacted } from '../../../data/helpers'

export default function PlayerWaiting({ game, player }) {
  return (
    <>
      {allPlayersReacted(game) ? (
        <Countdown ms={5000}>
          {({ remainder }) => (
            <p className="center">Winner selection begins in {remainder}!</p>
          )}
        </Countdown>
      ) : null}

      <p className="center">
        Waiting for other players to choose their reactions!
      </p>

      <span>{game.funmaster.name}'s Prompt:</span>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={game.prompt} />
        </FixedRatio>
      </div>

      <span>Your reaction:</span>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={reactionFor(game, player)} />
        </FixedRatio>
      </div>
    </>
  )
}
