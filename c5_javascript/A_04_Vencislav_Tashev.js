let canvas = document.getElementById('game')
let ctx = canvas.getContext('2d')

let raf

let points = 0
let pointsOnCorrectClick = 100
let pointsOnWrongClick = pointsOnCorrectClick / 2
let pointsDividingInterval = 20000

let colors = [
  'aqua',
  'chartreuse',
  'crimson',
  'darkorange',
  'rebeccapurple'
]

function generateRandomColorIndex () {
  return Math.floor(Math.random() * colors.length)
}

let randomIndex = generateRandomColorIndex()
let randomColor = colors[randomIndex]

document.getElementById('color').style.backgroundColor = randomColor

let ball = {
  x: 100,
  y: 100,
  vx: 5,
  vy: 2,
  radius: 75,
  positionChangeInterval: 5000,
  colorChangeInterval: 2000,
  initColor: randomColor,
  color: randomColor,
  draw: function () {
    ctx.beginPath()
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true)
    ctx.closePath()
    ctx.fillStyle = this.color
    ctx.fill()
  },
  placeAtRandomPosition: function (canvas) {
    let random = Math.random()

    this.x = random * canvas.width
    this.y = random * canvas.height
  },
  changeDirection: function () {
    let random = Math.random()

    if (random < 0.5) {
      this.vx *= -1
    } else {
      this.vy *= -1
    }
  },
  isMouseOver: function (mousePos) {
    let isXOver = (mousePos.x > this.x - this.radius && mousePos.x < this.x + this.radius)
    let isYOver = (mousePos.y > this.y - this.radius && mousePos.y < this.y + this.radius)

    return isXOver && isYOver
  },
  hasHitLeftWall: function (canvas) {

  },
  selectRandomColor: function () {
    let randomIndex = generateRandomColorIndex()

    this.color = colors[randomIndex]
  },
  isCorrectColor: function () {
    return this.initColor === this.color
  }
}

function getMousePos (canvas, event) {
  let rect = canvas.getBoundingClientRect()

  return {
    x: event.clientX - rect.left,
    y: event.clientY - rect.top
  }
}

function draw () {
  ctx.fillStyle = 'rgba(255, 255, 255, 0.3)'
  ctx.fillRect(0, 0, canvas.width, canvas.height)
  ball.draw()

  ball.x += ball.vx
  ball.y += ball.vy

  if (ball.y + ball.vy > canvas.height ||
    ball.y + ball.vy < 0) {
    ball.vy = -ball.vy
    ball.selectRandomColor()
  }
  if (ball.x + ball.vx > canvas.width ||
      ball.x + ball.vx < 0) {
    ball.vx = -ball.vx
    ball.selectRandomColor()
  }

  raf = window.requestAnimationFrame(draw)
}

canvas.addEventListener('mouseover', function (e) {
  setInterval(function () {
    points -= points / 1.8
    points = Math.floor(points)

    document.getElementById('points').innerHTML = points
  }, pointsDividingInterval)
  pointsDividingInterval -= 50

  setInterval(function () {
    ball.placeAtRandomPosition(canvas)
    ball.changeDirection()
    ball.radius *= 0.95
  }, ball.positionChangeInterval)
  ball.positionChangeInterval -= 10

  raf = window.requestAnimationFrame(draw)
})

canvas.addEventListener('mouseout', function (e) {
  window.cancelAnimationFrame(raf)
})

canvas.addEventListener('click', function (e) {
  let mousePos = getMousePos(canvas, e)

  if (ball.isMouseOver(mousePos)) {
    if (ball.isCorrectColor()) {
      points += pointsOnCorrectClick
      ball.radius += 1
    } else {
      points -= pointsOnWrongClick
      ball.radius *= 0.8
    }

    if (points < 0) {
      window.alert('You lost.')
      window.location.reload()
    }

    document.getElementById('points').innerHTML = points
  }
})

ball.draw()
