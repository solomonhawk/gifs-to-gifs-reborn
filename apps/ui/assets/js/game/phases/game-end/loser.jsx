import React, { useMemo } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import { getRandomLoserImage } from '../../../data/images'

export default function Loser() {
  let image = useMemo(getRandomLoserImage, [])

  return (
    <>
      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={image} />
        </FixedRatio>
      </div>

      <h2 className="center">You lost ☹️</h2>
    </>
  )
}
