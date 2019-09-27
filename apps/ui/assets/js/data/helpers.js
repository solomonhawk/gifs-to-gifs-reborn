import result from 'lodash/result'

export function id(player) {
  return result(player, 'id')
}
export function isCreator(game, player) {
  return id(game.creator) === id(player)
}

export function isFunmaster(game, player) {
  return id(game.funmaster) === id(player)
}

export function isRoundWinner(game, player) {
  return id(roundWinner(game)) === id(player)
}

export function reactionFor(game, player) {
  return result(game.reactions, id(player))
}

export function scoreFor(game, player) {
  return 100 * result(game.scores, id(player), 0)
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
  return gameWinners(game).find(w => w.id === id(player))
}

export function isTie(game) {
  return winnerCount(game) > 1
}

export function playerName(game, id) {
  return result(game.players[id], 'name')
}
