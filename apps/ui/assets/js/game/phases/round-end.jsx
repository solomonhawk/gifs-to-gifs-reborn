import React from 'react'
import PlayerList from '../components/player-list'
import Countdown from '../components/countdown'
import FixedRatio from '../components/fixed-ratio'
import Media from '../components/media'
import { reactionFor, isRoundWinner, roundWinner } from '../../data/helpers'

export default function RoundEnd({ game, player }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number} is over</h3>

      <p className="center">
        {isRoundWinner(game, player) ? (
          <>
            <strong>You</strong> won the round!
          </>
        ) : roundWinner(game) ? (
          <>
            <strong>{game.round_winner.name}</strong> wins this time!
          </>
        ) : (
          <strong>Nobody wins this time 🤔</strong>
        )}
      </p>

      <Countdown ms={game.config.round_end_timeout}>
        {({ remainder }) =>
          game.final_round ? (
            <p className="center">
              Game ends in{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          ) : (
            <p className="center">
              Next round begins in{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          )
        }
      </Countdown>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={game.prompt} />
        </FixedRatio>
      </div>

      {game.round_winner ? (
        <div className="pb-2">
          <FixedRatio ratio={16 / 9}>
            <Media src={reactionFor(game, game.round_winner)} />
          </FixedRatio>
        </div>
      ) : null}

      <PlayerList game={game} player={player} />
    </>
  )
}
