import React, { useEffect, useState, useCallback } from 'react'
import useDebounce from '../../../hooks/use-debounce'
import isEqual from 'lodash-es/isEqual'
import shuffle from 'lodash-es/shuffle'
import result from 'lodash-es/result'
import API from '../../../services/api'
import Selector from './selector'

export default function GifSelector({ onSelect }) {
  let [reaction, setReaction] = useState(null)
  let [searchTerm, setSearchTerm] = useState('')
  let [results, setResults] = useState([])
  let [isSearching, setIsSearching] = useState(false)
  let debouncedSearchTerm = useDebounce(searchTerm, 500)

  let shuffleResults = useCallback(
    results => {
      let order = shuffle(results)

      if (isEqual(result(order, '0.images.original.url'), reaction)) {
        return shuffleResults(order)
      }

      setResults(order)
      setReaction(order[0].images.original.url)
    },
    [results]
  )

  /**
   * Fetch new results when search input changes (debounced)
   */
  useEffect(() => {
    if (debouncedSearchTerm) {
      setIsSearching(true)

      API.giphy
        .search(debouncedSearchTerm, { params: { limit: 100 } })
        .then(results => {
          setIsSearching(false)
          shuffleResults(results)
        })
    } else {
      setResults([])
    }
  }, [debouncedSearchTerm])

  return (
    <Selector
      setSearchTerm={setSearchTerm}
      isSearching={isSearching}
      reaction={reaction}
      results={results}
      onShuffle={() => shuffleResults(results)}
      onSelect={() => onSelect(reaction)}
    />
  )
}
