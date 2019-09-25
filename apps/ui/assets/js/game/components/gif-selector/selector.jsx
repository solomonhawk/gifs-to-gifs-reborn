import React, { useMemo } from 'react'
import Media from '../media'
import Button from '../button'
import FixedRatio from '../fixed-ratio'
import { getRandomFractalImage } from '../../../data/images'
import cx from 'classnames'

export default function Selector({
  setSearchTerm,
  isSearching,
  reaction,
  results,
  onShuffle,
  onSelect
}) {
  let buttonImage = useMemo(getRandomFractalImage, [])

  let image = (function() {
    if (isSearching) {
      return (
        <Media src="https://media.giphy.com/media/xTkcEQACH24SMPxIQg/giphy.gif" />
      )
    } else if (reaction) {
      return <Media key={reaction} src={reaction} />
    } else {
      return <Media className="search-preview" src="/images/giphy.png" />
    }
  })()

  return (
    <>
      <label className="visually-hidden" htmlFor="search">
        Search
      </label>

      <input
        className="text-input"
        id="search"
        name="q"
        placeholder="Enter a search term..."
        autoComplete="off"
        onChange={e => setSearchTerm(e.target.value)}
      />

      <div className="pb-2">
        <FixedRatio ratio={16 / 9} className="reaction-lower">
          {image}
        </FixedRatio>
      </div>

      <div className="flex mt-auto">
        <Button
          className="mr-2 text-icon-button"
          disabled={!results.length}
          onClick={onShuffle}
          bg={buttonImage}
        >
          <div className={cx({ spin: results.length })}>↻</div>
        </Button>

        <Button
          className="full-width"
          bg={buttonImage}
          disabled={!reaction}
          onClick={onSelect}
        >
          Select
        </Button>
      </div>
    </>
  )
}
