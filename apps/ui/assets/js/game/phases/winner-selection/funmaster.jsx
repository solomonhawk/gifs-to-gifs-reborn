import React, { useMemo, useState } from 'react'
import ReactionViewer from './reaction-viewer'
import Button from '../../components/button'
import { getRandomFractalImage } from '../../../data/images'

export default function Funmaster({ game, send }) {
  let [winnerId, setWinnerId] = useState(null)

  let onSelect = () =>
    send('select_winner', {
      winner: game.players[winnerId]
    })

  let buttonImage = useMemo(getRandomFractalImage, [])

  return (
    <>
      <h3 className="center">Round #{game.round_number}: Choose a winner.</h3>

      <ReactionViewer
        game={game}
        winnerId={winnerId}
        onChange={setWinnerId}
        buttonBg={buttonImage}
      />

      <Button
        className="mt-auto full-width"
        onClick={onSelect}
        bg={buttonImage}
      >
        Select Winner
      </Button>
    </>
  )
}
