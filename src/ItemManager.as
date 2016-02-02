package  {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.media.H264Level;
	
	//A class that manages all of the items that can be picked up
	
	public class ItemManager extends MovieClip {

		//Uses the scoreboard class to increase the player's score and health
		private var _scoreBoard:ScoreBoard;
		//Values to increase by
		private var _score:int = 25;
		private var _health:int = 10;
		
		//includes the scoreboard to access its functions
		public function ItemManager(scoreBoard:ScoreBoard) {
			_scoreBoard = scoreBoard;
		}
		
		//create score item function
		public function createScoreItem(enX:Number, enY:Number) {
			var tmpItem:Item = new Item(enX, enY, _score);
			this.addChild(tmpItem);
		}
		
		//create health item function
		public function createHealthItem(enX:Number, enY:Number) {
			var tmpItem:healthCrate = new healthCrate(enX, enY, _health);
			this.addChild(tmpItem);
		}
		
		// move all the items function
		public function moveItems() {
			var tmpItem:Item;
			var tmpItem2:healthCrate;
			for (var itemNum:int = 0; itemNum < this.numChildren; itemNum++)
			{
				if(this.getChildAt(itemNum) is Item) {
					tmpItem = Item(this.getChildAt(itemNum));
					tmpItem.moveItem();
				}
				if(this.getChildAt(itemNum) is healthCrate) {
					tmpItem2 = healthCrate(this.getChildAt(itemNum));
					tmpItem2.moveItem();
				}
			}
		}
		
		//A function to move the items to the left with the background
		public function moveItemsLeft() {
			var tmpItem:Item;
			var tmpItem2:healthCrate;
			for (var itemNum:int = 0; itemNum < this.numChildren; itemNum++)
			{
				if(this.getChildAt(itemNum) is Item) {
					tmpItem = Item(this.getChildAt(itemNum));
					tmpItem.moveLeft();
				}
				if(this.getChildAt(itemNum) is healthCrate) {
					tmpItem2 = healthCrate(this.getChildAt(itemNum));
					tmpItem2.moveLeft();
				}
			}
		}
		
		//A function to move the items to the right with the background
		public function moveItemsRight() {
			var tmpItem:Item;
			var tmpItem2:healthCrate;
			for (var itemNum:int = 0; itemNum < this.numChildren; itemNum++)
			{
				if(this.getChildAt(itemNum) is Item) {
					tmpItem = Item(this.getChildAt(itemNum));
					tmpItem.moveRight();
				}
				if(this.getChildAt(itemNum) is healthCrate) {
					tmpItem2 = healthCrate(this.getChildAt(itemNum));
					tmpItem2.moveRight();
				}
			}
		}
		
		//Collision destections function to test the player against the items
		public function checkCollisions(player:Player):void {
			var tmpItem:Item;
			var tmpItem2:healthCrate;
			for (var itemNum:int = 0; itemNum < this.numChildren; itemNum++)
			{
				if(this.getChildAt(itemNum) is Item) 
				{
					tmpItem = Item(this.getChildAt(itemNum));
					if(tmpItem.hitTestObject(player)){
						trace("Player hit score crate");
						_scoreBoard.increaseScore(tmpItem.getScore()); //award score
						tmpItem.destroy();
					}
				} else if(this.getChildAt(itemNum) is healthCrate)
				{
					tmpItem2 = healthCrate(this.getChildAt(itemNum));
					if(tmpItem2.hitTestObject(player)){
						trace("Player hit health crate");
						_scoreBoard.increaseHealth(tmpItem2.getHealth()); //award score
						tmpItem2.destroy();
					}
				}
			}
		}
		
		//destroy function
		public function destroy():void {
			this.parent.removeChild(this);
		}

	}
	
}
