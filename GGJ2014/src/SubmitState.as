package
{
	import flash.events.Event;
	import flash.net.*;
	import com.adobe.serialization.json.*;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.flixel.*;
	
	public class SubmitState extends FlxState
	{
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/highscores.php";
		private var _score:int = Score.score;
		private var _highscorelist:Array;
		
		private var _scoreText:FlxText;
		
		private var _text:FlxText;
		private var _input:FlxInputText;
		
		public function SubmitState()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			_text = new FlxText(0, 0, FlxG.width, "Enter your name:");
			_text.y = 220;
			_text.scrollFactor.make(0,0);
			_text.setFormat("AldotheApache", 40, 0xffffff);
			_text.alignment = "center";
			
			_scoreText = new FlxText(0, 0, 300, "Your score: " + Score.score);
			_scoreText.setFormat("AldotheApache", 40);
			_scoreText.alignment = "center";
			_scoreText.x = (FlxG.width/2) - _scoreText.width / 2;
			_scoreText.y = 50;
			
			_input = new FlxInputText(0, 300, "", FlxG.width);
			_input.alignment = "center";
			_input.size = 30;
			_input.text = "Your name bitte";
			_input.text = "";
			_input.hasFocus = true;
			
			add(_scoreText);
			add(_text);
			add(_input);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER"))
			{
				submit();
			}
		}
		
		private function submit():void
		{
			var myRequest:URLRequest = new URLRequest(website);
			myRequest.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			variables.name = _input.text;
			variables.score = _score;
			myRequest.data = variables;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, submitComplete);
			loader.load(myRequest);
		}
		
		private function submitComplete(e:Event):void
		{
			FlxG.switchState(new HighscoreState());
		}
	}
}