function myBallDraw() {
		var canvas = document.getElementById('tutorial');
		
		if (canvas.getContext) {
			var ctx = canvas.getContext('2d');
		}

		var raf;
		var lives = 3;
		var points = 0;

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
		
		function drawHeart(heartId, color) {
		  var canvas = document.getElementById(heartId);
		  if (canvas.getContext) {
			var ctx = canvas.getContext('2d');
		  }
		  
			ctx.beginPath();
			ctx.moveTo(75, 40);
			ctx.bezierCurveTo(75, 37, 70, 25, 50, 25);
			ctx.bezierCurveTo(20, 25, 20, 62.5, 20, 62.5);
			ctx.bezierCurveTo(20, 80, 40, 102, 75, 120);
			ctx.bezierCurveTo(110, 102, 130, 80, 130, 62.5);
			ctx.bezierCurveTo(130, 62.5, 130, 25, 100, 25);
			ctx.bezierCurveTo(85, 25, 75, 37, 75, 40);
			ctx.fillStyle = color;
			ctx.fill();
		}
		
		function writePoints(points) {
			var canvas = document.getElementById("points");
			if (canvas.getContext) {
				var ctx = canvas.getContext('2d');
			}
			ctx.clearRect(0, 0, canvas.width,canvas.height);
			ctx.font = "40px Arial";
			ctx.fillText(points,14,40);
		}
		
		var now = new Date();

		var speed = 1000;
		
		var i = 0;
		var colors = ["blue", "red", "green", "yellow", "black", "pink", "orange"];
		function change() {
			ball.color = colors[i];
			i = (i + 1) % colors.length;
		}
		
		setInterval(change, speed);

		canvas.addEventListener('click', function(e) {
			if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius)
			&& (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)) {
				ball.radius *= 0.9999;
				if(ball.color === "black") {
					lives--;
					if(lives === 2) {
						drawHeart('heart3', 'black');
					} else if(lives === 1) {
						drawHeart('heart2', 'black');
					} else if (lives === 0) {
						drawHeart('heart1', 'black');
						document.getElementById('toshko').play();
						location.reload();
						alert("You died");
					}
				} else if(ball.color === "green") {
					points += 100;
					writePoints(points);
					speed -= 0.02;
					setInterval(change, speed);
				} else if(ball.color === "yellow") {
					speed += 0.05;
					setInterval(change, speed);
				} else {
					points++;
					if(points === 20) {
						colors.push("white");
					}
					writePoints(points);
				}
			} else {
				points--;
				writePoints(points);
			}
		});
		
		draw();

		var newCanvas = document.createElement("canvas");
		newCanvas.id = "heart1";
		newCanvas.width = "150";
		newCanvas.height = "150";
		document.body.appendChild(newCanvas);
		
		var newCanvas = document.createElement("canvas");
		newCanvas.id = "heart2";
		newCanvas.width = "150";
		newCanvas.height = "150";
		document.body.appendChild(newCanvas);
		
		var newCanvas = document.createElement("canvas");
		newCanvas.id = "heart3";
		newCanvas.width = "150";
		newCanvas.height = "150";
		document.body.appendChild(newCanvas);
		
		var newCanvas = document.createElement("canvas");
		newCanvas.id = "points";
		newCanvas.width = "110";
		newCanvas.height = "80";
		document.body.appendChild(newCanvas);
		
		var newAudio = document.createElement("audio");
		newAudio.id = "toshko";
		newAudio.src = "toshko-smqh.mp3";
		newAudio.preload = "auto";
		document.body.appendChild(newAudio);
		
		drawHeart('heart1', 'red');
		drawHeart('heart2', 'red');
		drawHeart('heart3', 'red');
		writePoints(points);
}
