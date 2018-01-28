window.onload = function(){
	var canvas = document.querySelector("canvas");
	var ctx = canvas.getContext("2d");
	
	var img = new Image();
	img.src = "https://img.itch.zone/aW1hZ2UvNTk0MjAvMjY3MzY5LnBuZw==/original/BAOyZX.png";
	
	var bg = new Image();
	bg.src = "https://i.stack.imgur.com/Mv83H.png";
	
	var rock_b = new Image();
	rock_b.src = 'https://i.imgur.com/VgBVwOm.png';
	
	var ray = new Image();
	ray.src = "https://vignette.wikia.nocookie.net/phobia/images/5/5a/Red.jpg/revision/latest?cb=20161109225243";
	
	var trophy = new Image();
	trophy.src = "https://vignette.wikia.nocookie.net/lookout/images/c/cd/Trophy.png/revision/latest?cb=20150814003216";
	
	var scatter = new Image();
	scatter.src = "http://pixelartmaker.com/art/fc43739adc8ef5e.png";
	
	var theme = new Audio("https://freesound.org/data/previews/404/404145_7814367-lq.mp3");
	
	var shoot = new Audio("https://freesound.org/data/previews/268/268168_5022912-lq.mp3");
	
	var lose = new Audio("https://freesound.org/data/previews/404/404743_140737-lq.mp3");
	
	var win = new Audio("https://freesound.org/data/previews/395/395636_2402876-lq.mp3");
	
	var textFont = "30px Courier New";
	
	var raf;
	var balls = [];
	var points = 0;
	var lives = 1;
	var clicks = -1;
	var started = false;
	var mouseDown = false;
	var keyDown = false;
	var dead = false;

	canvas.style.background = "black";
	ctx.font = textFont;
	ctx.fillStyle = "red";
	ctx.textAlign = "center";
	ctx.fillText("Shoot all the asteroids", canvas.width/2, canvas.height/3);
	ctx.fillText("LMB to start!", canvas.width/2, canvas.height/2);
	
	function getRandomInt(min, max){
		var num = 0;
		while(num==0)num = Math.floor(Math.random() * (max - min + 1)) + min;
		return num;
	}
	
	function Ball(rad, xc, yc){
		if(rad < 0)rad *= -1;
		this.radius = rad;
		this.x = xc;
		this.y = yc;
		this.vx = getRandomInt(-3, 3);
		this.vy = getRandomInt(-3, 3);
		this.img = rock_b;
		this.draw = function(){
			ctx.drawImage(this.img, this.x - this.radius, this.y - this.radius, this.radius*2, this.radius*2);
			
			if(this.y + this.vy > canvas.height - this.radius || this.y + this.vy < this.radius){
				this.vy = -this.vy;
			}
			if(this.x + this.vx > canvas.width - this.radius || this.x + this.vx < this.radius){
				this.vx = -this.vx;
			}
		};
	}
	
	balls.push(new Ball(getRandomInt(5,7)*10, (canvas.width/getRandomInt(2,4)) + getRandomInt(10,50), (canvas.height/2) + getRandomInt(10,50)));
	balls.push(new Ball(getRandomInt(2,4)*10, (canvas.width/getRandomInt(2,4)) + getRandomInt(10,50), (canvas.height/2) + getRandomInt(10,50)));
	
	function draw(){
		ctx.clearRect(0,0, canvas.width, canvas.height);
		ctx.drawImage(bg, 0,0,canvas.width, canvas.height);
		ctx.drawImage(img, window.mousePos.x - 12.5, window.mousePos.y-2, 25, 30);
		
		if(balls.length == 0){
			dead = true;
			theme.pause();
			win.play();
			ctx.fillStyle="orange";
			ctx.globalAlpha = 0.75;
			ctx.rect(canvas.width/2 - 300, canvas.height/3 - 50, 600, 250);
			ctx.stroke();
			ctx.fill();
			ctx.globalAlpha = 1;
			ctx.font=textFont;
			ctx.fillStyle = "black";
			ctx.textAlign = "center";
			ctx.fillText("You won with:", canvas.width/2, canvas.height/3);
			ctx.fillText(points + " points", canvas.width/2, canvas.height/3+30);
			ctx.fillText(clicks + " clicks", canvas.width/2, canvas.height/3+60);
			if(clicks==0)clicks++;
			ctx.fillText(Math.round(points*100/clicks) + "% accuracy", canvas.width/2, canvas.height/3+90);
			ctx.fillText("Press any button to play again", canvas.width/2, canvas.height/3+150);
			ctx.drawImage(trophy, canvas.width/2 - 50, canvas.height/3+250, 100, 100);
			return;
		}
		
		for(var i = balls.length-1; i>=0; i--){
			var b = balls[i];
			if(b.radius <= 0){
				balls.splice(i,1);
				delete b;
				continue;
			}
			b.draw();
			b.x += b.vx;
			b.y += b.vy;
			if(Math.sqrt((window.mousePos.x-b.x)*(window.mousePos.x-b.x) + (window.mousePos.y-b.y)*(window.mousePos.y-b.y)) < b.radius){
				dead = true;
				theme.pause();
				lose.play();
				ctx.fillStyle="black";
				ctx.globalAlpha = 0.75;
				ctx.rect(canvas.width/2 - 300, canvas.height/3 - 50, 600, 250);
				ctx.stroke();
				ctx.fill();
				ctx.globalAlpha = 1;
				ctx.font=textFont;
				ctx.fillStyle="red";
				ctx.textAlign = "center";
				ctx.fillText("You lost with:", canvas.width/2, canvas.height/3);
				ctx.fillText(points + " points", canvas.width/2, canvas.height/3+30);
				ctx.fillText(clicks + " clicks", canvas.width/2, canvas.height/3+60);
				if(clicks==0)clicks++;
				ctx.fillText(Math.round((points*100/clicks)*10)/10 + "% accuracy", canvas.width/2, canvas.height/3+90);
				ctx.fillText("Press any button to try again", canvas.width/2, canvas.height/3+150);
				return;
			}
			
			if((window.mousePos.y >= b.y - b.radius) && (window.mousePos.x >= b.x - b.radius && window.mousePos.x <= b.x + b.radius) && mouseDown){
					ctx.drawImage(ray, window.mousePos.x, window.mousePos.y, 2, b.y - window.mousePos.y);
					ctx.drawImage(scatter, b.x - b.radius - 10, b.y - b.radius - 10, b.radius*2+20, b.radius*2+20);
					shoot.cloneNode(true).play();
					mouseDown = false;
					points++;
					b.radius -= 10;
					balls.push(new Ball(b.radius, b.x, b.y));
					balls.push(new Ball(b.radius, b.x, b.y));
					balls.splice(i,1);
					delete b;
			}
		}
		raf = window.requestAnimationFrame(draw);
	}

	function getMousePos(canvas, evt){
		var rect = canvas.getBoundingClientRect();
		return{
			x: evt.clientX - rect.left,
			y: evt.clientY - rect.top
		};
	}
	
	canvas.addEventListener('click', function(e){
		mouseDown = false;
		if(!started){
			theme.play();
			canvas.style.cursor = "none";
			window.mousePos = getMousePos(canvas, e);
			raf = window.requestAnimationFrame(draw);
			started = true;
			lives = 10000;
		}
	});
	
	canvas.addEventListener('mousedown', function(e){
		mouseDown = true;
		window.mousePos = getMousePos(canvas, e);
		clicks++;
	});
	
	canvas.addEventListener('mousemove',function(e){
		window.mousePos = getMousePos(canvas, e);
	});
	
	document.addEventListener('keypress', function(e){
		if(dead)location.reload();
	});
	
	document.addEventListener('keydown', function(){keyDown = true;});
	document.addEventListener('keyup', function(){keyDown = false;});
}
