package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;

	public class Enemy extends MovieClip {

		private var _dX:int;// X speed of the Enemy in pixels
		public var _points:int = 10; //how many points this enemy is worth for killing 
		private var _damage:Number = 20; //the damage this enemy will do to the player
		private var _health:Number = 100; //the health of this enemy
		public var _hitCounter:Boolean = false; //if this enemy has already hit the player or not
		
		//Enemy constructor
		public function Enemy () {
			trace("Into Enemy Constructor");
		}
		
		//enemy initializtion used to modify the damamge & health of the enemy.
		//Also gives the neemy a position on the screen and a random speed.
		public function init (xPos:int, yPos:int, str:Number, theStage:Stage):void {
			this.x = xPos;
			this.y = yPos;
			_damage *= str;
			_health *= str;
			_dX = Math.random() * 5 + 4; //Speed
		}
		
		//Simple movement for the enemy
		public function moveEnemy():void {
			this.x -= _dX;
			if ( this.x <= -60 )
			{
				destroy();
			}
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