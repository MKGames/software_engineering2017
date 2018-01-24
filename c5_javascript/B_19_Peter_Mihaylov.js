function  myBallDraw() {
    var canvas = document.getElementById('tutorial');
    var s = document.getElementById('score');
    var l = document.getElementById('lives');
    var display = true;
    var raf;
    var score = 0;
    var lives = 3;

    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        var ball = {
            x: 100,
            y: 100,
            vx: 5,
            vy: 2.3,
            radius: 50,
            color: 'blue',
            draw: function() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
                ctx.closePath();
                ctx.fillStyle = this.color;
                ctx.fill();
            }
        };


        canvas.addEventListener('click', function(e){
            if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius) && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)
            ){
                ball.radius -= 10;
                score++;
                ball.vx *= .99;
                ball.vy += 2.5;
                if((score % 2) === 0){
                    ball.vx = -ball.vx;
                }


                var min = 0;
                ball.x = Math.floor(Math.random() * (canvas.width - min + 1)) + min;
                ball.y = Math.floor(Math.random() * (canvas.height - min + 1)) - min;
                ball.color = 'green';

            } else {
                if(score < 5)lives--;
                ball.radius += 10;
                ball.vy /= .99;
                ball.vx *= .90;
                ball.color = 'red';
            }

            if(display) {
                s.innerHTML = score;
                l.innerHTML = lives;
            }
            if(score === 5){
                display = false;
                window.cancelAnimationFrame(raf);
                ctx.font = "30px Comic Sans MS";
                ctx.fillStyle = "green";
                ctx.textAlign = "center";
                ctx.fillText("You win!", canvas.width/2, canvas.height/2);
                document.body.style.backgroundColor = 'green';

                setInterval(
                    function(){
                        document.body.style.backgroundColor = 'white';
                        display = true;
                        location.reload();
                    }, 3000);
            }
            if(lives < 1){
                display = false;
                window.cancelAnimationFrame(raf);
                ctx.font = "30px Comic Sans MS";
                ctx.fillStyle = "red";
                ctx.textAlign = "center";
                ctx.fillText("You lose!", canvas.width/2, canvas.height/2);
                document.body.style.backgroundColor = 'red';

                setInterval(
                    function(){
                        display = true;
                        document.body.style.backgroundColor = 'white';
                        location.reload();
                    }, 3000);

            }
        });
            raf = window.requestAnimationFrame(draw);
    }

    function draw() {
        ctx.fillStyle = 'rgba(255, 255, 255, 0.3)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ball.draw();

        ball.x += ball.vx;
        ball.y += ball.vy;
        if (ball.y + ball.vy > canvas.height || ball.y + ball.vy < 0) {
            ball.vy = -ball.vy;
        }
        if (ball.x + ball.vx > canvas.width || ball.x + ball.vx < 0) {
            ball.vx = -ball.vx;
        }
        raf = window.requestAnimationFrame(draw);
    }
}

