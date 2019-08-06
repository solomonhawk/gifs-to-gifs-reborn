import React from 'react'

export default function Media({ src }) {
  let ext = src.split('.').pop()

  if (ext === 'mp4') {
    return (
      <video autoPlay loop muted style={{ maxWidth: '100%' }}>
        <source src={src} type={`video/${ext}`} />
      </video>
    )
  }

  return <img src={src} style={{ maxWidth: '100%' }} />
}
