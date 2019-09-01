export function isCreator(game, player) {
  return game.creator.id === player.id
}

export function isFunmaster(game, player) {
  return game.funmaster.id === player.id
}

export function isRoundWinner(game, player) {
  return game.round_winner && game.round_winner.id === player.id
}

export function reactionFor(game, player) {
  return game.reactions[player.id]
}

export function scoreFor(game, player) {
  return 100 * game.scores[player.id]
}

export function reactionCount(game) {
  return `${game.reaction_count}/${game.player_count - 1}`
}
