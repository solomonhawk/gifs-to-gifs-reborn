import useCountdown from '../../hooks/use-countdown'
import parseMs from 'parse-ms'

export default function Countdown({ ms, children }) {
  const countdown = useCountdown(() => Date.now() + ms)
  const { seconds } = parseMs(countdown)

  return children({ remainder: seconds })
}
