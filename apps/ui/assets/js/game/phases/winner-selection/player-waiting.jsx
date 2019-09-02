import React from 'react'

export default function PlayerWaiting({ game }) {
  return (
    <>
      <h3 className="center">Round #{game.round_number}: Winner Selection</h3>

      <p className="center">
        <strong>{game.funmaster.name}</strong> is picking the winner.
      </p>
    </>
  )
}
