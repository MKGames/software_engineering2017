var canvas = document.createElement('canvas');
document.body.appendChild(canvas);
canvas.id = 'canvas';
canvas.width = 800;
canvas.height = 600;
var ctx = canvas.getContext('2d');
var raf;
var lives = 5;
var score = 0;
var dificulty_step = 20;
var previous_step = 0;
var reward = 5;
var timer = new Date();
var start = timer.getTime();
var counter;


var Balls = [];
Balls.push(new Ball('gold'));
for(var i = 0; i < 6; ++i){
  Balls.push(new Ball('blue'));
}

for(var i = 0; i < Balls.length; ++i){
  var collides = true;
  while(collides){
    Balls[i].x = Math.floor((Math.random() * (800 - (Balls[0].radius * 2))) + Balls[0].radius);
    Balls[i].y = Math.floor((Math.random() * (600 - (Balls[0].radius * 2))) + Balls[0].radius);
    collides = false;
    for(var j = 0; j < Balls.length; ++j){
      if(i != j){
        if(CircleCollision(Balls[i], Balls[j])){
          collides = true;
        }
      }
    }
  }
}

function randomSpeed(){
  return Math.floor((Math.random() * 3) + 3);
}
function Ball(color){
  this.x = Math.floor((Math.random() * 780) + 10);
  this.y = Math.floor((Math.random() * 580) + 10);
  this.vx = randomSpeed();
  this.vy = randomSpeed();
  this.radius = 35;
  this.color = color;
  this.bounced = false;

  if(Math.random() < 0.5){
    this.vx = -this.vx;
  }
  if(Math.random() < 0.5){
    this.vy = -this.vy;
  }


  this.draw = function(){
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
    ctx.closePath();
    ctx.fillStyle = this.color;
    ctx.fill();
  };
}

function CircleCollision(ball1, ball2){
  var dx = ball1.x - ball2.x;
  var dy = ball1.y - ball2.y;
  var distance = Math.sqrt(dx * dx + dy * dy);

  return distance < ball1.radius + ball2.radius;
}

function draw() {
  ctx.clearRect(0,0, canvas.width, canvas.height);
  for(var i = 0; i < Balls.length; ++i){
    Balls[i].draw();

    //counter = timer.getTime() - start;
    //console.log(timer.getTime());

    Balls[i].x += Balls[i].vx;
    Balls[i].y += Balls[i].vy;

    if(Balls[i].y + Balls[i].radius + Balls[i].vy > canvas.height){
      Balls[i].vy = -randomSpeed();
    }
    if(Balls[i].y - Balls[i].radius + Balls[i].vy < 0) {
      Balls[i].vy = randomSpeed();
    }

    if (Balls[i].x + Balls[i].radius + Balls[i].vx > canvas.width){
      Balls[i].vx = -randomSpeed();
    }
    if(Balls[i].x - Balls[i].radius + Balls[i].vx < 0) {
      Balls[i].vx = randomSpeed();
    }

    for(var j = i + 1; j < Balls.length; ++j){
      if(Balls[j].bounced == false && Balls[i].bounced == false && CircleCollision(Balls[i], Balls[j])){
        Balls[i].vx = -Balls[i].vx;
        Balls[i].vy = -Balls[i].vy;
        Balls[j].vx = -Balls[j].vx;
        Balls[j].vy = -Balls[j].vy;

        Balls[i].x += Balls[i].vx;
        Balls[i].y += Balls[i].vy;
        Balls[j].x += Balls[j].vx;
        Balls[j].y += Balls[j].vy;

        Balls[i].bounced = true;
        Balls[j].bounced = true;

        var temp = Balls[i].color;
        Balls[i].color = Balls[j].color;
        Balls[j].color = temp;
      }
    }

    for(var j = 0; j < Balls.length; j++){
      Balls[j].bounced = false;
    }

  }

  raf = window.requestAnimationFrame(draw);
}

canvas.addEventListener('click', function(e) {
  var i;
  for(i = 0; i < Balls.length; i++){
    if(Balls[i].color == 'gold') break;
  }

  if((e.x - 10 < Balls[i].x + Balls[i].radius && e.x - 10 > Balls[i].x - Balls[i].radius)
  && (e.y - 10 < Balls[i].y + Balls[i].radius && e.y - 10 > Balls[i].y - Balls[i].radius)) {
    score += reward;
    if(score >= previous_step + dificulty_step){
      previous_step += dificulty_step;
      reward += 2.5 * (score / 20);

      if(((previous_step / 20) + 1) % 2 == 0){
        Balls.push(new Ball('red'));

        collides = true;
        while(collides){
          Balls[Balls.length - 1].x = Math.floor((Math.random() * (800 - (Balls[0].radius * 2))) + Balls[0].radius);
          Balls[Balls.length - 1].y = Math.floor((Math.random() * (600 - (Balls[0].radius * 2))) + Balls[0].radius);
          collides = false;
          for(var j = 0; j < Balls.length - 1; ++j){ //skips last ball
            if(CircleCollision(Balls[Balls.length - 1], Balls[j])){
              collides = true;
            }
          }
        }

        for(var i = 0; i < Balls.length; ++i){
          Balls[i].vx *= 1.15;
          Balls[i].vy *= 1.15;
        }
      }
    }
    console.log(score);
  } else {
    lives--;
    console.log(lives);
  }

  if(lives < 1){
    window.alert("Uded... score: " + score);
    location.reload();
  }
});

canvas.addEventListener('mouseover', function(e) {
  raf = window.requestAnimationFrame(draw);
});

canvas.addEventListener('mouseout', function(e) {
  window.cancelAnimationFrame(raf);
});

Ball.draw;
