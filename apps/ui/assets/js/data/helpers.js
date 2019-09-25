import result from 'lodash/result'

export function isCreator(game, player) {
  return game.creator.id === player.id
}

export function isFunmaster(game, player) {
  return game.funmaster.id === player.id
}

export function isRoundWinner(game, player) {
  return result(roundWinner(game), 'id') === player.id
}

export function reactionFor(game, player) {
  return game.reactions[player.id]
}

export function scoreFor(game, player) {
  return 100 * game.scores[player.id]
}

export function reactionCountText(game) {
  return `${game.reaction_count}/${game.player_count - 1}`
}

export function allPlayersReacted(game) {
  return game.reaction_count === game.player_count - 1
}

export function roundWinner(game) {
  return game.round_winner
}

export function winnerCount(game) {
  return game.winners.length
}

export function gameWinner(game) {
  return game.winners[0]
}

export function gameWinners(game) {
  return game.winners
}

export function isWinner(game, player) {
  return gameWinners(game).find(w => w.id === player.id)
}

export function isTie(game) {
  return winnerCount(game) > 1
}

export function playerName(game, id) {
  return result(game.players[id], 'name')
}
