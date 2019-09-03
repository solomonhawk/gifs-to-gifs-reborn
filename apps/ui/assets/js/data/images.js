import shuffle from 'lodash-es/shuffle'

let thinkingImages = [
  'https://media.giphy.com/media/3o7budPMOMXVyvzolO/giphy.gif',
  'https://media.giphy.com/media/1XgSqCWMonbLLpxNev/giphy.gif',
  'https://media.giphy.com/media/xT0BKGcVvNFvATzpew/giphy.gif',
  'https://media.giphy.com/media/WpObP6Qx5QXq9TxHyh/giphy.gif',
  'https://media.giphy.com/media/pjAyfoUCaC5dm/giphy.gif',
  'https://media.giphy.com/media/yj5oYHjoIwv28/giphy.gif',
  'https://media.giphy.com/media/3ohc1gfk1PzCARZrnq/giphy.gif',
  'https://media.giphy.com/media/7v735rSZA1Szm/giphy.gif',
  'https://media.giphy.com/media/l0HlND8Rt0e0nIcCc/giphy.gif',
  'https://media.giphy.com/media/DfSXiR60W9MVq/giphy.gif',
  'https://media.giphy.com/media/a5viI92PAF89q/giphy.gif',
  'https://media.giphy.com/media/kPtv3UIPrv36cjxqLs/giphy.gif',
  'https://media.giphy.com/media/3o7TKTDn976rzVgky4/giphy.gif',
  'https://media.giphy.com/media/TPl5N4Ci49ZQY/giphy.gif',
  'https://media.giphy.com/media/XbPFv2ihC3rRm/giphy.gif',
  'https://media.giphy.com/media/BBkKEBJkmFbTG/giphy.gif',
  'https://media.giphy.com/media/26xBI73gWquCBBCDe/giphy.gif',
  'https://media.giphy.com/media/6utVzLiyU9OuHbd70D/giphy.gif',
  'https://media.giphy.com/media/FFb9yZK6t0oDu/giphy.gif'
]

let fractalImages = [
  'https://media.giphy.com/media/3o85xJx0QnnVYnGKRi/giphy.gif',
  'https://media.giphy.com/media/cFRhobC9AWc24/giphy.gif',
  'https://media.giphy.com/media/3og0IDoDo2TeidxKbm/giphy.gif',
  'https://media.giphy.com/media/d3mlXPjoK1ROfr9u/giphy.gif',
  'https://media.giphy.com/media/3o6UBbF9JIiXyDdcKA/giphy.gif',
  'https://media.giphy.com/media/xT9IgO6eylAYeIZFhC/giphy.gif',
  'https://media.giphy.com/media/5b9u8sfNYp4eXWwLYf/giphy.gif',
  'https://media.giphy.com/media/ixZb4d3OL8SyY/giphy.gif',
  'https://media.giphy.com/media/3og0IROkdNyWyCG2I0/giphy.gif'
]

let laughImages = [
  'https://media.giphy.com/media/GpyS1lJXJYupG/giphy.gif',
  'https://media.giphy.com/media/10JhviFuU2gWD6/giphy.gif',
  'https://media.giphy.com/media/OhrNfRrBxgz16/giphy.gif',
  'https://media.giphy.com/media/JmsG1PY1K94hyOa1v9/giphy.gif',
  'https://media.giphy.com/media/Yq1pe2v7nNlwA/giphy.gif',
  'https://media.giphy.com/media/ff0dv4KMGxjna/giphy.gif',
  'https://media.giphy.com/media/dPghHslnqEKLC/giphy.gif',
  'https://media.giphy.com/media/O5NyCibf93upy/giphy.gif',
  'https://media.giphy.com/media/ufiB4rMy9GUUg/giphy.gif',
  'https://media.giphy.com/media/dC9DTdqPmRnlS/giphy.gif',
  'https://media.giphy.com/media/fGuqeA6PiXINa/giphy.gif',
  'https://media.giphy.com/media/uLAoIx3H2qLW8/giphy.gif',
  'https://media.giphy.com/media/xUA7aM09ByyR1w5YWc/giphy.gif',
  'https://media.giphy.com/media/9MFsKQ8A6HCN2/giphy.gif',
  'https://media.giphy.com/media/Vg0JstydL8HCg/giphy.gif',
  'https://media.giphy.com/media/r1wGrCEZ4zTeU/giphy.gif',
  'https://media.giphy.com/media/Ic97mPViHEG5O/giphy.gif',
  'https://media.giphy.com/media/pGU7k489QGCQ0/giphy.gif',
  'https://media.giphy.com/media/g8A1eJhTQ7Iic/giphy.gif',
  'https://media.giphy.com/media/57DX612XYgQKI/giphy.gif',
  'https://media.giphy.com/media/Y5GVgQZCluUWQ/giphy.gif'
]

