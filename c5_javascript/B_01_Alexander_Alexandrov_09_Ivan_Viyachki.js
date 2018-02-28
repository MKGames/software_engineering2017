function init(){
        var canvas = document.getElementById('canvas');
        var ctx = canvas.getContext('2d');
        var raf;
        var lives = 3;
        var clicks = 1;
         
        var ball = {
            x: 100,
            y: 100,
            vx: 5,
            vy: 2,
            color: 'green',
            radius: 100,
            is_mouse_over: function(x,y){
 
            },
            draw: function() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
                ctx.closePath();
                ctx.fillStyle = this.color;
                ctx.fill();
 
            },
            click: function() {
               
            }
        };
       
        function draw() {    
          ctx.clearRect(0,0, canvas.width, canvas.height);
          ball.draw();
          ball.x += ball.vx;
          ball.y += ball.vy;
 
          if (ball.y + ball.vy > canvas.height ||
              ball.y + ball.vy < 0) {
            ball.vy = -ball.vy;
          }
          if (ball.x + ball.vx > canvas.width ||
              ball.x + ball.vx < 0) {
            ball.vx = -ball.vx;
          }
 
          raf = window.requestAnimationFrame(draw);
        }
 
        canvas.addEventListener('mouseover', function(e) {
          raf = window.requestAnimationFrame(draw);
        });
 
        canvas.addEventListener('mouseout', function(e) {
          window.cancelAnimationFrame(raf);
        });
 
        ball.draw();
 
        canvas.addEventListener('click', function(e){
        if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
        && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)
            ){
            ball.radius *= .8;
            clicks++;
        } else {
            if(lives == 3){
                ball.color = 'yellow';
            }
            if(lives == 2){
                ball.color = 'red';
            }
            lives--;
        }
 
        if(lives < 1){
            //blabasd.dd
            location.reload();
            alert("You died");
        }
    });
 
    }
