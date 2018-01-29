
"use strict";
// Initial Setup

var canvas = document.getElementById('tutorial'); //searches until it finds the canvas tag
var c = canvas.getContext('2d'); //c for content :)

canvas.width = 800; //or window.canvas.width
canvas.height = 600;

var lives = 3;
var points = 0;

var mouse = {
    x: null,
    y: null
}

var ballPosition = {
    x: null,
    y: null
}

var colorArray = [
    '#FF4500',
    '#89FFDE',
    '#10234E',
    '#A3E330',
    '#581845'
];

var desiredColor = colorArray[Math.floor(Math.random() * colorArray.length)];

window.addEventListener('mousemove',
    function(event){
        mouse.x = event.x;
        mouse.y = event.y;
});

//Dinamic resize screen
window.addEventListener('resize',
    function(){
        canvas.width = canvas.width; //or window.canvas.width
        canvas.height = canvas.height;
        // init();
});

canvas.addEventListener('click',
    function(event){
        ballPosition.x = event.x;
        ballPosition.y = event.y;
});

function Circle(x, y, dx, dy, radius){
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.radius = radius;

    var minRadius = radius;
    var color = colorArray[Math.floor(Math.random() * colorArray.length)];
    var maxRadius = 40;
    var lastX = ballPosition.x;
    var lastY = ballPosition.y;

    this.draw = function(){
        c.beginPath();
        c.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
        c.fillStyle = color;
        c.fill();
    }

    this.update = function() {
        if( this.x + this.radius > canvas.width || this.x - this.radius < 0){
            this.dx = -this.dx;
        }
        if( this.y + this.radius > canvas.height || this.y - this.radius < 0){
            this.dy = -this.dy;
        }

        this.x += this.dx;
        this.y += this.dy;

        //Interactivity
        if (mouse.x - this.x < 50 && mouse.x - this.x > -50 && mouse.y - this.y < 50 && mouse.y - this.y > -50 ){
            if(this.radius < maxRadius){
                this.radius += 1;
            }
        } else if(this.radius > minRadius){
            this.radius -= 1;
        }

        //Game
        if((ballPosition.x < this.x + this.radius && ballPosition.x > this.x - this.radius)&&(ballPosition.y < this.y + this.radius && ballPosition.y > this.y - this.radius)&&color == desiredColor)
        {
            color = "rgba(255, 255, 255, 0)";
            points++;
        }

        this.draw();

    }

    this.getColor = function(){
        return color;
    }
}

var circleArray = [];

function init(){
    // alert("Click the balls with the same color as the displayed points! Have fun!");
    circleArray = [];
    for (var i = 0; i < 15; i++) {
        var radius = (Math.random() * 3) + 7;
        var x = Math.random() * canvas.width * 0.5;
        var y = Math.random() * canvas.height * 0.5;
        var dx = (Math.random() - 0.5) * 5;
        var dy = (Math.random() - 0.5) * 5;

        circleArray.push(new Circle(x, y, dx, dy, radius));
    }
}

function animate() {
    requestAnimationFrame(animate);
    c.clearRect(0, 0, canvas.width, canvas.height);
    c.font = '80px arial';
    c.fillStyle = desiredColor;
    c.fillText(points, 10, 70);
    var game_won = true;

    for (var i = 0; i < circleArray.length; i++) {
        circleArray[i].update();
        if(circleArray[i].getColor() == desiredColor) game_won = false;
    }

    if (game_won){
        alert("Well done");
        location.reload();
    }
}

init();
animate(); //Calling the self-called function
