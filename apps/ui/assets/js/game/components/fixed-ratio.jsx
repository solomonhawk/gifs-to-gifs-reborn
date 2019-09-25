import React from 'react'
import cx from 'classnames'

export default function FixedRatio({ ratio, children, className }) {
  return (
    <div
      className={cx('fixed-ratio', className)}
      style={{ paddingTop: (1 / ratio) * 100 + '%' }}
    >
      <div className="fixed-ratio-content">{children}</div>
    </div>
  )
}
