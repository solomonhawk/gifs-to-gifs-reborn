import React from 'react'
import PlayerList from '../player-list'

export default function RoundEnd({ game }) {
  return (
    <>
      <p>Round {game.round_number} is over!</p>
      <p>{game.round_winner.name} wins!</p>

      <PlayerList
        funmaster={game.funmaster}
        players={game.players}
        scores={game.scores}
      />
    </>
  )
}
