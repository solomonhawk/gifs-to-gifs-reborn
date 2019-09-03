import React, { useMemo } from 'react'
import Button from '../components/button'
import Media from '../components/media'
import { isCreator } from '../../data/helpers'
import shuffle from 'lodash-es/shuffle'

let images = [
  'https://media.giphy.com/media/GpyS1lJXJYupG/giphy.gif',
  'https://media.giphy.com/media/10JhviFuU2gWD6/giphy.gif',
  'https://media.giphy.com/media/OhrNfRrBxgz16/giphy.gif',
  'https://media.giphy.com/media/JmsG1PY1K94hyOa1v9/giphy.gif',
  'https://media.giphy.com/media/Yq1pe2v7nNlwA/giphy.gif',
  'https://media.giphy.com/media/ff0dv4KMGxjna/giphy.gif',
  'https://media.giphy.com/media/dPghHslnqEKLC/giphy.gif',
  'https://media.giphy.com/media/O5NyCibf93upy/giphy.gif',
  'https://media.giphy.com/media/ufiB4rMy9GUUg/giphy.gif',
  'https://media.giphy.com/media/dC9DTdqPmRnlS/giphy.gif',
  'https://media.giphy.com/media/fGuqeA6PiXINa/giphy.gif',
  'https://media.giphy.com/media/uLAoIx3H2qLW8/giphy.gif',
  'https://media.giphy.com/media/xUA7aM09ByyR1w5YWc/giphy.gif',
  'https://media.giphy.com/media/9MFsKQ8A6HCN2/giphy.gif',
  'https://media.giphy.com/media/Vg0JstydL8HCg/giphy.gif',
  'https://media.giphy.com/media/r1wGrCEZ4zTeU/giphy.gif',
  'https://media.giphy.com/media/Ic97mPViHEG5O/giphy.gif',
  'https://media.giphy.com/media/pGU7k489QGCQ0/giphy.gif',
  'https://media.giphy.com/media/g8A1eJhTQ7Iic/giphy.gif',
  'https://media.giphy.com/media/57DX612XYgQKI/giphy.gif',
  'https://media.giphy.com/media/Y5GVgQZCluUWQ/giphy.gif'
]

export function getRandomLaughImage() {
  return shuffle(images).pop()
}

/**
 * Game Start screen (pre-first-round)
 *
 *    game has started
 *    lasts for 10 rounds
 *    winner has the highest score at the end
 *    each round a different person will be the judge
 *    judge picks prompt, players pick reactions, time is limited!
 *
 * - "Get ready to play!"
 * - Try to make the funmaster laugh, earn points, and crush the competition.
 */
export default function GameStart({ game, player, send }) {
  let image = useMemo(getRandomLaughImage, [])

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
        <Media src={image} />
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
