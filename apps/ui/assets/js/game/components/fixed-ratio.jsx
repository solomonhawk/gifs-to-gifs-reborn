import React from 'react'

export default function FixedRatio({ ratio, children }) {
  return (
    <div className="fixed-ratio" style={{ paddingTop: (1 / ratio) * 100 + '%'}}>
      <div className="fixed-ratio-content">
        {children}
      </div>
    </div>
  )
}
