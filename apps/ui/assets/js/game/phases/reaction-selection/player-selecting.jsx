import React, { useMemo, useState } from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import Button, { getRandomFractalImage } from '../../components/button'
import shuffle from 'lodash-es/shuffle'

let reactions = [
  'https://media.giphy.com/media/JsnAcyViedw7OdQDFR/giphy.gif',
  'https://media.giphy.com/media/RLi2oeVZiVkE8/giphy.gif',
  'https://media.giphy.com/media/5BUJlxujXJwR8EiSB4/giphy.gif',
  'https://media.giphy.com/media/nlwmJQjtbfNZu/giphy.gif'
]

let getReaction = () => shuffle(reactions).pop()

export default function PlayerSelecting({ game, send }) {
  let [reaction, setReaction] = useState(getReaction())

  let getRandomReaction = () => {
    let nextReaction = getReaction()

    if (nextReaction === reaction) {
      return getRandomReaction()
    }

    setReaction(nextReaction)
  }

  let buttonImage = useMemo(getRandomFractalImage, [])

  return (
    <>
      <h3 className="center">
        Round #{game.round_number}: Choose your reaction.
      </h3>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={game.prompt} />
        </FixedRatio>
      </div>

      <div className="pb-2">
        <FixedRatio ratio={16 / 9}>
          <Media src={reaction} />
        </FixedRatio>
      </div>

      <div className="flex mt-auto">
        <Button
          className="mr-2"
          onClick={getRandomReaction}
          bg={buttonImage}
          style={{
            fontSize: 18,
            lineHeight: '18px',
            fontWeight: 'normal'
          }}
        >
          ↻
        </Button>

        <Button
          className="full-width"
          bg={buttonImage}
          onClick={() =>
            send('select_reaction', {
              reaction
            })
          }
        >
          Select
        </Button>
      </div>
    </>
  )
}
