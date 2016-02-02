package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;

	public class eBullet extends MovieClip {
		private var _dx:int;//distance between where the bullet spawns and where it was shot too
		private var _dy:int;
		private var SPEED:Number = 12;
		private var _offTopOfStage_px:int = 0; //size of the stage
		private var _offBottomOfStage_px:int = 320;
		private var _offLeftOfStage_px:int = 0;
		private var _offRightOfStage_px:int = 640;

		//bullet constructor
		public function eBullet(xPos:int, yPos:int, xGo:int, yGo:int) {
			//trace("Into Bullet Constructor");
			// Giving the bullet its position on the screen
			this.x = xPos;
			this.y = yPos;
			_dx = xGo - this.x; // Working out the distance between the player
			_dy = yGo - this.y; // and where the mouse was clicked 
		}
		
		//move bullets function - WARNING - involves horrible trig to get the bullets to face the right way.
		public function moveBullet():void {
			var ang:Number = Math.atan(_dy/_dx); // the tangent of the x distance and y distance between the bullet and player
			var degAng:Number = ang*(180/3.14);  // the angle in degrees
			// The algorithmn used to move the bullet in the right direction and flip the spirt to look face the right way
			if((_dx < 0 && _dy < 0) || (_dx < 0 && _dy > 0)){
				this.x -= SPEED * Math.cos(ang);	// if statement to seperate the screen into different quadrents.
				this.y -= SPEED * Math.sin(ang);	// using trig to determind the speed at which the bullets should move
				this.rotationZ = degAng+180;		// up and across.
			} else {
				this.x += SPEED * Math.cos(ang);	// using more trig to workout the rotation of the bullets so they
				this.y += SPEED * Math.sin(ang);	// are facing the right way
				this.rotationZ = degAng;
			}
			if (this.y < _offTopOfStage_px || this.y > _offBottomOfStage_px || this.x < _offLeftOfStage_px || this.x > _offRightOfStage_px) {
				this.destroy();
			}
		}
		
		//bullet destroy function
		public function destroy():void {
			//trace("Into Bullet Destroy");
			this.parent.removeChild(this);
		}
		
	}

}