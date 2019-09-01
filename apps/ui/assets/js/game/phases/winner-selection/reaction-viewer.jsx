import React, { useState, useEffect } from 'react'
import Media from '../../media'

export default function ReactionViewer({ game, onChange }) {
  let [index, setIndex] = useState(0)

  let advance = (direction) => {
    let nextIndex = index + direction

    if (nextIndex < 0) {
      nextIndex = nextIndex + game.player_count
    }

    setIndex(nextIndex % game.reaction_count)
  }

  useEffect(() => onChange(Object.keys(game.reactions)[index]), [index])

  return (
    <>
      <Media src={game.prompt} />
      <span>{index}</span>
      <button onClick={() => advance(-1)}>Prev</button>
      <button onClick={() => advance(1)}>Next</button>
      <Media src={Object.values(game.reactions)[index]} />
    </>
  )
}
