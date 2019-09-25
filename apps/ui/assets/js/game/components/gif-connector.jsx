import React, { useMemo } from 'react'
import { getRandomPatternImage } from '../../data/images'

export default function GifConnector() {
  let image = useMemo(getRandomPatternImage, [])

  return (
    <div className="gif-connector">
      <div
        className="gif-connector-content"
        style={{ backgroundImage: `url(${image})` }}
      />
    </div>
  )
}
