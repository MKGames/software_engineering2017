function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }
   
  function myBallDraw() {
      var canvas = document.getElementById('canvas');
      if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
      }
   
      var raf;
      var lives = 3;
	  var s = 0;
    
	  
      function draw() {
          ctx.fillStyle = 'rgba(255, 255, 255, 0.3)';
          ctx.fillRect(0, 0, canvas.width, canvas.height);
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
         
		ctx.font = '32px rtl';
		ctx.fillText(lives + ' tries until you DIE!!! ', 10, 50);
		 ctx.font = '48px rtl';
		 ctx.fillText( ' score: ' + s, 500, 50);
		 
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
   
      canvas.addEventListener('click', function(e){
          if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
          && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)
              ){
                /*a = Math.random()*1.5;
                while(a < .1 || a > 2)
                {
                    a = Math.random();
                }*/
              ball.radius *= Math.floor(Math.random() * 1.3) + .5;
              ball.color = getRandomColor();
			  s ++;
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