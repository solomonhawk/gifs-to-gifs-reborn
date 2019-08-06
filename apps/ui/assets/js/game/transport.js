import { Socket, Presence } from 'phoenix'

class Transport {
  constructor(token, shortcode, onChange) {
    this.shortcode = shortcode
    this.socket = new Socket('/socket', { params: { token } })
    this.socket.connect()
    this.channel = this.socket.channel(`games:${shortcode}`, {})
    this.presences = {}
    this.gameState = {}
    this.error = null
    this.onChange = onChange

    this.setup()
  }

  setup() {
    this.channel
      .join()
      .receive('ok', response => {
        console.log(`Joined '${this.shortcode}' successfully 😊`, response)
      })
      .receive('error', response => {
        this.error = `Joining ${this.shortcode} failed 🙁`
        console.log(this.error, response)
      })

    this.channel.on('game_summary', state => {
      this.gameState = state

      console.log('Received summary', state)

      this.onChange(state, this.presences)
    })

    this.channel.on('presence_state', state => {
      this.presences = Presence.syncState(this.presences, state)

      console.log('Received presences state', state)
      console.log(this.presences)

      this.onChange(this.gameState, this.presences)
    })

    this.channel.on('presence_diff', diff => {
      this.presences = Presence.syncDiff(this.presences, diff)

      console.log('Received presences diff', diff)
      console.log(this.presences)

      this.onChange(this.gameState, this.presences)
    })
  }

  send = (message, params = {}) => {
    this.channel.push(message, params)
  }
}

export default Transport
