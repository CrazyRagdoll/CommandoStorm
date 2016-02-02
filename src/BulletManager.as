package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;

	public class BulletManager extends MovieClip {
		private var _scoreBoard:ScoreBoard;
		private var _itemMgr:ItemManager;
		public var _damage:int = 100; //damage of the bullets
		
		// Bullet manager constructor
		public function BulletManager(scoreBoard:ScoreBoard, itemMgr:ItemManager) {
			//trace("Into BulletManager Constructor");
			_itemMgr = itemMgr;
			_scoreBoard = scoreBoard;
		}
		
		// create bullet function
		public function createBullet(x, y, xGo:int, yGo:int):void {
			//trace("into BulletManager createBullet");
			//Creates a new bullet that is from position x,y to position xGo, yGo
			var tmpBullet:Bullet = new Bullet(x, y, xGo, yGo);
			this.addChild(tmpBullet); //add the child
		}
		
		// move bullets function
		public function moveBullets():void {
			var tmpBullet:Bullet;
			var bulletNum:int;
			// tell each bullet to move
			for (bulletNum = 0; bulletNum < this.numChildren; bulletNum++) {
				tmpBullet = Bullet(this.getChildAt(bulletNum));
				tmpBullet.moveBullet(); 
			}
		}
		
		// Collision detection between the enemies and player bullets
		public function checkCollisions(enemyMgr:EnemyManager):void {
			var tmpBullet:Bullet;
			var tmpEnemy:Enemy;
			var tmpEnemy2:Enemy2;
			var enmScore;
			var bulletNum, enemyNum:int;
			// check each bullet..
			for (bulletNum = 0; bulletNum < this.numChildren; bulletNum++) {
				// ...against each enemy
				tmpBullet = Bullet(this.getChildAt(bulletNum));
				for (enemyNum = 0; enemyNum < enemyMgr.numChildren; enemyNum++) {
					// a check to see which enemy has been shot this is to allow for different scores for different enemies
					if(enemyMgr.getChildAt(enemyNum) is Enemy) 
					{
						tmpEnemy = Enemy(enemyMgr.getChildAt(enemyNum));
						if (tmpBullet.hitTestObject(tmpEnemy)) { // handle a collision
							tmpEnemy.reduceHealth(_damage); //reduce the health of the enemy
							tmpBullet.destroy(); //destroy the bullet
							//if the enemy dies award score.
							if(tmpEnemy.getHealth() <= 0)
							{
								if ( Math.random() * 100 > 85 ){
									_itemMgr.createHealthItem(tmpEnemy.x, tmpEnemy.y);
								}
								_scoreBoard.increaseScore(tmpEnemy._points); //award score
								break;//bullet destroyed, so stop collision checks
							}
						}
					}
					if(enemyMgr.getChildAt(enemyNum) is Enemy2)
					{
						tmpEnemy2 = Enemy2(enemyMgr.getChildAt(enemyNum));
						if (tmpBullet.hitTestObject(tmpEnemy2)) { // handle a collision
							tmpEnemy2.reduceHealth(_damage); //reduce the health of the enemy
							tmpBullet.destroy(); //destroy the bullet
							//if the enemy dies award score.
							if(tmpEnemy2.getHealth() <= 0)
							{
								if ( Math.random() * 100 > 80 ){
									_itemMgr.createScoreItem(tmpEnemy2.x, tmpEnemy2.y);
								}
								_scoreBoard.increaseScore(tmpEnemy2._points); //award score
								break;//bullet destroyed, so stop collision checks
							}
						}
					}
				}
			}
		}
			
		//destroy function
		public function destroy():void {
			//trace("Into BulletManager Destroy");
			this.parent.removeChild(this);
		}
		
	}

}