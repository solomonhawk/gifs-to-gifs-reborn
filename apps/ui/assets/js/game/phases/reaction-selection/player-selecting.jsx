import React from 'react'
import Media from '../../components/media'
import FixedRatio from '../../components/fixed-ratio'
import Countdown from '../../components/countdown'
import GifSelector from '../../components/gif-selector'
import renderIf from 'render-if'

export default function PlayerSelecting({ game, send }) {
  let timeout = game.config.reaction_selection_timeout

  return (
    <>
      <h3 className="center">
        Round #{game.round_number}: Choose your reaction.
      </h3>

      {renderIf(timeout)(
        <Countdown ms={timeout}>
          {({ remainder }) => (
            <p className="center">
              Time remaining{' '}
              <strong key={remainder} className="zoop">
                {remainder}
              </strong>
            </p>
          )}
        </Countdown>
      )}

      <FixedRatio ratio={16 / 9} className="reaction-upper">
        <Media src={game.prompt} />
      </FixedRatio>

      <GifSelector
        onSelect={reaction => send('select_reaction', { reaction })}
      />
    </>
  )
}
