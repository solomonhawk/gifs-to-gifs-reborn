import React, { useMemo } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import { getRandomWinnerImage } from '../../../data/images'

export default function Winner({ tie }) {
  let image = useMemo(getRandomWinnerImage, [])
  return (
    <>
      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={image} />
        </FixedRatio>
      </div>

      <h2 className="center">You {tie ? 'tied' : 'won'}! 😎</h2>
    </>
  )
}
