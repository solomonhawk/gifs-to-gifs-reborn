import React from 'react'

export default function Media({ src }) {
  if (!src) {
    return null
  }

  let ext = src.split('.').pop()

  if (ext === 'mp4') {
    return (
      <video className="media" autoPlay loop muted>
        <source src={src} type={`video/${ext}`} />
      </video>
    )
  }

  return <img className="media" src={src} />
}
