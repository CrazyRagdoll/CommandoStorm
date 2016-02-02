package  {
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	
	//Class for the score items
	
	public class Item extends MovieClip {
		
		//variable to hold the amount of points the player will recieve
		private var _score:int;
		//A time limit to only allow the boxes to stay on the screen for the 
		private const _TIMELIMIT = 175; 
		private var _itemTimeLimit:int;
		
		//item constructor which takes in the position of the enemy that died and the score it will grant
		public function Item(xPos:Number, yPos:Number, score:int) {
			this.x = xPos;
			this.y = yPos;
			_score = score;
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
		
		//returns the score that the box will grant
		public function getScore():int {
			return _score;
		}
				
		//destroy function
		public function destroy():void {
			trace("destroying score item");
			this.parent.removeChild(this);
		}
		
	}
	
}
