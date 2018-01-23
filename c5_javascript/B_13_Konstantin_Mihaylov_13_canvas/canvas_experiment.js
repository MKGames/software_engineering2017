window.onload = function(){

var ctx;
var gravity = 4;
var forceFactor = 0.3;
var mouseDown = false;
var balls = new Array();
var mousePosition = new Array();

  function onMouseDown(events){
	 mouseDown = true;
	 mousePosition['downX'] = events.pageX;
	 mousePosition['downY'] = events.pageY;
	}

	function onMouseUp(events){
		mouseDown = false;
		balls.push(new ball(mousePosition["downX"], mousePosition["downY"],
		 (events.pageX - mousePosition["downX"]) * forceFactor ,
	   (events.pageY - mousePosition["downY"]) * forceFactor,
		 5 + (Math.random()*10), 0.9, random_color()));

		//CREATE THE BALL
	}

	function onMouseMove(events){
		mousePosition['currentX'] = events.posX;
		mousePosition['currentY'] = events.posY;
	}

	$(document).mousedown(onMouseDown);
	$(document).mouseup(onMouseUp);
	$(document).mousemove(onMouseMove);
	$(window).bin

	function circle(x, y, r, c){
			//drawing a circle
			ctx.beginPath();
			ctx.arc(x, y, r, 0, Math.PI*2, true);
			ctx.closePath();
			//fillText
			ctx.fillStyle = c;
			ctx.fill();
			//stroke
			ctx.lineWidth = r * 0.1;
			ctx.strokeStyle = "#000000";
			ctx.stroke();
	}
	function random_color(){
			var letter = "0123456789ABCDEF".split("");
			var color = "#";
			for (var i = 0; i < 6; i++) {
					color+= letter[Math.round(Math.random()*15)];
			}
			return color;
	}

	function draw_ball(){
		this.vy += gravity * 0.1;
		this.x += this.vx * 0.1;
		this.y += this.vy * 0.1;
		circle(this.x, this.y, this.r, this.c);
	}

	function ball(positionX, positionY, velosityX, velosityY, radius, bounciness, color){
		this.x = positionX;
		this.y = positionY;
		this.vx = velosityX;
		this.vy = velosityY;
		this.r = radius;
		this.b = bounciness;
		this.c = color;

		this.draw = draw_ball;
	}
	function game_loop(){
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	if(mouseDown == true){
			//DRAW THE ARROW
	}
	for (var i = 0; i < balls.length; i++) {
		//array[i]
		balls[i].draw();
	}

	ctx.fillStyle = "#000000";
	ctx.font = "20px Arial";
	ctx.fillText("Balls: " + balls.length, 10, canvas.height - 10);
	//draw stuff
	}
	function init(){
		ctx = $('#canvas')[0].getContext("2d");
		return setInterval(game_loop, 10)
	}
	init();
}
/*
function myBallDraw() {
	var canvas = document.getElementById('tutorial');
	if (canvas.getContext) {
	  var ctx = canvas.getContext('2d');
	}


	var raf;
	var lives = 3;

	function draw() {

		ctx.clearRect(0, 0, canvas.width, canvas.height);

		ball.draw();
		ball.x += ball.vx;
		ball.y += ball.vy;

	  if(ball.y + ball.radius + ball.vy > canvas.height
	   || ball.y - ball.radius + ball.vy < 0) {
	  	ball.vy = -ball.vy;
	  }

	  if(ball.x + ball.radius + ball.vx > canvas.width
	   || ball.x - ball.radius + ball.vx < 0) {
	  	ball.vx = -ball.vx;
	  }

	  raf = window.requestAnimationFrame(draw);
	}



	var ball = {
	  x: 100,
	  y: 100,
	  vx: 5,
	  vy: 1,
	  radius: 100,
	  color: 'blue',
	  is_mouse_over: function(x,y) {
	  	// return (x -radius) < xParam < (x+radius)
	  	// 	&& ((y-radius) < yParam < (y+radius));
	  	return ((this.x -radius) < x < (this.x+radius))
	  		&& ((this.y-radius) < y < (this.y+radius));
	  },
	  draw: function() {
	    ctx.beginPath();
	    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
	    ctx.closePath();
	    ctx.fillStyle = this.color;
	    ctx.fill();
	  }
	};

	canvas.addEventListener('click', function(e){
		if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
		&& (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)
			){
			ball.radius *= .8;

		} else {
			lives--;
		}

		if(lives <= 0){
			//blabasd.dd
			location.reload();
			alert("You died");
		}

	});

	draw();
}
myBallDraw();
*/
