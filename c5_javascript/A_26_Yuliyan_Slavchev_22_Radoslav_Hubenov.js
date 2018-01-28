var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');
var raf;
document.body.style.backgroundColor = "white";

function Circle (radius, x, y, vx, vy, color) {
	this.radius = radius;
	this.x = x;
	this.y = y;
	this.vx = vx;
	this.vy = vy;
	this.color = color;
	this.draw = function() {
		ctx.beginPath();
    	ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
    	ctx.fillStyle = this.color;
    	ctx.fill();
   	 	ctx.closePath();
	}
}
let score = 0;
function drawScore() {
    ctx.font = "16px Arial";
    ctx.fillStyle = "black";
    ctx.fillText("Score: "+ score, 8, 20);
}

let Ball;
let Weapon;
let Bullet;

Ball = new Circle(35, Math.floor((Math.random() * 300) + 35), Math.floor((Math.random() * 300) + 35), 6 , 4, 'blue');
Weapon = new Circle(20, canvas.width / 2 - 20, canvas.height - 20, 0, 0, 'brown');
Bullet = new Circle(10, Weapon.x, Weapon.y, 0, -5, 'red');	

let rightPressed = false;
let leftPressed = false;
let keyPressed = false;

function getDistance(x1, y1, x2, y2) {
  var x_distance = x2 - x1;
  var y_distance = y2 - y1;
  return Math.sqrt(Math.pow(x_distance, 2) + Math.pow(y_distance, 2));
}
let BallHasChild = true;
function draw() {
  ctx.clearRect(0,0, canvas.width, canvas.height);
  drawScore();
  Ball.draw();
  Weapon.draw();
  Ball.x += Ball.vx;
  Ball.y += Ball.vy;
  raf = window.requestAnimationFrame(draw);
  if (Ball.y + Ball.vy + Ball.radius > canvas.height || Ball.y + Ball.vy -Ball.radius < 0) {
    Ball.vy = -Ball.vy;
  }
  if (Ball.x + Ball.vx + Ball.radius > canvas.width || Ball.x + Ball.vx - Ball.radius < 0) {
    Ball.vx = -Ball.vx;
  }

  if(getDistance(Ball.x, Ball.y, Bullet.x, Bullet.y) < Ball.radius){
      keyPressed = false;
      Bullet.y = Weapon.y;
      Bullet.x = Weapon.x;
      Ball.color = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
			score += 10;
   }
  if(getDistance(Ball.x, Ball.y, Weapon.x, Weapon.y) < Ball.radius + Weapon.radius - Bullet.radius) {
    	alert("YOU DIED!\n SCORE : " + score);
    	document.location.reload();
   }
	if(rightPressed && Weapon.x < canvas.width - Weapon.radius) {
    Weapon.x += 7;
    if(Bullet.y == Weapon.y){
      Bullet.x += 7;
    }
  }
  else if(leftPressed && Weapon.x > 0 + Weapon.radius) {
    Weapon.x -= 7;
    if(Bullet.y == Weapon.y){
      Bullet.x -= 7;      
    }
  }
  if(keyPressed) {
  	Bullet.draw();
    Bullet.y += Bullet.vy;
    if(Bullet.y < 0) {
      keyPressed = false;
  	}
  }
}

raf = window.requestAnimationFrame(draw);

document.addEventListener("keydown", keyDownHandler, false);
document.addEventListener("keyup", keyUpHandler, false);

function keyDownHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }
    else if(e.keyCode == 32) {
        keyPressed = true;
        if(Bullet.y < 0){
          Bullet.y = Weapon.y;
          Bullet.x = Weapon.x;
        }
    }
}
function keyUpHandler(e) {
    if(e.keyCode == 39) {
       rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
}
