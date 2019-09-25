import React from 'react'
import cx from 'classnames'

export default function Media({ src, style, className }) {
  if (!src) {
    return null
  }

  let ext = src.split('.').pop()

  if (ext === 'mp4') {
    return (
      <video
        className={cx('media', className)}
        autoPlay
        loop
        muted
        style={style}
      >
        <source src={src} type={`video/${ext}`} />
      </video>
    )
  }

  return <img className={cx('media', className)} style={style} src={src} />
}
