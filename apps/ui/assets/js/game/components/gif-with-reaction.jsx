import React from 'react'
import FixedRatio from './fixed-ratio'
import Media from './media'
import GifConnector from './gif-connector'

const defaultImage =
  'https://media.giphy.com/media/g01ZnwAUvutuK8GIQn/giphy.gif'

export default function GifWithReaction({
  upper,
  children = <GifConnector />,
  lower = defaultImage
}) {
  return (
    <>
      <FixedRatio ratio={16 / 9} className="reaction-upper">
        <Media src={upper} />
      </FixedRatio>

      {children}

      <FixedRatio ratio={16 / 9} className="reaction-lower">
        <Media src={lower} />
      </FixedRatio>
    </>
  )
}
