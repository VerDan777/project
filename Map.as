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
	
	public class Map extends Sprite 
	{
		
		[Embed (source = 'gfx/planet_1.png')] static public var planet1_png:Class;
		[Embed (source = 'gfx/planet_2.png')] static public var planet2_png:Class;
		[Embed (source = 'gfx/planet_3.png')] static public var planet3_png:Class;
		[Embed (source = 'gfx/planet_4.png')] static public var planet4_png:Class;
		[Embed (source = 'gfx/planet_5.png')] static public var planet5_png:Class;
		[Embed (source = 'gfx/planet_6.png')] static public var planet6_png:Class;
		[Embed (source = 'gfx/planet_7.png')] static public var planet7_png:Class;
		[Embed (source = 'gfx/planet_8.png')] static public var planet8_png:Class;
		[Embed (source = 'gfx/planet_9.png')] static public var planet9_png:Class;
		
		static public var planets_alist:Array = [planet1_png, planet2_png, planet3_png, 
		planet4_png, planet5_png, planet6_png, planet7_png, planet8_png, planet9_png];
		
		
		
		public function Map():void 
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
		
		static var levels:Array = [];
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			levels.push({id:0, bg:1, bosses:[{x:3000, y:300}], asteroids:true, ships:false, ico:{id:0, x:80, y:80}})   //1 level
			levels.push( {id:1, bg:2, bosses:[], asteroids:false, ships:true, ico: { id:1, x:220, y:80 }} ) //2 level
			levels.push( {id:2, bg:3, bosses:[], asteroids:false, ships:true, ico: { id:2, x:420, y:80 }} ) //3 level
			
			

			addChild(menuScr)
			 
			
			var play_bt:CButton = new CButton(100, 100, "continue") 
			menuScr.addChild (play_bt)
			play_bt.x = 60;
			play_bt.y = 480;
			
			
			play_bt.addEventListener(MouseEvent.CLICK, function(evt) {
				Main.show_game();
			})
			
			
			
			function addTxt(mc, tx, ty, txt, size, color) {
				var dtxt: TextField = new TextField();
				dtxt.selectable = false
						dtxt.text = txt
						dtxt.y = ty;
						dtxt.x = tx;
						mc.addChild(dtxt)
						dtxt.textColor = color
						dtxt.width=800
						var tf: TextFormat = new TextFormat()
						tf.size = size;
						dtxt.setTextFormat(tf)
		}
			
			
			var play_bt:CButton = new CButton(100, 100, "Back") 
			menuScr.addChild (play_bt)
			play_bt.x = 740;
			play_bt.y = 480;
			
			menuScr.graphics.lineStyle(10, 0)
			var i = 0;
			for each (var lvl in levels) {
				
				var mc:CPlanet = new CPlanet();
				mc.id = lvl.id;

				
				
				addChild(mc);
				var ico = lvl.ico;
				mc.scaleX = 0.3;
				mc.scaleY = 0.3;
				
				mc.x = ico.x;
				mc.y = ico.y;
				
				mc.addHint(ico.id)
				mc.addEventListener(MouseEvent.CLICK,function(e:MouseEvent){Main.show_game(e.currentTarget.id)})
				
				if(i==0){
					menuScr.graphics.moveTo(mc.x, mc.y);
				}else{
					menuScr.graphics.lineTo(mc.x, mc.y);
				}
				
				var art = new planets_alist[ico.id]();
				art.x = -art.width / 2;
				art.y = -art.height / 2;
				mc.addChild(art)
				
				
				
				addTxt(mc, -10, -40, (ico.id + 1), 72, 0xFF9900)
				i++
			}
			
		}
		
	}
	
}