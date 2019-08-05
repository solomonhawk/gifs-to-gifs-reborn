import { Socket } from 'phoenix'

class Transport {
  constructor(token, shortcode) {
    this.socket = new Socket('/socket', { params: { token } })
    this.socket.connect()
    this.channel = this.socket.channel(`games:${shortcode}`, {})

    this.channel.join().receive('ok', res => {
      console.log('Joined successfully', res)
    })

    this.channel.on('game_summary', summary => {
      console.log('Received summary', summary)
    })
  }
}

export default Transport
