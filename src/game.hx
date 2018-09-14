import hxd.Key in K;

class Game extends hxd.App {
    var paddle: h2d.Graphics;
    var paddleSize = 250;
    var ball: h2d.Graphics;
    var ballxdirection = 1;
    var ballydirection = 1;
    var maxWidth = 700;
    override function init() {
        paddle = new h2d.Graphics(s2d);
        paddle.beginFill(0xffffff);
        paddle.drawRect(10, 900, paddleSize, 50);
        paddle.endFill();

        ball = new h2d.Graphics(s2d);
        ball.beginFill(0xffffff);
        ball.drawCircle(50,50, 30);
    }

    override function update(dt:Float) {
        if( K.isDown(K.RIGHT) && (paddle.x+paddleSize) + 10 <= maxWidth){
            paddle.x += 10.0;
        }
        if( K.isDown(K.LEFT) && paddle.x - 10 >= 0){
            paddle.x -= 10.0;
        }

        //var ballx = ball.x;
        //var bally = ball.y;
        var paddleCol = new h2d.col.Bounds();
        paddleCol.set(paddle.x, 900, paddleSize, 50.0);
        var ballCol = new h2d.col.Circle(ball.x+(ballxdirection+10), ball.y+(ballydirection+10), 30.0);
        
        if(ballCol.collideBounds(paddleCol)){
            ballxdirection *= -1;
            ballydirection *= -1;
        } else {
            if(ballxdirection == 1){
                if(ball.x + 10 > maxWidth){
                    ballxdirection = -1;
                } 
            } else {
                if(ball.x - 10 < 0){
                    ballxdirection = 1;
                }
            }
            if(ballydirection == 1){
                if(ball.y + 10 > 900){
                    ballydirection = -1;
                }
            } else {
                if(ball.y - 10 < 0){
                    ballydirection = 1;
                }
            }
        }
        ball.x += (10 * ballxdirection);
        ball.y += (10 * ballydirection);
        
    }

    static function main() {
        new Game();
    }
}
