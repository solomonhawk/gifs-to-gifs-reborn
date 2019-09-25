import React, { useMemo } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import { getRandomThinkingImage } from '../../../data/images'

export default function PlayerWaiting({ game }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number}: Winner Selection</h3>

      <p className="center">
        <strong>{game.funmaster.name}</strong> is picking the winner.
      </p>

      <FixedRatio ratio={16 / 9}>
        <Media src={useMemo(getRandomThinkingImage, [])} />
      </FixedRatio>
    </>
  )
}