let winnerImages = [
  'https://media.giphy.com/media/uTuLngvL9p0Xe/giphy.gif',
  'https://media.giphy.com/media/cOB8cDnKM6eyY/giphy.gif',
  'https://media.giphy.com/media/mIZ9rPeMKefm0/giphy.gif',
  'https://media.giphy.com/media/xThuWfWhRaxfngUViw/giphy.gif',
  'https://media.giphy.com/media/msKNSs8rmJ5m/giphy.gif',
  'https://media.giphy.com/media/cQNRp4QA8z7B6/giphy.gif',
  'https://media.giphy.com/media/khXP5p8cMt7IA/giphy.gif',
  'https://media.giphy.com/media/55dx3AeoTduNy/giphy.gif',
  'https://media.giphy.com/media/1dMNqVx9Kb12EBjFrc/giphy.gif',
  'https://media.giphy.com/media/xT0GqssRweIhlz209i/giphy.gif',
  'https://media.giphy.com/media/3ohhwo4PzDFaz2sADu/giphy.gif',
  'https://media.giphy.com/media/l0MYMPis1gRhiYNk4/giphy.gif',
  'https://media.giphy.com/media/3o85xGO2kvQMYyiChW/giphy.gif',
  'https://media.giphy.com/media/BMt31oekjIG4V8jFhE/giphy.gif'
]

let loserImages = [
  'https://media.giphy.com/media/a9xhxAxaqOfQs/giphy.gif',
  'https://media.giphy.com/media/YLgIOmtIMUACY/giphy.gif',
  'https://media.giphy.com/media/2WxWfiavndgcM/giphy.gif',
  'https://media.giphy.com/media/hmE2rlinFM7fi/giphy.gif',
  'https://media.giphy.com/media/3OhXBaoR1tVPW/giphy.gif',
  'https://media.giphy.com/media/3o7WIvaSKdMaboHF4s/giphy.gif',
  'https://media.giphy.com/media/mBaNKEmk9SUKs/giphy.gif',
  'https://media.giphy.com/media/cYNjNSHeLQ3RZru1ee/giphy.gif',
  'https://media.giphy.com/media/piTERt2CEdrLt2WLv0/giphy.gif',
  'https://media.giphy.com/media/EndO2bvE3adMc/giphy.gif',
  'https://media.giphy.com/media/1jARfPtdz7eE0/giphy.gif',
  'https://media.giphy.com/media/GW10shdM3oXok/giphy.gif',
  'https://media.giphy.com/media/l2JhxnwyDuF9pWE24/giphy.gif'
]

export function getRandomThinkingImage() {
  return shuffle(thinkingImages).pop()
}

export function getRandomFractalImage() {
  return shuffle(fractalImages).pop()
}

export function getRandomLaughImage() {
  return shuffle(laughImages).pop()
}

export function getRandomWinnerImage() {
  return shuffle(winnerImages).pop()
}

export function getRandomLoserImage() {
  return shuffle(loserImages).pop()
}
