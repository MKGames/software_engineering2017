function myBallDraw() {
	var canvas = document.getElementById('tutorial');
	if (canvas.getContext) {
	  var ctx = canvas.getContext('2d');
	}
   
    	alert("Red color - 1p. | Blue color - 2p.");
	var raf;
	var lives = 3;
    	var counter = 0;
    	var score = 0;
    
	function draw()
	{
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		ball.draw();
		ball.x += ball.vx;
		ball.y += ball.vy;

	  	if(ball.y + ball.radius + ball.vy > canvas.height || ball.y - ball.radius + ball.vy < 0) {
	  		ball.vy = -ball.vy;
	  	}

	  	if(ball.x + ball.radius + ball.vx > canvas.width || ball.x - ball.radius + ball.vx < 0) {
	  	ball.vx = -ball.vx;
	  	}

	  	raf = window.requestAnimationFrame(draw);
      	  	ctx.font = "30px Comic Sans MS";
      	  	ctx.fillStyle = ball.curr_color;
      	  	ctx.textAlign = "center";
      	  	ctx.fillText("Score: " + score,canvas.width/2, canvas.height/2);
      	  	ctx.fillText("Lives: " + lives,canvas.width/2, canvas.height/2 + 30);
	}




	var ball = {
	  x: 100,
	  y: 100,
	  vx: 5,
	  vy: 5,
	  radius: 100,
	  color: ['blue','red','yellow'],
	  curr_color: 'red',
	  is_mouse_over: function(x,y) {
	 
	  	return ((this.x - radius) < x < (this.x + radius)) && ((this.y - radius) < y < (this.y + radius));
	  },
	  draw: function()
	  {
	    ctx.beginPath();
	    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
	    ctx.closePath();
	    this.curr_color = this.color[Math.floor(Math.random() * this.color.length)];
	    ctx.fillStyle = this.curr_color;
	    ctx.fill();
	  }
	};
    
	canvas.addEventListener('click', function(e){
		if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
		&& (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius))
		{
            		if(ball.curr_color == "red")score+=1;
            		else if(ball.curr_color == "blue")score+=2;
            
           		counter ++;
			ball.radius *= .8;
            		if(counter%2==0)
           	 	{
                    		ball.vx+=5;
                    		ball.vy+=10;
            		}
            		else 
            		{
                    		ball.vx+=10;
                    		ball.vy+=3;
            		}
			
			} 
			else 
			{
				ball.radius *= 1.0;
				lives--;
			}

			if(lives < 1)
			{
	    			location.reload();
            			var converted_score = score.toString();
            			var message = "You died. Gained points: ";
            			var full_message = message+converted_score;
	    			alert(full_message);
			}
		});
  
	draw();
}
myBallDraw();
