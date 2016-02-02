package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.ui.*;
	import flash.events.*;

	public class ScoreBoard extends MovieClip {
		
		private var _score:Number;// Current score
		public var _health:int = 100; //Player health
		
		//Scoreboard constructor
		public function ScoreBoard() {
			trace("Into ScoreBoard Constructor");
			resetScoreBoard();
		}
		
		//Scoreboard initialization
		public function init() {
			trace("Into ScoreBoard Init");
			//giving the visual text fields their values
			_score = 0; this.score_txt.text = String(_score);
			_health = 100; this.health_txt.text = String(_health);
			//displaying them by making them visible
			this.visible = true;
			this.score_title.visible = true;
			this.time_title.visible = true;
			this.health_title.visible = true;
		}
		
		//a function to reduce the health of the player and update the health text field
		public function reduceHealth(dam:int) {
			_health -= dam;
			this.health_txt.text = String(_health);
		}
		
		//a function to increase and update the player's score.
		public function increaseScore(scoreInc:int) {
			trace("Into increaseScore");
			_score += scoreInc;
			this.score_txt.text = String(_score);
		}
		
		//a function to increase and update the player's health.
		public function increaseHealth(healthInc:int) {
			trace("Into increaseHealth");
			_health += healthInc;
			this.health_txt.text = String(_health);
		}
		
		//returns the player's score.
		public function getScore():int {
			return _score;
		}
		
		//returns the player's health
		public function getHealth():int {
			return _health;
		}
		
		//resets the score board by making it all invisible
		public function resetScoreBoard() {
			trace("Into ScoreBoard reset");
			this.visible = false;
			this.health_title.visible = false;
			this.score_title.visible = false;
			this.time_title.visible = false;
		}
		
		//timer text.
		public function set timeText(text_str:String):void {
			this.time_txt.text = text_str;
		} 		

	}

}