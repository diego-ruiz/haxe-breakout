import hxd.Key in K;

class Game extends hxd.App {
    var paddle: h2d.Graphics;
    var paddleSize = 250;
    var ball: h2d.Graphics;
    var ballxdirection = 1;
    var ballydirection = 1;
    var maxWidth = 700;
    var blocks = [];

    override function init() {
        paddle = new h2d.Graphics(s2d);
        paddle.beginFill(0xffffff);
        paddle.drawRect(10, 900, paddleSize, 50);
        paddle.endFill();

        ball = new h2d.Graphics(s2d);
        ball.beginFill(0xffffff);
        ball.drawCircle(15, 15, 30);
        resetBall();

        for(i in 0...7){
            var row = [];
            for (j in 0...5){
                var block = new h2d.Graphics(s2d);
                block.beginFill(0xffffff);
                var x = 10+20+(i*100);
                var y = 10+20+(j*40);
                block.drawRect(0, 0, 70, 30);
                block.endFill();
                block.x = x;
                block.y = y;
                trace(block.x, block.y, x, y);
                row[j] = block;
            }
            blocks[i] = row;
        }
    }

    function resetBall(){
        ball.x = 350;
        ball.y = 350;
    }

    function detectBlockCollide(ballCol){
        for(row in blocks){
            var i = 0;
            for(block in row){
                var blockCol = new h2d.col.Bounds();
                //trace(block.x, block.y);
                blockCol.set(block.x, block.y, 70, 30);
                if(ballCol.collideBounds(blockCol)){
                    
                    trace("HIT!");
                    block.clear();
                    row.remove(block);
                    return true;
                }
            }
        }
        return false;
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
        
        if(detectBlockCollide(ballCol)){
            ballydirection *= -1;
        }

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
                    resetBall();
                }
            } else {
                if(ball.y - 10 < 0){
                    ballydirection = 1;
                }
            }
        }
        ball.x += (8 * ballxdirection);
        ball.y += (8 * ballydirection);
        
    }

    static function main() {
        new Game();
    }
}
