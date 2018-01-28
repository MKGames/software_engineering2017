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
            // console.log("CLICKED");
            location.reload();
            // window.cancelAnimationFrame(raf);
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
      goal.width = 100;
      goal.height = 20;
      goal.style.zIndex = 8;
      goal.style.position = "absolute";
      goal.style.border = "1px solid";
      ctxGoal.beginPath();
      ctxGoal.rect(300, canvas.height + 20, goal.width, goal.height);
      ctxGoal.fillStyle = "red";
      ctxGoal.fill();
      document.body.appendChild(goal);
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

    function clear() {
      ctx.fillStyle = 'rgba(115, 196, 255, 1)';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      ctx.fillStyle = 'rgba(255, 255, 255, 1)';
      ctx.fillRect(0, 0, canvas.width, 300);
      // drawWave();
    }

    function draw() {
      clear();
      ball.draw();
      ball.x += ball.vx; // movement
      ball.y += ball.vy;
      if((ball.y + ball.radius) > canvas.height / 2) {
        ball.vy -= .22;
        if((ball.y + ball.radius) > canvas.height / 1.2) {
          ball.vy += .22;
          if(ball.y + ball.radius + ball.vy > canvas.height || ball.y - ball.radius + ball.vy < 0) {
            console.log("Touched");
            // ball.vy = 0;
            // ball.vx = 0;
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
      window.name++;
      console.log(window.name);
      if(!running) {
        raf = window.requestAnimationFrame(draw);
        running = true;
      }
    });

    // canvas.addEventListener('mouseout', function(e) {
    //   window.cancelAnimationFrame(raf);
    //   running = false;
    // });

    ball.draw();
}
myBallDraw();
