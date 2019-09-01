import React from 'react'
import { reactionCount } from '../../../data/helpers'

export default function Funmaster({ game }) {
  return (
    <>
      <p>Waiting for players to choose their reactions!</p>

      <small>
        {reactionCount(game)} reactions.
      </small>
    </>
  )
}
