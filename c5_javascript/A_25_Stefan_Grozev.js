function timer() {

}

function myBallDraw() {
	var canvas = document.getElementById('tutorial');
	if (canvas.getContext) {
	  var ctx = canvas.getContext('2d');
	}

	var raf;
	var lives = 3;
	var points = 0;

	var newPoints = document.createElement("p");
	newPoints.id = "points";
	document.body.appendChild(newPoints);
	var newLives = document.createElement("p");
	newLives.id = "lives";
	document.body.appendChild(newLives);

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
	  	var d = new Date();
	  	if(d.getSeconds() % 3 == 0){
	  		ball.color = 'red';
	  	}
	  	if(d.getSeconds() % 5 == 0){
	  		ball.color = 'green';
	  	}
	  	if(d.getSeconds() % 11 == 0){
	  		ball.color = 'blue';
	  	}
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
			if(ball.color == 'green'){
				points += 2;
			}
			if(ball.color == 'blue'){
				points++;
			}
			if(ball.color == 'red'){
				points-= 3;
			}
		} else {
			lives--;
		}

		newPoints.innerHTML = "points: " + points;
		newLives.innerHTML = "lives: " + lives;

		if(lives < 1 || points < 0){
			//blabasd.dd
			alert("You died");
			location.reload();
		}
	});

	draw();
}
myBallDraw();