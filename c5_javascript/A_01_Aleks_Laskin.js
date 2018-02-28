function myBallDraw(){
  function init(ctx){
    window.setInterval(ball.draw(), 1000);
  }
  function random(min,max){
    return Math.random() *(max-min) + min
  }

  var canvas = document.getElementById('canvas');
  var canvasParent = canvas.parentNode;
  var ctx = canvas.getContext('2d');
  var raf;

  var header = document.createElement('h1');
  header.innerHTML = 'Score 5 points to proceed to next level';
  header.style.color = "red";
  canvasParent.insertBefore(header, canvas);

  var headers = [
    {
      name: 'Lives',
      color: 'green',
      initValue: 10
    },

    {
      name: 'Points',
      color: 'green',
      initValue: 0
    },

    {
      name: 'Wins',
      color: 'green',
      initValue: 0
    },
    {
      name: 'Loses',
      color: 'red',
      initValue: 0
    }
  ]

  for (var header of headers) {
    var element = document.createElement('h2')
    element.innerHTML = header.name + `: <span id=${header.name}>${header.initValue}</span>`
    element.style.color = header.color

    document.body.appendChild(element)
  }



  var ball = {
    x: 100,
    y: 100,
    vx: 5,
    vy: 2,
    radius: 50,
    color: 'blue',
    is_mouse_over: function(x,y){
      return (this.x - this.radius) < x < (this.x + this.radius)
      && (this.y -this.radius) < y < (this.y+this.radius);
    },
    draw: function() {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
      ctx.closePath();
      ctx.fillStyle = this.color;
      ctx.fill();
    }
  };

  function draw() {
    ctx.clearRect(0,0, canvas.width, canvas.height);
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
    draw();
    function getMousePos(canvas,evt){
      var rect = canvas.getBoundingClientRect();
      return{
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
      };
    }
    var lives = 10;
    var success = 0;
    var wins = 0;
    var loses = 0;

    canvas.addEventListener('click', function(e){
    var mousePos = getMousePos(canvas, e);
    if((ball.x - ball.radius < mousePos.x && mousePos.x < ball.x + ball.radius) && (ball.y - ball.radius < mousePos.y && mousePos.y < ball.y + ball.radius)){
    if(ball.color == 'red'){
        ball.color = 'blue';
    }else{
        ball.color = 'red';
    }
      ball.radius *= 7/9;
            success++;
        if(success == 5){
            wins++;
            lives += 10;
            ball.radius = 50;
            ball.vx *= 1.2;
            ball.vy *= 1.2;
            success = 0;
        }

    }else{
    if(lives == 0){
        loses++;
        success = 0;
        lives = 11;
        ball.radius = 50;
    }
      lives--;

    }
    document.getElementById("Points").innerHTML = success;
    document.getElementById("Wins").innerHTML = wins;
    document.getElementById("Loses").innerHTML = loses;
    document.getElementById("Lives").innerHTML = lives;

  });

  ball.draw();
}


