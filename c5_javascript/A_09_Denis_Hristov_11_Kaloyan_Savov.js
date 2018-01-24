var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');
var raf;
var running = false;

var ball = {
  x: Math.random() * canvas.width,
  y: Math.random() * canvas.height,
  vx: 4,
  vy: 20,
  radius: 350,
  color: getRandomColor(),

  draw: function() {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
    ctx.closePath();
    ctx.fillStyle = this.color;
    ctx.fill();
  }
};

var balls = [];

function clear() {
  ctx.fillStyle = 'rgba(255, 255, 255, 0.3)';
  ctx.fillRect(0,0,canvas.width,canvas.height);
}

function getRandomColor() {
    var r = 255*Math.random()|0,
        g = 255*Math.random()|0,
        b = 255*Math.random()|0;
    return 'rgb(' + r + ',' + g + ',' + b + ')';
}

function draw() {
  clear();
  ball.draw();
  ball.x += ball.vx;
  ball.y += ball.vy;

  if (ball.y + ball.vy > canvas.height || ball.y + ball.vy < 0) {
    ball.vy = -ball.vy;
  }

  if (ball.x + ball.vx > canvas.width || ball.x + ball.vx < 0) {
    ball.vx = -ball.vx;
  }

  raf = window.requestAnimationFrame(draw);
}

canvas.addEventListener('click', function(e) {
  if (!running) {
    raf = window.requestAnimationFrame(draw);
    running = true;
  }
});

function isIntersect(point, ball) {
  return Math.sqrt((point.x - ball.x) ** 2 + (point.y - ball.y) ** 2) < ball.radius;
}

canvas.addEventListener('click', (e) => {
  const pos = {
    x: e.clientX,
    y: e.clientY
  };

  if (isIntersect(pos, ball)) {
    clear();
    ball.color = getRandomColor();
    ball.radius -= 30;
    ball.x *= 0.3;
    ball.y *= 0.3;

    if (ball.radius <= 0) {
      ctx.font = "30px Arial";
      ctx.fillStyle = "red";
      ctx.textAlign = "center";
      ctx.fillText("you did it!!",canvas.width / 2, canvas.height / 2);
    }
  }
});

ball.draw();