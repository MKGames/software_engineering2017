function myBallDraw()
{
    var canvas = document.getElementById('tutorial');
    if (canvas.getContext) {
      var ctx = canvas.getContext('2d');
    }
 
    var raf;
    var lives = 3;
    var score = 0;
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
	ctx.fillStyle = "green";
	ctx.font = "30px Arial";
	ctx.fillText("Score: " + score,10,50);
	ctx.fillText("Lives: " + lives,10,50 + 30);
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
        //  && ((y-radius) < yParam < (y+radius));
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
 
    canvas.addEventListener('click', function(e)
    {
 
        if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
        && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)
            ){
            ball.radius *= 0.8;
            ball.color = "#"+Math.floor(Math.random()*16777215).toString(16);
            ball.vx+=2;
            ball.vy+=2;
	    score ++;
        } else {
		lives--;
		
        }
 
        if(lives < 1){
            location.reload();
            alert("You died");
        }
    });
 
    draw();
}
myBallDraw();
