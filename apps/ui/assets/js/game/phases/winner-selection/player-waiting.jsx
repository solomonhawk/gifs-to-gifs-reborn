import React, { useMemo } from 'react'
import Media from '../../components/media'
import { getRandomThinkingImage } from '../../../data/images'

export default function PlayerWaiting({ game }) {
  let image = useMemo(getRandomThinkingImage, [])

  return (
    <>
      <h3 className="center">Round #{game.round_number}: Winner Selection</h3>

      <p className="center">
        <strong>{game.funmaster.name}</strong> is picking the winner.
      </p>

      <Media src={image} />
    </>
  )
}
