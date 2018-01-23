 function init(){
var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');
var raf;
var running = true;
raf = window.requestAnimationFrame(draw);
var lives = 3;
var c;
var points = 0;

document.getElementById("jivoti1").value=lives;
document.getElementById("jivoti1").innerHTML=lives;


document.getElementById("tochki").value = points;
document.getElementById("tochki").innerHTML = points;


function reloadLives() {
    var lives1 = lives; // set your price here

    // get a ref to your element and assign value
    var elem = document.getElementById("lives");
    elem.value = lives;
}

var ball = {
  x: 100,
  y: 100,
  vx: 5,
  vy: 1,
  radius: 80,
  color: 'blue',
  draw: function() {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
    ctx.closePath();
    ctx.fillStyle = this.color;
    ctx.fill();
  }
};


 
function clear() {
  ctx.fillStyle = 'rgba(255, 255, 255, 0.3)';
  ctx.fillRect(0,0,canvas.width,canvas.height);
};
 
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
    };
	
function changecolor(){
			c = getRandomInt(4); 
			
			if(c == 0){
			ball.color = 'red';
			} 
			
		    if(c == 1){
			ball.color = 'green';
			} 
			
			if(c == 2){
			ball.color = 'blue';
			}
			
			if(c == 3){
			ball.color = 'transparent';
			setTimeout(changecolor,3000);
			}
}	

	
function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

canvas.addEventListener('click', function(e) {
if((e.x - 10 < ball.x + ball.radius && e.x - 10 > ball.x - ball.radius) && (e.y - 10 < ball.y + ball.radius && e.y - 10 > ball.y - ball.radius)){
			
		if(ball.color =='red'){
			ball.vx = ball.vx*1.5;
			ball.vy = ball.vy*1.5;			
			points += 15;
			} 
			
		if (ball.color == 'green'){				
			ball.radius *= .8;
			points += 10;
			}
			
		if (ball.color == 'blue'){				
			points += 5;
			}
			
		changecolor();	
		
		document.getElementById("tochki").value = points;
		document.getElementById("tochki").innerHTML = points;
	
		}else {
			lives--;
			document.getElementById("jivoti1").value=lives;
			document.getElementById("jivoti1").innerHTML=lives;
		}

		if(lives < 1){
			location.reload();
			alert("You died");
		}
});
 
ball.draw();
};