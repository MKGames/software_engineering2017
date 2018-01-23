function randomColors() {
  return '#' + Math.floor(Math.random() * 16777215).toString(16);
}

function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
}

function myBallDraw() {
    var canvas = document.getElementById('tutorial');

    if(canvas.getContext) {
        var ctx = canvas.getContext('2d');
    }
 
    var raf;
    var lives = 5;
    var success = 0;
    var ballSpeedX = 5;
    var ballSpeedY = 1;
 
    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ball.draw();
        ball.x += ball.vx;
        ball.y += ball.vy;
        ball.vy *= .995;
        ball.vy += .4;
 
        if(ball.y + ball.radius + ball.vy > canvas.height || ball.y - ball.radius + ball.vy < 0) {
            ball.vy = -ball.vy;
        }
 
        if(ball.x + ball.radius + ball.vx > canvas.width || ball.x - ball.radius + ball.vx < 0) {
            ball.vx = -ball.vx;
        }
        raf = window.requestAnimationFrame(draw);
    }
 
    var ball = {
        x: 100,
        y: 100,
        vx: ballSpeedX,
        vy: ballSpeedY,
        radius: 75,
        color: 'blue',
        is_mouse_over: function(x,y) {
            return ((this.x -radius) < x < (this.x+radius)) && ((this.y-radius) < y < (this.y+radius));
        },
        draw: function() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.fillStyle = this.color;
            ctx.fill();
        }
    };

    ball.color = randomColors();

    canvas.addEventListener('click', function(e) {
        if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius) && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)) {
            ball.color = randomColors();
            var randomNum = getRandomArbitrary(0.5, 0.9);
            ball.radius *= randomNum;
            ball.vx += 2;
            ball.vy += 1;
            success++;
        } else {
            console.log(lives);
            lives--;
            if(lives == 0) {
                location.reload();
                alert("My man, you died...");
            }
        }
 
        if(success == 3) {
            if(ball.vx >= 0) {
                ball.vx = ballSpeedX + 2;
                ballSpeedX = ball.vx + 2;
            } else ball.vx = -ballSpeedX - 2;

            if(ball.vy >= 0) {
                ball.vy = ballSpeedY + 2;
                ballSpeedY = ball.vy + 2;
            } else ball.vy = -ballSpeedY - 2;
            // ball.vy += ballSpeedY + 1;
            // ballSpeedY = ball.vy + 1;
            success = 0;
            ball.radius = 75;
        }
 

    });
 
    draw();
}
myBallDraw();
