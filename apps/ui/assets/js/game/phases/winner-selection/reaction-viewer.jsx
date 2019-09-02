import React, { useState, useEffect } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import Button from '../../components/button'

export default function ReactionViewer({ game, winnerId, onChange }) {
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
        <Button onClick={() => advance(-1)}>Prev</Button>
        {winnerId ? <span>{game.players[winnerId].name}</span> : null}
        <Button onClick={() => advance(1)}>Next</Button>
      </div>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={Object.values(game.reactions)[index]} />
        </FixedRatio>
      </div>
    </>
  )
}
