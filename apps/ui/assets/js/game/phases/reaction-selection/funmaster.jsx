import React from 'react'

export default function Funmaster({ game }) {
  return (
    <>
      <p>Waiting for players to choose their reactions!</p>

      <small>
        {game.reaction_count}/{game.player_count - 1} reactions.
      </small>
    </>
  )
}
