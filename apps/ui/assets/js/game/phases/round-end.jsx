import React from 'react'
import PlayerList from '../components/player-list'
import Countdown from '../components/countdown'

export default function RoundEnd({ game, player }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number} is over!</h3>

      <p className="center">
        <strong>{game.round_winner.name}</strong> wins this time!
      </p>

      <Countdown ms={5000}>
        {({ remainder }) =>
          game.game_over ? (
            <p className="center">Game ends in {remainder}.</p>
          ) : (
            <p className="center">Next round begins in {remainder}!</p>
          )
        }
      </Countdown>

      <PlayerList game={game} player={player} />
    </>
  )
}
