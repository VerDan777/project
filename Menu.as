package 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.filters.GlowFilter;
	
	//написать список исправлений и новвоведений, сделать ссылку на сайт с кнопки инфо
	
	public class Menu extends Sprite 
	{[Embed (source = 'gfx/space_1.png')] static public var menu_png:Class;
		
	
		
		
		
		public function Menu():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		var circle:MovieClip 
		var glow:GlowFilter=new GlowFilter(0x00FFFF, 1, 8, 8)
		var level = 1;
		var lifes = 5;
		var pause_mc:CButton = new CButton(100,30);
		var circle_r = 100;
		var fruit_r = 20;
		var menuScr:MovieClip=new MovieClip ()
		var fruits:Array = []
		var enemies:Array = []
		var hana = new MovieClip()
		var darkpause:MovieClip  = new MovieClip()
		var dtxt:TextField = new TextField();
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
		
			
			var play_bt:CButton = new CButton(100, 100, "play") 
			menuScr.addChild (play_bt)
			play_bt.x = 400;
			play_bt.y = 300;
			addChild(menuScr)
			
			play_bt.addEventListener(MouseEvent.CLICK, function(evt) {
				Main.show_map();
			})
			
			
		
			var play_bt:CButton = new CButton(100, 100, "Scores") 
			menuScr.addChild (play_bt)
			play_bt.x = 60;
			play_bt.y = 480;

			
			
			var play_bt:CButton = new CButton(100, 100, "Info") 
			menuScr.addChild (play_bt)
			play_bt.x = 740;
			play_bt.y = 480;

			

	
			
		}
		
	}
	
}