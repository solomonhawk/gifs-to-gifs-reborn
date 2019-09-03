import React from 'react'
import Media from '../components/media'
import FixedRatio from '../components/fixed-ratio'
import Button from '../components/button'
import { isFunmaster } from '../../data/helpers'

let prompt = 'https://i.imgur.com/Lh0yoPt.mp4'

export default function PromptSelection({ game, player, send }) {
  if (isFunmaster(game, player)) {
    return (
      <>
        <h3 className="center">Round #{game.round_number}: Choose a prompt.</h3>

        <div className="pb-2">
          <FixedRatio ratio={16 / 9}>
            <Media src={prompt} />
          </FixedRatio>
        </div>

        <Button
          className="mt-auto full-width"
          onClick={() => send('select_prompt', { prompt })}
        >
          Select Prompt
        </Button>
      </>
    )
  }

  return (
    <>
      <h3 className="center">Round #{game.round_number}</h3>

      <p className="center">
        Waiting for <strong>{game.funmaster.name}</strong> to pick a prompt
      </p>
    </>
  )
}
