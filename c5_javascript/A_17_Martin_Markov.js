function RectCircleColliding(circle, rect) {
  var distX = Math.abs(circle.x - rect.x - rect.w / 2);
  var distY = Math.abs(circle.y - rect.y - rect.h / 2);

  if (distX > (rect.w / 2 + circle.r)) { return false; }
  if (distY > (rect.h / 2 + circle.r)) { return false; }

  if (distX <= (rect.w / 2)) { return true; }
  if (distY <= (rect.h / 2)) { return true; }

  var dx = distX - rect.w / 2;
  var dy = distY - rect.h / 2;

  return (dx * dx + dy * dy <= (circle.r * circle.r));
}

function myBallDraw() {
  var canvas = document.getElementById('tutorial');
  if (canvas.getContext) {
    var ctx = canvas.getContext('2d');
  }

  var raf;
  var lives = 3;
  var count = 0;

  function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ball.draw();
    ball.x += ball.vx;
    ball.y += ball.vy;

    if (ball.y + ball.r + ball.vy > canvas.height
      || ball.y - ball.r + ball.vy < 0) {
      ball.vy = -ball.vy;
    }

    if (ball.x + ball.r + ball.vx > canvas.width
      || ball.x - ball.r + ball.vx < 0) {
      ball.vx = -ball.vx;
    }

    rectangle.draw();    

    if (RectCircleColliding(ball, rectangle)) {
      document.getElementById("lives").textContent = "Lives: " + --lives;      
      ball.vx *= -1;
      ball.vy *= -1;
    } 

    if (lives < 1) {
      location.reload();
      alert("You died");
    }

    raf = window.requestAnimationFrame(draw);
  }

  var rectangle = {
    w: 100,
    h: 100,
    x: 300,
    y: 50,
    color: 'green',
    draw: function () {
      ctx.rect(rectangle.x, rectangle.y, rectangle.w, rectangle.h);
      ctx.fillStyle = this.color;      
      ctx.fill();
    }
  }

  var ball = {
    x: 100,
    y: 100,
    vx: 3,
    vy: 3,
    r: 100,
    color: 'red',
    draw: function () {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2, true);
      ctx.closePath();
      ctx.fillStyle = this.color;
      ctx.fill();
    }
  };

  canvas.addEventListener('click', function (e) {
    if ((e.x - 10 < ball.x + ball.r && e.x - 10 > ball.x - ball.r)
      && (e.y - 10 < ball.y + ball.r && e.y - 10 > ball.y - ball.r)
    ) {
      ball.r *= .8;
      ball.vx *= -1.3;
      ball.vy *= -1;
      document.getElementById("score").textContent = "Score: " + ++count;
    } else {
      document.getElementById("lives").textContent = "Lives: " + --lives;
    }
  });

  draw();
}
myBallDraw();
