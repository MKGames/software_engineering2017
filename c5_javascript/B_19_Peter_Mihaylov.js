var canvas = document.getElementById('tutorial');
var ctx = canvas.getContext('2d');
var bounce_distance = 80;
var flag = false;
var raf;

var info = document.createElement('canvas');
var l = info.getContext('2d');
info.id = "lives";
info.width = 150;
info.height = 35;
info.style.left = "20px";
info.style.top = "10px";
info.style.position = "absolute";
document.body.appendChild(info);


obj1 = new Obstacle(100, 200, 20, 150, 'rgba(10, 80, 80, 0.9)');
obj2 = new Obstacle(200, 505, 20, 200, 'rgba(10, 100, 100, 0.6)');
obj3 = new Obstacle(300, 400, 20, 100, 'rgba(10, 64, 64, 0.7)');
obj4 = new Obstacle(323, 20, 20, 300, 'rgba(10, 100, 100, 0.7)');

var food = {
    x: 40,
    y: 100,
    color: 'orange',
    draw: function () {
        ctx.beginPath();
        ctx.fillStyle = this.color;
        ctx.moveTo(83 + this.x, 116 + this.y);
        ctx.lineTo(83 + this.x, 102 + this.y);
        ctx.bezierCurveTo(83 + this.x, 94 + this.y, 89 + this.x, 88 + this.y, 97 + this.x, 88 + this.y);
        ctx.bezierCurveTo(105 + this.x, 88 + this.y, 111 + this.x, 94 + this.y, 111 + this.x, 102 + this.y);
        ctx.lineTo(111 + this.x, 116 + this.y);
        ctx.lineTo(106.333 + this.x, 111.333 + this.y);
        ctx.lineTo(101.666 + this.x, 116 + this.y);
        ctx.lineTo(97 + this.x, 111.333 + this.y);
        ctx.lineTo(92.333 + this.x, 116 + this.y);
        ctx.lineTo(87.666 + this.x, 111.333 + this.y);
        ctx.lineTo(83 + this.x, 116 + this.y);
        ctx.fill();

        ctx.fillStyle = 'white';
        ctx.beginPath();
        ctx.moveTo(91 + this.x, 96 + this.y);
        ctx.bezierCurveTo(88 + this.x, 96 + this.y, 87 + this.x, 99 + this.y, 87 + this.x, 101 + this.y);
        ctx.bezierCurveTo(87 + this.x, 103 + this.y, 88 + this.x, 106 + this.y, 91 + this.x, 106 + this.y);
        ctx.bezierCurveTo(94 + this.x, 106 + this.y, 95 + this.x, 103 + this.y, 95 + this.x, 101 + this.y);
        ctx.bezierCurveTo(95 + this.x, 99 + this.y, 94 + this.x, 96 + this.y, 91 + this.x , 96 + this.y);
        ctx.moveTo(103 + this.x, 96 + this.y);
        ctx.bezierCurveTo(100 + this.x, 96 + this.y, 99 + this.x, 99 + this.y, 99 + this.x, 101 + this.y);
        ctx.bezierCurveTo(99 + this.x, 103 + this.y, 100 + this.x, 106 + this.y, 103 + this.x, 106 + this.y);
        ctx.bezierCurveTo(106 + this.x, 106 + this.y, 107 + this.x, 103 + this.y, 107 + this.x, 101 + this.y);
        ctx.bezierCurveTo(107 + this.x, 99 + this.y, 106 + this.x, 96 + this.y, 103 + this.x, 96 + this.y);
        ctx.fill();

        ctx.fillStyle = 'black';
        ctx.beginPath();
        ctx.arc(101 + this.x, 102 + this.y, 2, 0, Math.PI * 2, true);
        ctx.fill();

        ctx.beginPath();
        ctx.arc(89 + this.x, 102 + this.y, 2, 0, Math.PI * 2, true);
        ctx.fill();
        ctx.closePath();
    }
};
var ball = {
    x: 50,
    y: 350,
    cy: 0,
    vx: 0.99,
    vy: 2,
    right: 3,
    left: -3,
    bounce_speed: .99,
    radius: 20,
    color: 'blue',
    draw: function() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.fillStyle = this.color;
        ctx.fill();

        ctx.fillStyle = 'rgba(255, 255, 255, 0.35)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }
};

function  Obstacle (x, y, height, width, color) {
    this.x = x;
    this.y = y;
    this.height = height;
    this.width = width;
    this.color = color;
    this.draw = function () {
        ctx.beginPath();
        ctx.fillStyle = this.color;
        ctx.rect(this.x, this.y, this.width, this.height);
        ctx.fill();
        ctx.closePath();
        return this;
    };
    this.crashWith = function (){
        var myleft = this.x;
        var myright = this.x + (this.width);
        var mytop = this.y;
        var mybottom = this.y + (this.height);
        var otherleftX = ball.x - ball.radius;
        var otherrightX = ball.x + ball.radius;
        var othertopY = ball.y - ball.radius;
        var otherbottomY = ball.y + ball.radius;
        var crash = true;
        if((mybottom < othertopY) ||
            (mytop > otherbottomY) ||
            (myright < otherleftX) ||
            (myleft > otherrightX)){
            crash = false;
        }
        return crash;
    };
}

