import React from 'react'

export default function GameEnd({ game }) {
  return (
    <>
      <h3>All done.</h3>

      {game.winners.length === 1 ? (
        <p>{game.winners[0].name} wins!</p>
      ) : (
        <ul>
          {game.winners.map(({ id, name }) => (
            <li key={id}>{name}</li>
          ))}
        </ul>
      )}
    </>
  )
}
