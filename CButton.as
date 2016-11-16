package 
{
 import flash.display.Sprite;
 import flash.events.Event;
 import flash.display.Graphics;
 import flash.events.MouseEvent;
 import flash.text.TextField;
 import flash.filters.GlowFilter;
import flash.filters.DropShadowFilter;

 public class CButton extends Sprite{
	 private var button:Sprite;
	 private var w:int, h:int
	 public var act:Function;
	 public function CButton(_w:int, _h:int, _txt:String = "", _act:Function = null){
		 //Create a new instance of a Sprite to act as the button graphic.
		 button = new Sprite();
		 w = _w;
		 h = _h;
		 //Set the color of the button graphic
		 button.graphics.beginFill(0xFFCC00);
		 
		 var glow:GlowFilter = new GlowFilter(0x00ff00, 1, 8, 8)
		 var drop = new DropShadowFilter(10)
		filters=[glow, drop];
		 
		 //Set the X,Y, Width, and Height of the button graphic
		 button.graphics.drawRect(-w/2, -h/2, w, h);
		 
		 //Apply the fill
		 button.graphics.endFill();
		 
		 //Add useHandCursor, buttonMode, and mouseChildren if required
		 useHandCursor = true;
		 //button.buttonMode = true;
		 button.mouseChildren = false;
		 
		 addEventListener(MouseEvent.CLICK, buttonClickHandler);
		 addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
		 addEventListener(MouseEvent.ROLL_OUT, buttonRollOutHandler);
		 
		 //Add Button Sprite to stage
		 this.addChild(button);
		 
		 var tf:TextField = new TextField();
		 tf.width = w;
		 tf.height = h;
		 tf.selectable = false;
		 tf.text = _txt;
		 tf.x = -tf.textWidth /2;
		 tf.y = -tf.textHeight /2
		 addChild(tf)
	 }
	 
	 private function buttonClickHandler(event:MouseEvent):void{
		 trace("Button clicked!");
		 turnButtonGreen();
		 if (act) {
			act();
		 }
	 }
	 
	 private function buttonRollOverHandler(event:MouseEvent):void{
		 trace("Button roll over!");
		 turnButtonRed();
	 }
	 
	 private function buttonRollOutHandler(event:MouseEvent):void{
		 trace("Button roll out!");
		 turnButtonYellow();
	 }
	 
	 private function turnButtonRed():void{
		 button.graphics.clear();
		 button.graphics.beginFill(0xFF0000);
		 button.graphics.drawRect(-w/2, -h/2, w, h);
		 button.graphics.endFill();
	 }
	 
	 private function turnButtonYellow():void{
		 button.graphics.clear();
		 button.graphics.beginFill(0xFFCC00);
		 button.graphics.drawRect(-w/2, -h/2, w, h);
		 button.graphics.endFill();
	 }
	 
	 private function turnButtonGreen():void{
		 button.graphics.clear();
		 button.graphics.beginFill(0x008000);
		 button.graphics.drawRect(-w/2, -h/2, w, h);
		 button.graphics.endFill();
	 }
 }
}
