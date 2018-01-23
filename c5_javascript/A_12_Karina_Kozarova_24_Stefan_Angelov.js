 function myBallDraw() {
	var canvas = document.getElementById('tutorial');
	if (canvas.getContext) {
	  var ctx = canvas.getContext('2d');
	}

	var raf;
	var lives = 3;
	var streak = 0;
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


/*	function moveCanvas()
	{
		var div = document.getElementById('div');
		div.style.padding = "100px";
		
	}
*/
	function randomIntFromInterval(min,max){
	    return Math.floor(Math.random()*(max-min+1)+min);
	}

	function changeVelocity(){
		ball.vx *= randomIntFromInterval(1,5);
		ball.vy *= randomIntFromInterval(1,5);
		ball.vy *= -1;
		ball.vx *= -1;
	}

	var ball = {
	  x: 100,
	  y: 100,
	  vx: 5,
	  vy: 1,
	  radius: 80,
	  color: 'blue',
	  is_mouse_over: function(x,y) {
	  	return ((this.x - radius) < x < (this.x + radius)) 
	  		&& ((this.y - radius) < y < (this.y + radius));
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
		if((e.x  < ball.x + ball.radius && e.x > ball.x - ball.radius)
		&& (e.y < ball.y + ball.radius && e.y > ball.y - ball.radius)){
			ball.radius *= .8;
			streak++;
			changeVelocity();
		} else {
			lives--;
			streak = 0;
			ball.vx *= 0.8;
		}
		if(streak % 3 == 0) lives++;
		if(lives <= 0){
			location.reload();
			alert("You died");
		}
		document.getElementById("stats").innerHTML = "Lives:" + " " + lives + " Streak: " + streak;

	});
	//moveCanvas();
	canvas.style.backgroundImage = "url(https://sports.cbsimg.net/images/nhl/blog/NHL_Patrick_Kane_Investigation.jpg)";
	draw();
	
}
myBallDraw();
