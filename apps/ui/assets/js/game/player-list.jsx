import React from 'react'

export default function PlayerList({ funmaster, players, scores }) {
  let rows = Object.values(players).map(({ id, name }) => {
    return {
      id,
      name,
      isFunmaster: funmaster && id === funmaster.id,
      score: scores[id]
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
              {row.isFunmaster && '*'}
            </td>
            <td>{row.score}</td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}
