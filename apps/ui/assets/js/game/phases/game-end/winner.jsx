import React, { useMemo } from 'react'
import Media from '../../components/media'
import { getRandomWinnerImage } from '../../../data/images'

export default function Winner() {
  let image = useMemo(getRandomWinnerImage, [])

  return (
    <>
      <div className="pb-2">
        <Media src={image} />
      </div>

      <h2 className="center">You won! 😎</h2>
    </>
  )
}
