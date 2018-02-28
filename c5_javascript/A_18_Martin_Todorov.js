function randomColors() {
  return '#' + Math.floor(Math.random() * 16777215).toString(16);
}

function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
}

function myBallDraw() {
    window.name;

    function resetButton() {
        var btn = document.createElement("BUTTON");
        var t = document.createTextNode("RESET BALL");
        btn.appendChild(t);
        document.body.appendChild(btn);

        var btn2 = document.createElement("BUTTON");
        var t2 = document.createTextNode("RESET SCORE");
        btn2.appendChild(t2);
        document.body.appendChild(btn2);

        btn.addEventListener('click', function(e) {
            location.reload();
            running = false;
            clear();
            ball.x = e.clientX;
            ball.y = e.clientY;
            ball.draw();
        });

        btn2.addEventListener('click', function(e) {
            window.name = "0";
        })
    }
    resetButton();

    var canvas = document.getElementById('tutorial');

    if(canvas.getContext) {
        var ctx = canvas.getContext('2d');
    }
    
    function drawGoal() {
      var goal = document.createElement("canvas");
      goal.id = "goal";
      var canvasGoal = document.getElementById('goal');
      ctxGoal = canvas.getContext('2d');
      goal.width = 120;
      goal.height = 20;
      document.body.appendChild(goal);

      var goalFill = document.createElement("canvas");
      goalFill.id = "goalFill";
      var canvasGoalFill = document.getElementById('goalFill');
      ctxGoalFill = canvas.getContext('2d');
      goalFill.width = goal.width - 20;
      goalFill.height = goal.height - 5;
      document.body.appendChild(goalFill);
    }
    drawGoal();

    var raf;
    var running = false;


    function drawWave() {
        ctx.rect(0, 0, canvas.width, 300);
        ctx.fillStyle = 'rgba(255, 255, 255, 1)';
        ctx.fillRect(0, 0, 150, 100);
        ctx.stroke();
    }
    drawWave();

    var ball = {
      x: 100,
      y: 100,
      vx: 0,
      vy: 5,
      radius: 25,
      color: '#424242',
      draw: function() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.fillStyle = this.color;
        ctx.fill();
      }
    };

    var goalPosition = getRandomArbitrary(goal.width, canvas.width - goal.width);
    var goalColor = randomColors();
    

    function clear() {
      ctx.fillStyle = 'rgba(115, 196, 255, 1)';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      ctx.fillStyle = 'rgba(255, 255, 255, 1)';
      ctx.fillRect(0, 0, canvas.width, 300);
      ctxGoal.fillStyle = goalColor;
      ctxGoal.fillRect(goalPosition, canvas.height - 20, goal.width, goal.height);
      ctxGoalFill.fillStyle = 'rgba(115, 196, 255, 1)';
      ctxGoalFill.fillRect((goalPosition + 10), canvas.height - 20, goalFill.width, goalFill.height);
      ctx.font = '40px arial';
      ctx.fillStyle = "Black";
      ctx.fillText("Score: ", 10, 70);
      ctx.fillText(window.name, 130, 70);
      // ctx.beginPath();
      // ctx.arc(0, (canvas.height / 2), 100, 2, 2 * Math.PI);
      // ctx.fillStyle = 'rgba(115, 196, 255, 1)';
      // ctx.fill();
    }

    function draw() {
      clear();
      ball.draw();
      ball.x += ball.vx; // movement
      ball.y += ball.vy;

      if((ball.y + ball.radius) > canvas.height / 2) { // if its inside the water it slows down
        ball.vy -= .22;
        if((ball.y + ball.radius) > canvas.height / 1.2) { // had to do something to keep the ball from flying up
          ball.vy += .22;
          if(ball.y + ball.radius + ball.vy > canvas.height || ball.y - ball.radius + ball.vy < 0) { // if the ball has reached the goal
            if(ball.x > goalPosition && ball.x < goalPosition + goal.width) {
              window.name++;
            }
            window.cancelAnimationFrame(raf);
          }
        }
      } else {
          ball.vy *= .99; // gravity
          ball.vy += .25;
      }

      if(ball.y + ball.radius + ball.vy > canvas.height || ball.y - ball.radius + ball.vy < 0) {
        ball.vy = 0;
        ball.vx = 0;
      }
      if(ball.x + ball.radius + ball.vx > canvas.width || ball.x - ball.radius + ball.vx < 0) {
        ball.vx = -ball.vx;
      }
      raf = window.requestAnimationFrame(draw);
      
    }

    canvas.addEventListener('mousemove', function(e) {
      if(!running) {
        clear();
        ball.x = e.clientX;
        ball.y = e.clientY;
        ball.draw();
      }
    });

    canvas.addEventListener('click', function(e) {
      if(!running) {
        raf = window.requestAnimationFrame(draw);
        running = true;
      }
    });

    ball.draw();
}
myBallDraw();
