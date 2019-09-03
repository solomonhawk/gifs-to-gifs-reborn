import React from 'react'
import PlayerList from '../components/player-list'
import Countdown from '../components/countdown'

/**
 * Round Start screen (pre-round)
 */
export default function RoundStart({ game, player }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number}</h3>

      <p className="center">
        <strong>{game.funmaster.name}</strong> is the funmaster
      </p>

      <Countdown ms={game.config.round_start_timeout}>
        {({ remainder }) => (
          <p className="center">
            Starting in{' '}
            <strong key={remainder} className="zoop">
              {remainder}
            </strong>
          </p>
        )}
      </Countdown>

      <PlayerList game={game} player={player} />
    </>
  )
}
