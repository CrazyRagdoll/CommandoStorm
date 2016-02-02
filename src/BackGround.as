package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;

	public class BackGround extends MovieClip {	
	
		private const GAMEWIDTH:int = 2560;// Length of Background
		public var scrollSpeed:int = 10; // scroll speed of the background
	
		//background constructor 
		public function BackGround() {
			trace("Into BackGround Constructor");
		}
		
		//background initalization
		public function init():void {
			trace("Into Background init");
			this.visible = true;
			this.resetPosition();
		}
		
		//resets the background to its starting position
		public function resetPosition():void {
			trace("Into Background reset");
			this.x = 0;
		}
		
		//scrolls the background to the left depending on where the player is
		public function scrollLeft() {
			if (this.x <= -2560)
			{
				this.x = -7;
			} else {
				this.x -= scrollSpeed;
			}
		}
		
		//scrolls the background to the right depending on where the player is
		public function scrollRight() {
			if (this.x > 0)
			{
				this.x = -2545;
			} else {
				this.x += scrollSpeed;
			}
		}
				
	}

}