import React, { useMemo } from 'react'
import cx from 'classnames'
import { getRandomFractalImage } from '../../data/images'

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
