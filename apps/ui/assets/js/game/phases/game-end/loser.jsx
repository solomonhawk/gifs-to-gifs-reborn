import React, { useMemo } from 'react'
import Media from '../../components/media'
import { getRandomLoserImage } from '../../../data/images'

export default function Loser() {
  let image = useMemo(getRandomLoserImage, [])

  return (
    <>
      <div className="pb-2">
        <Media src={image} />
      </div>

      <h2 className="center">You lost ☹️</h2>
    </>
  )
}
