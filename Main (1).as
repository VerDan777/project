package 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	/**
	 * ...
	 * @author MadNigga 
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init()
			else addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		//global
		static var scr:Array = [];
		static var _main;
		
		
		
		//var fps_mc = new fpsCounter()
		var menuScr:MovieClip=new MovieClip()
		//var restart:CButton=new CButton(100,50)//---------
		var circle = new MovieClip();
		var lifes = 9;//жизни
		var circle_r = 50;
		var level=1
		var fruits:Array = [];
		var enemies:Array = [];
		var pause_but:CButton = new CButton(100, 60)//пауза
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			CHint.register(this);
			new CFilters()
			
			
			_main = this;
			show_menu()
			//ini_lvls()
		}
		static public function show_game(lvl = 1) {
			trace("lvl:",lvl);
		
			var mc:Game = new Game(lvl);
			
			hide_all()
			_main.addChild(mc)
			scr.push(mc)
			new Tween(mc,"x",None.easeIn,800,0,20)
		}
	    static public function show_menu()   {
			var mc = new Menu()
			hide_all()
			_main.addChild(mc)
			scr.push(mc)
			new Tween(mc,"x",None.easeIn,800,0,20)
		}
		static public function show_map()   {
			var mc = new Map()
			hide_all()
			_main.addChild(mc)
			scr.push(mc)
			new Tween(mc, "x", None.easeIn, 800, 0, 20)
		}
		
		/*
		static public function showe_map()   {
			var mc = new Map()
			hide_all()
			_main.addChild(mc)
			scr.push(mc)
			new Tween(mc, "x", None.easeIn, 800, 0, 20)
		 }
		 
		 
		 static public function show_nastr()   {
			var mc = new Nastr()
			hide_all()
			_main.addChild(mc)
			scr.push(mc)
			new Tween(mc, "x", None.easeIn, 800, 0, 20)
		 }
		 
		 function ini_lvls() {
			var lvl_str:String = String(new maps_txt);
			levels = lvl_str.split("---");
	    }
		*/
		
		static public function hide_all() {
			for (var i in scr) {
				var item = scr[i];
				var tw =	new Tween(item,"x",None.easeIn,0,-800,20)
				tw.addEventListener(TweenEvent.MOTION_FINISH,function(e){if(_main.contains(item))_main.removeChild(item)})
			}
		}
	}
}