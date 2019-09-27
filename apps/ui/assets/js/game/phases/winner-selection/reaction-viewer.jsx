import React, { useState, useEffect } from 'react'
import Button from '../../components/button'
import GifWithReaction from '../../components/gif-with-reaction'
import { playerName } from '../../../data/helpers'

export default function ReactionViewer({ game, playerId, onChange, buttonBg }) {
  let [index, setIndex] = useState(0)

  let advance = direction => {
    let nextIndex = index + direction

    if (nextIndex < 0) {
      nextIndex = nextIndex + game.reaction_count
    }

    setIndex(nextIndex % game.reaction_count)
  }

  useEffect(() => onChange(Object.keys(game.reactions)[index]), [index])

  return (
    <>
      <div className="pb-2">
        <GifWithReaction
          upper={game.prompt}
          lower={playerId ? Object.values(game.reactions)[index] : undefined}
        />
      </div>

      <div className="flex justify-space-between align-center pb-2">
        <Button
          bg={buttonBg}
          onClick={() => advance(-1)}
          disabled={game.reaction_count < 2}
        >
          Prev
        </Button>

        <div>
          {playerId ? (
            <>
            <span>{playerName(game, playerId)}</span>{' '}
            ({index + 1}/{game.reaction_count})
            </>
          ) : (
            'No reactions!'
          )}
        </div>

        <Button
          bg={buttonBg}
          onClick={() => advance(1)}
          disabled={game.reaction_count < 2}
        >
          Next
        </Button>
      </div>
    </>
  )
}
