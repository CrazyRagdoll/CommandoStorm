package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;

	/*
		------------------------------------- ENEMY BULLET CLASS ---------------------------------------
	*/
	
	public class eBulletManager extends MovieClip {
		private var _scoreBoard:ScoreBoard;
	
		public var _damage:int = 10; //bullet damage
		
		// Bullet manager constructor
		public function eBulletManager(scoreBoard:ScoreBoard) {
			//trace("Into enemy BulletManager Constructor");
			_scoreBoard = scoreBoard;
		}
		
		// create bullet function
		public function createBullet(xGo:int, yGo:int, enemyMgr:EnemyManager):void {
			//trace("into enemy BulletManager createBullet");
			var tmpEnemy:Enemy2;
			var enemyNum:int;
			for (enemyNum = 0; enemyNum < enemyMgr.numChildren; enemyNum++) {
				if(enemyMgr.getChildAt(enemyNum) is Enemy2)
				{
					var tmpBullet:eBullet = new eBullet(enemyMgr.getChildAt(enemyNum).x, enemyMgr.getChildAt(enemyNum).y, xGo, yGo);
					this.addChild(tmpBullet);
				}
			}
		}
		
		// move bullets function
		public function moveBullets():void {
			var collision_bool:Boolean = false;
			var tmpBullet:eBullet;
			var bulletNum:int;
			// tell each bullet to move
			for (bulletNum = 0; bulletNum < this.numChildren; bulletNum++) {
				tmpBullet = eBullet(this.getChildAt(bulletNum));
				tmpBullet.moveBullet();
			}
		}
		
		// Collision detection between the enemies bullets and the player
		public function checkCollisions(player:Player):Boolean {
			var collision_bool:Boolean = false;
			var tmpBullet:eBullet;
			var bulletNum:int;
			for (bulletNum = 0; bulletNum < this.numChildren; bulletNum++) {
				tmpBullet = eBullet(this.getChildAt(bulletNum));;
				collision_bool = (player.hitTestObject(tmpBullet));
				if (collision_bool) {
					_scoreBoard.reduceHealth(_damage);
					tmpBullet.destroy();
					return collision_bool;
				}
			}
			return false;
		}	
			
		//enemy bullet destruction function
		public function destroy():void {
			//trace("Into BulletManager Destroy");
			this.parent.removeChild(this);
		}
		
	}

}