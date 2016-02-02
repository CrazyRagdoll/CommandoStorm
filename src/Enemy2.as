package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
		import flash.utils.*;
		import flash.sampler.Sample;

	//This class is for the flying enemies - the space ships
	
	public class Enemy2 extends MovieClip {


		private var _dX:int = 10;// X speed of the Enemy in pixels
		public var _points:int = 10; // points awarded for killing this enemy
		private var _damage:Number = 10; // the damage this enemy will cause if it hit the player
		private var _health:Number = 50; // the health of this enemy
		public var _hitCounter:Boolean = false; // if this enemy has already hit the player or not
		
		//Enemy contrusctor
		public function Enemy2 () {
			trace("Into Enemy Constructor");
		}
		
		//enemy initializtion used to modify the damamge & health of the enemy.
		//Also gives the neemy a position on the screen and a random speed.
		public function init (xPos:int, yPos:int, str:Number, theStage:Stage):void {
			this.x = xPos;
			this.y = yPos;
			_damage *= str;
			_health *= str;
			_dX *= str;
		}
		
		//Simple movement for the enemy
		public function moveEnemy():void {
			//trace("Into Enemy moveEnemy");
			if( this.x < 80 )
			{
				_dX *= -1;
			} else if( this.x > 560) 
			{
				_dX *= -1;
			}
			this.x += _dX;
		}
		
		//returns the damage that the enemy will inflict
		public function damagePlayer():int {
			return _damage;
		}
		
		//A function to return a boolean to check if the player has already been hit by this particular enemy
		public function hitPlayer(hit):Boolean {
			return _hitCounter = hit;
		}
		
		//A function to damage the health of the enemy
		public function reduceHealth(dmg:Number) {
			_health -= dmg;
			if(_health <= 0)
			{
				destroy();
			}
		}
		
		//A function to get the current health of the enemy
		public function getHealth():Number {
			return _health;
		}
		
		//Destroys the enemy.
		public function destroy():void {
			trace("Into Enemy Destroy");
			this.parent.removeChild(this);
		}
		
	}

}