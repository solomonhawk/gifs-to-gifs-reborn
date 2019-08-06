import React from 'react'
import { isFunmaster } from '../../data/helpers'

export default function PromptSelection({ game, player, send }) {
  if (isFunmaster(game, player)) {
    return (
      <button
        onClick={() =>
          send('select_prompt', { prompt: 'https://i.imgur.com/Lh0yoPt.mp4' })
        }
      >
        Select Prompt
      </button>
    )
  }

  return <p>Waiting for {game.funmaster.name} to pick a prompt!</p>
}
