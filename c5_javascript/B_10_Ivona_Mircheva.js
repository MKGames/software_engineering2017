"use strict";
// Initial Setup
let canvas = document.querySelector('canvas'); //searches until it finds the canvas tag
let c = canvas.getContext('2d'); //c for content :)

// canvas.width = 800; //or window.canvas.width
// canvas.height = 600;

let lives = 3;
let points = 0;

let mouse = {
    x: undefined,
    y: undefined
}

let ballPosition = {
    x: undefined,
    y: undefined
}

let colorArray = [
    '#FF4500',
    '#89FFDE',
    '#10234E',
    '#A3E330',
    '#581845'
];

let desiredColor = colorArray[Math.floor(Math.random() * colorArray.length)];
// document.getElementById("dead_inside").style.color = desiredColor;

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
        init();
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
    this.minRadius = radius;
    this.color = colorArray[Math.floor(Math.random() * colorArray.length)];
    let maxRadius = 40;
    let lastX = ballPosition.x;
    let lastY = ballPosition.y;


    this.draw = function(){
        c.beginPath();
        c.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
        c.fillStyle = this.color;
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
        }else if(this.radius > this.minRadius){
            this.radius -= 1;
        }

        //Game
        if((ballPosition.x - 10 < this.x + this.radius && ballPosition.x - 10 > this.x - this.radius)
        && (ballPosition.y - 10 < this.y + this.radius && ballPosition.y - 10 > this.y - this.radius) && this.color == desiredColor
            ){
            // this.color = '#FFFFFF';
            this.color = "rgba(255, 255, 255, 0)";
            points++;
            // document.getElementById("dead_inside").innerHTML = "Click this color! Points: " + points;
        }
        // else if (ballPosition.x != undefined){
        //     lives--;
        //     document.getElementById("dead_inside").innerHTML = "Click this color! Lives: " + lives + " Points: " + points;
        // }

        // if(lives < 1){
        //     document.getElementById("dead_inside").innerHTML = "You died! Lives: " + lives + " Points: " + points;
        // }
        this.draw();

    }
}
let circleArray = [];

function init(){
    alert("Click the balls with the same color as the displayed points! Have fun!");
    circleArray = [];
    for (let i = 0; i < 100; i++) {
        let radius = (Math.random() * 3) + 3;
        let x = Math.random() * (canvas.width - radius * 2) + radius;
        let y = Math.random() * (canvas.width - radius * 2) + radius;
        let dx = (Math.random() - 0.5) * 5;
        let dy = (Math.random() - 0.5) * 5;
        circleArray.push(new Circle(x, y, dx, dy, radius));

    }
}

function animate() {
    requestAnimationFrame(animate);
    c.clearRect(0, 0, canvas.width, canvas.height);
    c.font = '80px arial';
    c.fillStyle = desiredColor;
    c.fillText(points, 10, 70);
    let well_done = true;

    for (let i = 0; i < circleArray.length; i++) {
        circleArray[i].update();
        if(circleArray[i].color == desiredColor){well_done = false;}
    }
    if (well_done){
        alert("Well done");
        location.reload();
    }
}

init();
animate(); //Calling the self-called function
