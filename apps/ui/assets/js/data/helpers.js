export function isCreator(game, player) {
  return game.creator.id === player.id
}

export function isFunmaster(game, player) {
  return game.funmaster.id === player.id
}

export function reactionFor(game, player) {
  return game.reactions[player.id]
}
