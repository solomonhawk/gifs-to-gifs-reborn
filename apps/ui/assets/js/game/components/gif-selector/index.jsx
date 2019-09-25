import React, { useEffect, useState, useCallback } from 'react'
import { useDebounce } from 'use-debounce'
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
  let [debouncedIsSearching] = useDebounce(isSearching, 500, { leading: true })
  let [debouncedSearchTerm] = useDebounce(searchTerm, 500)

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
        .catch(error => {
          // @TODO(shawk): error handling, global or local TBD
          alert(
            result(error.response.data.message) ||
              'Ooops! Something went wrong.'
          )
        })
    } else {
      setResults([])
    }
  }, [debouncedSearchTerm])

  return (
    <Selector
      setSearchTerm={setSearchTerm}
      isSearching={debouncedIsSearching}
      reaction={reaction}
      results={results}
      onShuffle={() => shuffleResults(results)}
      onSelect={() => onSelect(reaction)}
    />
  )
}
