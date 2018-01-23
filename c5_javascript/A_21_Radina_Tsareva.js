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
	 if(ball.y >45)
	{
	  	ball.vy =ball.vy-1;
		if(ball.y + ball.radius + ball.vy > canvas.height
	   || ball.y - ball.radius + ball.vy < 0) {
	  	ball.vy = -ball.vy;
	  }
	  }
	 
	  if(ball.x + ball.radius + ball.vx > canvas.width
	   || ball.x - ball.radius + ball.vx < 0) {
	  	ball.vx = -ball.vx;
		//ball.vx+=4;
	  }
	 if(ball.x <canvas.width && ball.x>400) {
	  	ball.vx =2+ball.vx;
		
	  /*if(ball.x + ball.radius + ball.vx > canvas.width
	   || ball.x - ball.radius + ball.vx < 0) {
	  	ball.vx = -ball.vx;
	  }*/
	  }

	//ctx.fillRect(45,90,50,50);
	ctx.fillStyle="red";
	ctx.fillRect(0,200,canvas.width,canvas.height-100);
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

		if(lives < 1){
			//blabasd.dd
			location.reload();
			alert("You died");
		}
	});

	draw();
}
