import React from 'react'
import PlayerList from '../components/player-list'
import Countdown from '../components/countdown'
import { reactionFor, isRoundWinner, roundWinner } from '../../data/helpers'
import GifWithReaction from '../components/gif-with-reaction'

export default function RoundEnd({ game, player }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number} is over</h3>

      <p className="center">
        {isRoundWinner(game, player) ? (
          <>
            🏆 <strong>You</strong> won the round!
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

      <GifWithReaction
        upper={game.prompt}
        lower={reactionFor(game, game.round_winner)}
      />

      <PlayerList game={game} player={player} />
    </>
  )
}
