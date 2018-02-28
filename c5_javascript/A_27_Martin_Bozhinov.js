function myBallDraw() {
	var canvas = document.getElementById('canvas');
	if (canvas.getContext) {
	  var ctx = canvas.getContext('2d');
	}

	var raf;
	var lives = 3;
	var ball = new Ball();

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

	// var b1 = new Ball();
	// draw(b1);



	function Ball() {
	  this.x = 100,
	  this.y = 100,
	  this.vx = 5,
	  this.vy = 2.56,
	  this.radius = 100,
	  this.c = 1;
	  this.color = 'blue',
	  this.is_mouse_over = function(x,y) {
	  	// return (x -radius) < xParam < (x+radius) 
	  	// 	&& ((y-radius) < yParam < (y+radius));
	  	return ((this.x -radius) < x < (this.x+radius)) 
	  		&& ((this.y-radius) < y < (this.y+radius));
	  },
	  this.draw = function() {
	    ctx.beginPath();
	    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
	    ctx.closePath();
	    ctx.fillStyle = this.color;
	    ctx.fill();

	  }
	};

	canvas.addEventListener('click', function(e){
		  setInterval(function() {
		  		ball.color = 'white';
		  		// console.log("white");
			}, 1000);
		  setInterval(function() {
		  			  		// console.log("blue");
		  		ball.color = 'red';
			}, 1500);
		  	setInterval(function() {
		  			  		// console.log("blue");
		  		ball.color = 'blue';
			}, 1800);

		if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
		&& (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)) {
			if(ball.color == 'blue') {
				ball.radius *= .8;
			} else {
				lives--;
			}

		} else {
			lives--;
		}

		if(lives < 1){
			//blabasd.dd
			location.reload();
			alert("You died");
		}
	});

	draw();
}