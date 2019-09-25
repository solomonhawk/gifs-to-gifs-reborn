import React, { useState, useEffect } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import Button from '../../components/button'
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
        <FixedRatio ratio={16 / 9}>
          <Media src={game.prompt} />
        </FixedRatio>
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
          {playerId ? <span>{playerName(game, playerId)}</span> : null} (
          {index + 1}/{game.reaction_count})
        </div>

        <Button
          bg={buttonBg}
          onClick={() => advance(1)}
          disabled={game.reaction_count < 2}
        >
          Next
        </Button>
      </div>

      {playerId ? (
        <div className="pb-2">
          <FixedRatio ratio={16 / 9}>
            <Media src={Object.values(game.reactions)[index]} />
          </FixedRatio>
        </div>
      ) : null}
    </>
  )
}
