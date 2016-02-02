package  {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.ui.*;
	import flash.events.*;
	import flash.net.SharedObject;
	
	// my highscore class which holds 3 top scores!
	// couldnt implement the names :(
	
	public class HighScores extends MovieClip{
		
		var mySharedObject:SharedObject = SharedObject.getLocal("highscores");
		
		//retreiving the top scores from the shared object data
		var _highScore1:int = mySharedObject.data.score1;
		var _highScore2:int = mySharedObject.data.score2;
		var _highScore3:int = mySharedObject.data.score3;
		
		// fills the text fields with the current highscores 
		public function HighScores() {
			highScores_txt.text = String(_highScore1);
			highScores2_txt.text = String(_highScore2);
			highScores3_txt.text = String(_highScore3);
		}
			
		//makes all of the text fields visible
		public function showHighScores() {
			this.highScores_txt.visible = true;
			this.highScores2_txt.visible = true;
			this.highScores3_txt.visible = true;
		}
		
		//makes all of the text fields invisible
		public function hideHighScores() {
			this.highScores_txt.visible = false;
			this.highScores2_txt.visible = false;
			this.highScores3_txt.visible = false;
		}
		
		//compares the current player's score with the lowest high score
		public function compareHighScore(score:int):Boolean {
			if ( score >= _highScore3 ) { 
				return true;
			} else {
				return false;
			}
		}
		
		//will bubble sort the highscores with the new highscore.
		public function updateHighScore(score:int) {
			var tmpScore:int;
			_highScore3 = score;
			if ( _highScore3 >= _highScore2 )
			{
				tmpScore = _highScore3;
				_highScore3 = _highScore2;
				_highScore2 = tmpScore;
			}
			if ( _highScore2 >= _highScore1 )
			{
				tmpScore = _highScore2;
				_highScore2 = _highScore1;
				_highScore1 = tmpScore;
			}
			//update the shared object scores.
			mySharedObject.data.score1 = _highScore1;
			mySharedObject.data.score2 = _highScore2;
			mySharedObject.data.score3 = _highScore3;
			mySharedObject.flush();
			highScores_txt.text = String(_highScore1);
			highScores2_txt.text = String(_highScore2);
			highScores3_txt.text = String(_highScore3);
		}
				
	}
	
}
