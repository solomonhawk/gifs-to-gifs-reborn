import React from 'react'
import { scoreFor, isFunmaster, isRoundWinner } from '../data/helpers'

export default function PlayerList({ game }) {
  let rows = Object.values(game.players).map(player => {
    return {
      id: player.id,
      name: player.name,
      score: scoreFor(game, player),
      isFunmaster: isFunmaster(game, player),
      isRoundWinner: isRoundWinner(game, player)
    }
  })

  return (
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>Score</th>
        </tr>
      </thead>

      <tbody>
        {rows.map(row => (
          <tr key={row.id}>
            <td>
              <span style={{ fontWeight: row.isFunmaster ? 'bold' : null }}>
                {row.name}
              </span>
              {row.isFunmaster && ' (funmaster)'}
              {row.isRoundWinner && ' (round winner)'}
            </td>
            <td>{row.score}</td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}
