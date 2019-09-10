import React from 'react'
import { scoreFor, isFunmaster, isRoundWinner } from '../../data/helpers'
import sortBy from 'lodash-es/sortBy'

export default function PlayerList({ game, player }) {
  let rows = sortBy(
    Object.values(game.players).map(p => {
      return {
        id: p.id,
        name: p.name,
        score: scoreFor(game, p),
        isPlayer: p.id === player.id,
        isFunmaster: isFunmaster(game, p),
        isRoundWinner: isRoundWinner(game, p)
      }
    }),
    'score'
  ).reverse()

  return (
    <table className="table">
      <thead>
        <tr>
          <th>Player</th>
          <th>Score</th>
        </tr>
      </thead>

      <tbody>
        {rows.map((row, i) => (
          <tr key={row.id}>
            <td>
              <span>{row.name}</span>

              {row.isPlayer && ' (🤖)'}
              {row.isFunmaster && ' (🎩)'}
              {row.isRoundWinner && ' (👑)'}
            </td>
            <td>{row.score}</td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}
