package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.ui.*;
	import flash.events.*;

	public class Player extends MovieClip {

		private var _itemMgr:ItemManager;
		
		//Movement Boolean variables.
		public var movingLeft:Boolean = false;
		public var movingRight:Boolean = false;
		public var jump, jumping:Boolean = false;
		public var playerPos:int; 
		public var _playerX:int;
		public var _playerY:int;
					
		//Movement variables to move the background
		public var movingBGLeft:Boolean = false;
		public var movingBGRight:Boolean = false;
		
		//Movement intergers variables to determind the speed & position of the player
		public var floorHeight:int = 15;
		public var speed:int = 10;
		public var jumpSpeedLimit:int = 15;
		public var jumpSpeed:Number = jumpSpeedLimit;

		//player constructor
		public function Player() {
			trace("Into Player Constructor");
			this.visible = false;
		}	

		//player initialization 
		public function init(itemMgr:ItemManager) {
			trace("Into Player init");
			_itemMgr = itemMgr;
			_playerX = this.x;
			_playerY = this.y;
			positionPlayer();
			this.visible = true;
			stage.addEventListener(Event.ENTER_FRAME, enterFrameEvHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);			
		}
		
		public function positionPlayer() {
			trace("positioning the player");
			playerPos = 0;
			this.visible = false;
			this.x = stage.stageWidth / 4;
			this.y = stage.stageHeight - this.height - floorHeight;
		}
		
		public function resetPlayer() {
			trace("into player reset");
			positionPlayer();
			stage.removeEventListener(Event.ENTER_FRAME, enterFrameEvHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
		}
		
		function checkKeysDown(event: KeyboardEvent): void {
			if (event.keyCode == 37 || event.keyCode == 65) {
				moveLeft();
			}
			if (event.keyCode == 38 || event.keyCode == 87) {
				moveUp();
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				moveRight();
			}
		}

		function checkKeysUp(event: KeyboardEvent): void {
			if (event.keyCode == 37 || event.keyCode == 65) {
				notMoveLeft();
			}
			if (event.keyCode == 38 || event.keyCode == 87) {
				notMoveUp();
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				notMoveRight();
			}
		}
		
		public function moveLeft() {
			movingLeft = true; }
		public function moveRight() {
			movingRight = true; }
		public function moveUp() {
			jump = true; }
		public function notMoveLeft() {
			movingLeft = false; }
		public function notMoveRight() {
			movingRight = false; }
		public function notMoveUp() {
			jump = false; }

		//the player movement function. This also handles the background movement 
		//to cause a scroll background effect.
		private function enterFrameEvHandler(event: Event): void {
			if (movingLeft && playerPos > -9) {
				this.rotationY = 180;
				if ((this.x - this.width) > 30) {
					this.x -= speed;
				}else {
					movingBGRight = true;
					_itemMgr.moveItemsRight();
				}
				playerPos -= 1;
				_playerX -= 1;
			}
			if (movingRight) {
				this.rotationY = 0;
				if ((this.x - this.width) < 260) {
					this.x += speed;
				} else {
					movingBGLeft = true;
					_itemMgr.moveItemsLeft();
				}
				playerPos += 1;
				_playerX += 1;
			}
			//trace(playerPos);
			if (jump || jumping) {
				Jump();
			}
		}

		//player jump function causes the player to jump up until a point, thhen fall.
		private function Jump(): void {
			if (!jumping) {
				jumping = true;
				jumpSpeed = jumpSpeedLimit * -1;
				this.y += jumpSpeed;
			} else {
				if (jumpSpeed < 0) {
					jumpSpeed *= 1 - jumpSpeedLimit / 75;
					if (jumpSpeed > -jumpSpeedLimit / 5) {
						jumpSpeed *= -1;
					}
				}
				if (jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit) {
					jumpSpeed *= 1 + jumpSpeedLimit / 50;
				}
				this.y += jumpSpeed;
				if (this.y >= stage.stageHeight - this.height - floorHeight) {
					jumping = false;
					this.y = stage.stageHeight - this.height - floorHeight;
				}
			}
		}

	}

}