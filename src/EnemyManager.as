package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;

	public class EnemyManager extends MovieClip {	
		
		private var _scoreBoard:ScoreBoard;
		private const _ENEMYFREQUENCY = 2000; //how frequent the enemies will spawn
		private var _makeEnemiesTimer:Timer = new Timer(_ENEMYFREQUENCY);
		private var _str:Number; //the strength of the enemies
			
		//enemy manager constructor
		public function EnemyManager(scoreBoard:ScoreBoard, str:Number) {
			trace("Into EnemyManager Constructor");
			_scoreBoard = scoreBoard;
			// a timer to create the enemies
			_makeEnemiesTimer.addEventListener(TimerEvent.TIMER, timerEvHandler);
			// Setting the strength of the enemies, (Changed by difficulty)
			_str = str;
			// Start the timer
			_makeEnemiesTimer.start();
		}
		
		// enemy manager move enemies function to loop through all of the enemies and move them
		public function moveEnemies():void {
			var tmpEnemy:Enemy;
			var tmpEnemy2:Enemy2;
			// Work through each  child enemy player
			for (var i = 0; i < this.numChildren; i++) {
				// having to seperate the types of enemies for different movement patterns
				if(this.getChildAt(i) is Enemy)
				{
					tmpEnemy = Enemy(this.getChildAt(i));
					tmpEnemy.moveEnemy();
				}
				// having to seperate the types of enemies for different movement patterns
				if(this.getChildAt(i) is Enemy2)
				{
					tmpEnemy2 = Enemy2(this.getChildAt(i));
					tmpEnemy2.moveEnemy();
				}
			}
		}
		
		// the timer used to create the enemies
		private function timerEvHandler(ev:TimerEvent):void {
			var sx:int = Math.random() * 150 + 400;
			createEnemy(sx, 230, _str);
			createEnemy2(sx, 90, _str);
		}
		
		// This function is creating the ground enemies - aliens
		private function createEnemy(xPos:int, yPos:int, str:Number):void {
			var tmpEnemy:Enemy = new Enemy();
			tmpEnemy.init(xPos, yPos, str, stage);
			this.addChild(tmpEnemy);
		}
		
		// This function is creating the flying enemies - space ships
		private function createEnemy2(xPos:int, yPos:int, str:Number):void {
			var tmpEnemy:Enemy2 = new Enemy2();
			tmpEnemy.init(xPos, yPos, str, stage);
			this.addChild(tmpEnemy);
		}
		
		//Collision detection between the enemies and player		
		public function checkCollisions(player:Player):Boolean {
			var collision_bool:Boolean = false;
			var hitCounter:Boolean = false;
			var tmpEnemy:Enemy;
			for (var i = 0; ((i < this.numChildren)&&(!collision_bool)); i++) {
				if(this.getChildAt(i) is Enemy)
				{
					tmpEnemy = Enemy(this.getChildAt(i));
					collision_bool = (player.hitTestObject(tmpEnemy));
					if (collision_bool && !tmpEnemy._hitCounter) {
						tmpEnemy.hitPlayer(collision_bool);
						_scoreBoard.reduceHealth(damagePlayer(tmpEnemy));
						return collision_bool;
					}
				}
			}
			return false;
		}		
		
		//a function to return the amount of damage the enemy will cause
		public function damagePlayer(tmpEnemy:Enemy):int {
			return tmpEnemy.damagePlayer();
		}
		
		//returns if this enemy has already hit the player
		public function getHitCounter():Boolean {
			var tmpEnemy:Enemy;
			return tmpEnemy._hitCounter;
		}
		
		// destroy the enemy
		public function destroy():void {
			trace("Into EnemyManager Destroy");
			_makeEnemiesTimer.stop();
			this.parent.removeChild(this);
		}

	}

}