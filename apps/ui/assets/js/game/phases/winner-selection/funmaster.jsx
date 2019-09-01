import React, { useState } from 'react'
import ReactionViewer from './reaction-viewer'

export default function Funmaster({ game, send }) {
  let [winnerId, setWinnerId] = useState(null)

  let onSelect = () =>
    send('select_winner', {
      winner: game.players[winnerId]
    })

  return (
    <>
      <ReactionViewer game={game} onChange={setWinnerId} />
      <button onClick={onSelect}>Select Winner</button>
    </>
  )
}
