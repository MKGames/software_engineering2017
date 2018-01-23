var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');
ctx.canvas.width  = window.innerWidth - 50;
ctx.canvas.height = window.innerHeight - 50;
var raf;
document.body.style.backgroundColor = "white";
var gun = new Image();
var projectile = new Image();
DrawAssets = function(){
  gun.src = 'https://t1.rbxcdn.com/23678b437e11f8c47fc3b88681c13bc4';  
  projectile.src = 'https://i.imgur.com/7voTA58.gif';
}


var Ball = {
  radius: 35,
  x:  Math.floor((Math.random() * 300) + 35),
  y:  Math.floor((Math.random() * 300) + 35),
  vx: 5,
  vy: 5,
  color: 'blue',
  draw: function() {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
    ctx.closePath();
    ctx.fillStyle = this.color;
    ctx.fill();
  },
};

var Weapon = {
  x: 200,
  y: 480,
  width: 150,
  height: 150,
  xv: 0,
  yv: 0,
	rightPressed: false,
	leftPressed: false,
  draw: function() {
   ctx.drawImage(gun, this.x, this.y, this.width, this.height); 
  }
};

var Bullet = {
	x: Weapon.x + 41,
	y: Weapon.y + 10,
	width: 70,
	height: 70,
	xv: 0 ,
	yv: -5,
	keyPressed: false,
	draw: function() {
   ctx.drawImage(projectile, this.x, this.y, this.width, this.height);     
  }
};

function getDistance(x1, y1, x2, y2){
  var x_distance = x2 - x1;
  var y_distance = y2 - y1;

  return Math.sqrt(Math.pow(x_distance, 2) + Math.pow(y_distance, 2));
}

function draw() {
  ctx.clearRect(0,0, canvas.width, canvas.height);
  Ball.draw();
  Weapon.draw();
  Ball.x += Ball.vx;
  Ball.y += Ball.vy;
  raf = window.requestAnimationFrame(draw);

  if (Ball.y + Ball.vy + Ball.radius> canvas.height || Ball.y + Ball.vy -Ball.radius < 0) {
    Ball.vy = -Ball.vy;
  }
  if (Ball.x + Ball.vx + Ball.radius> canvas.width || Ball.x + Ball.vx - Ball.radius < 0) {
    Ball.vx = -Ball.vx;
  }

  if (getDistance(Ball.x, Ball.y, Bullet.x, Bullet.y) < Ball.radius + Bullet.width/2){
    if(getDistance(Ball.x, Ball.y, Weapon.x, Weapon.y) > Ball.radius + Weapon.width/2){
      Bullet.keyPressed = false;
      Bullet.y = Weapon.y + 10;
      Bullet.x = Weapon.x + 41;
      Ball.color = 'red';
    }else{
      alert("YOU GOT HIT!");
      document.location.reload();
      
    }
  }

	if(Weapon.rightPressed && Weapon.x < canvas.width - Weapon.width) {
    Weapon.x += 7;
    if(Bullet.y == Weapon.y + 10){
      Bullet.x +=7;
    }
  }
  else if(Weapon.leftPressed && Weapon.x > 0) {
    Weapon.x -= 7;
    if(Bullet.y == Weapon.y + 10){
      Bullet.x -= 7;      
    }
  }
  if(Bullet.keyPressed) {
      console.log("asd");
  	  Bullet.draw();
      Bullet.y += Bullet.yv;
      if(Bullet.y < -20)Bullet.keyPressed = false;
  }
}

canvas.addEventListener('mouseover', function(e) {
  raf = window.requestAnimationFrame(draw);
});

canvas.addEventListener('mouseout', function(e) {
  window.cancelAnimationFrame(raf);
});

document.addEventListener("keydown", keyDownHandler, false);
document.addEventListener("keyup", keyUpHandler, false);


function keyDownHandler(e) {
    if(e.keyCode == 39) {
        Weapon.rightPressed = true;
    }
    else if(e.keyCode == 37) {
        Weapon.leftPressed = true;
    }
    else if(e.keyCode == 32) {
        Bullet.keyPressed = true;
        if(Bullet.y < 0){
          Bullet.y = Weapon.y + 10;
          Bullet.x = Weapon.x + 41;
        }
    }
}

function keyUpHandler(e) {
    if(e.keyCode == 39) {
        Weapon.rightPressed = false;
    }
    else if(e.keyCode == 37) {
        Weapon.leftPressed = false;
    }
}

Ball.draw();
