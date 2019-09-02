import React, { useState } from 'react'
import ReactionViewer from './reaction-viewer'
import Button from '../../components/button'

export default function Funmaster({ game, send }) {
  let [winnerId, setWinnerId] = useState(null)

  let onSelect = () =>
    send('select_winner', {
      winner: game.players[winnerId]
    })

  return (
    <>
      <h3 className="center">Round #{game.round_number}: Choose a winner.</h3>

      <ReactionViewer game={game} winnerId={winnerId} onChange={setWinnerId} />

      <Button className="mt-auto full-width" onClick={onSelect}>
        Select Winner
      </Button>
    </>
  )
}
