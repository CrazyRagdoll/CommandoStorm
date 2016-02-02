package  {
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	
	//Class for the health creates
	
	public class healthCrate extends MovieClip {
		
		//Variable to hold how much health will be restored
		private var _health:int;
		//A time limit to only allow the boxes to stay on the screen for the 
		private const _TIMELIMIT = 175; 
		private var _itemTimeLimit:int;		
		
		//healthCrate constructor which takes in the position of the enemy that died and the health it will restore
		public function healthCrate(xPos:Number, yPos:Number, health:int) {
			this.x = xPos;
			this.y = yPos;
			_health = health;
		}
		
		//A move function to make the boxes fall to the floor. Also increments the timer
		public function moveItem() {
			//stops the box from falling through the floor
			if (this.y < 270)
			{
				this.y += 3;
			}
			_itemTimeLimit++
			if (_itemTimeLimit >= _TIMELIMIT)
			{
				//destroy the item when its time limit is up
				destroy();
			}
		}		
		
		//Movement functions
		public function moveLeft(){
			this.x -= 5;
		}
		
		public function moveRight(){
			this.x += 5;
		}
		
		//returns the health that will be restored 
		public function getHealth():int {
			return _health;
		}		
		
		//destroy function
		public function destroy():void {
			trace("destroying health item");
			this.parent.removeChild(this);
		}
		
	}
	
}
