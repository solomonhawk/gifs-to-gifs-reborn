import React, { useMemo } from 'react'
import cx from 'classnames'
import shuffle from 'lodash-es/shuffle'

let images = [
  'https://media.giphy.com/media/3o85xJx0QnnVYnGKRi/giphy.gif',
  'https://media.giphy.com/media/cFRhobC9AWc24/giphy.gif',
  'https://media.giphy.com/media/3og0IDoDo2TeidxKbm/giphy.gif',
  'https://media.giphy.com/media/d3mlXPjoK1ROfr9u/giphy.gif',
  'https://media.giphy.com/media/3o6UBbF9JIiXyDdcKA/giphy.gif',
  'https://media.giphy.com/media/xT9IgO6eylAYeIZFhC/giphy.gif',
  'https://media.giphy.com/media/5b9u8sfNYp4eXWwLYf/giphy.gif',
  'https://media.giphy.com/media/ixZb4d3OL8SyY/giphy.gif',
  'https://media.giphy.com/media/3og0IROkdNyWyCG2I0/giphy.gif'
]

export function getRandomFractalImage() {
  return shuffle(images).pop()
}

export default function Button({
  style = {},
  className = '',
  bg,
  children,
  ...props
}) {
  bg = bg || useMemo(getRandomFractalImage, [])

  return (
    <button
      type="button"
      {...props}
      className={cx('button', className)}
      style={{
        backgroundImage: `linear-gradient(
        to right,
        rgba(48, 147, 255, 0.7),
        rgba(48, 147, 255, 0.7)
      ), url(${bg})`,
        ...style
      }}
    >
      {children}
    </button>
  )
}
