package 
{
	import fl.transitions.easing.*;
	import fl.transitions.*;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Ифв
	 */
	public class fpsCounter extends Sprite 
	{
		var dtxt:TextField = new TextField();
		var dtime:int = 0
		var frames:int=0
		public function fpsCounter():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	
		private function init(e:Event = null):void 
		{
				addEventListener(Event.ENTER_FRAME, turn);
				addChild(dtxt)
		}
		function turn(evt) {
			if (getTimer() - dtime > 1000) {
				dtxt.text = frames.toString();
				frames = 0
				dtime = getTimer()
			}
			frames++;
			
		}
				
	
	
	}
	
}
	