/*
WANTED TO USE:
function hasSameColor(color, circle) {
  return circle.color === color;
}

canvas.addEventListener('click', (e) => {
  const mousePos = {
    x: e.clientX - canvas.offsetTop,
    y: e.clientY - canvas.offsetLeft
  };
  // get pixel under cursor
  const pixel = ctx.getImageData(mousePos.x, mousePos.y, 1, 1).data;

  // create rgb color for that pixel
  const color = `rgb(${pixel[0]},${pixel[1]},${pixel[2]})`;

  // find a circle with the same colour
  circles.forEach(circle => {
    if (hasSameColor(color, circle)) {
      alert('click on circle: ' + circle.id);
    }
  });
 });
 */



function init() {
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
	  vy: 3,
	  radius: 80,
	  color: 'navy',
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

	canvas.addEventListener('click', function(e){
		if((e.x - 10 < ball.x + ball.radius && e.x + 10 > ball.x - ball.radius)
		&& (e.y - 10 < ball.y + ball.radius && e.y + 10 > ball.y - ball.radius)
			){
			ball.radius /= 1.1;
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
init();
