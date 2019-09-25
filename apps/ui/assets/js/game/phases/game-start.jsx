import React, { useMemo } from 'react'
import Button from '../components/button'
import Media from '../components/media'
import FixedRatio from '../components/fixed-ratio'
import { isCreator } from '../../data/helpers'
import { getRandomLaughImage } from '../../data/images'

/**
 * Game Start screen (pre-first-round)
 */
export default function GameStart({ game, player, send }) {
  return (
    <>
      <h3 className="center">Get ready to play!</h3>

      <p className="center">
        <span className="block">
          When you're the <strong>Funmaster</strong>:
        </span>
        <small className="secondary">
          Pick a good prompt, judge reactions by your own criteria.
        </small>
      </p>

      <p className="center">
        <span className="block">
          When you're a <strong>Player</strong>:
        </span>
        <small className="secondary">
          Make the Funmaster laugh, win points, and crush the competition.
        </small>
      </p>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={useMemo(getRandomLaughImage, [])} />
        </FixedRatio>
      </div>

      {isCreator(game, player) && (
        <Button
          className="mt-auto full-width"
          onClick={() => send('start_round')}
        >
          Start First Round
        </Button>
      )}
    </>
  )
}