function  myBallDraw() {
    raf = window.requestAnimationFrame(update);
}

document.addEventListener('keydown', function(event) {
    if(event.keyCode === 37){
        if(ball.x >= ball.radius - 2)
            ball.x += ball.left;
    }else if(event.keyCode === 39){
        if(ball.x <= canvas.width - ball.radius - 2)
            ball.x += ball.right;
    }else if(event.keyCode === 38){
        if((ball.cy - bounce_distance) > ball.radius) {
            ball.cy -= 20;
        }
    }else if(event.keyCode === 40){
        if(ball.y + ball.radius > ball.cy && ball.cy < canvas.height) {
            ball.cy += 20;}
    }
});

function outside_y(obj){
    return ((obj.y + obj.vy > canvas.height) || (obj.y + obj.vy < 0));
}
function outside_x(obj){
    return (obj.x + obj.vx > canvas.width || obj.x + obj.vx < 0);
}

var state = true;
var score = 0;
var lives = 3;
var count = 0;

function update() {
    ball.draw();

    food.draw();
    var ballLeftX = ball.x - ball.radius;
    var ballRightX = ball.x + ball.radius;
    var BallTopY = ball.y - ball.radius;
    var BallBottomY = ball.y + ball.radius;

    if(ballLeftX <= food.x + 83 && ballRightX >= food.x + 83 && BallTopY <= food.y + 116 && BallBottomY >= food.y + 116){
        food.x = Math.floor(Math.random() * ((canvas.width - 83) - 83 + 1)) + 83;
        food.y = Math.floor(Math.random() * (canvas.height - 116) - 116 + 1) + 116;
        l.fillStyle = 'rgba(255, 255, 255, 1)';
        l.fillRect(0, 0, canvas.width, canvas.height);
        score++;
        ball.vx += .6;
        ball.vy += .3;
    }

    l.fillStyle = 'rgba(3, 0, 0, 0.9)';
    l.font = "italic  20px serif";
    if(lives > 0) {
        l.fillText("lives: " + lives + " score: " + score, 4, info.height / 2);
    }
    var prev_state = state;
    if(obj1.crashWith() || obj2.crashWith() || obj3.crashWith() || obj4.crashWith()){
        state = false;
    }else state = true;

    if(prev_state !== state){
        l.fillStyle = 'rgba(255, 255, 255, 1)';
        l.fillRect(0, 0, canvas.width, canvas.height);
        count++;
        if(count === 2){
            count = 0;
            ball.y = canvas.height - 5;
            ball.x = 0;
            lives--;
            ball.vx -= .3;
        }
    }

    if(ball.cy - bounce_distance > ball.y && flag){
        ball.vy  = -ball.vy;
    }

    ball.y += ball.vy;
    obj1.y += 1.3;
    obj2.y += 2;
    obj2.x += 0.3;
    obj3.y += 1.4;
    obj3.x -= 0.4;
    obj4.x -= 0.3;
    obj4.y += 2.3;
    obj3.draw();
    obj1.draw();
    obj2.draw();
    obj4.draw();

    if(obj1.y > canvas.height){
        generate(obj1);
    }
    if(obj3.y > canvas.height){
        generate(obj3);
    }
    if( obj2.y > canvas.height){
        generate(obj2);
    }
    if(obj4.y > canvas.height){
        generate(obj4);
    }
    if (outside_y(ball)) {
        flag = true;
        ball.cy = canvas.height;
        ball.vy = -ball.vy;
    }
    if (outside_x(ball)) {
        ball.vx = -ball.vx;
    }
    if(lives < 1){
        window.cancelAnimationFrame(raf);
        ctx.font = "30px Comic Sans MS";
        ctx.fillStyle = "green";
        ctx.textAlign = "center";
        ctx.fillText("Your score is: "+score, canvas.width/2, canvas.height/2);

        setInterval(
            function(){
                document.body.style.backgroundColor = 'white';
                location.reload();
            }, 3000);

    }
    raf = window.requestAnimationFrame(update);
}
function random_place(obj){
    var min = 5;
    obj.x = Math.floor(Math.random() * (canvas.width - min + 1)) + min;
    obj.y = Math.floor(Math.random() * (canvas.height - min + 1)) + min;
}
function generate(obj){
    random_place(obj);
    obj.width = Math.floor(Math.random() * (170)) + 80;
}