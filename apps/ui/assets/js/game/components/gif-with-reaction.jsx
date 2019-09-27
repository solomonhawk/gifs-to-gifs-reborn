import React from 'react'
import FixedRatio from './fixed-ratio'
import Media from './media'
import GifConnector from './gif-connector'
import cx from 'classnames'

export default function GifWithReaction({
  upper,
  children = <GifConnector />,
  lower
}) {
  return (
    <>
      <FixedRatio ratio={16 / 9} className="reaction-upper">
        <Media src={upper} />
      </FixedRatio>

      {children}

      <FixedRatio ratio={16 / 9} className="reaction-lower">
        <Media
          className={cx({ 'search-preview': !lower })}
          src={lower || '/images/giphy.png'}
        />
      </FixedRatio>
    </>
  )
}
