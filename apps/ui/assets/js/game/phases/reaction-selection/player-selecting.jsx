import React from 'react'
import Media from '../../media'

export default function PlayerSelecting({ game, send }) {
  return (
    <>
      <h3>Choose your reaction!</h3>

      <Media src={game.prompt} />

      <button
        onClick={() =>
          send('select_reaction', {
            reaction: 'https://media.giphy.com/media/RLi2oeVZiVkE8/giphy.gif'
          })
        }
      >
        Select
      </button>
    </>
  )
}
