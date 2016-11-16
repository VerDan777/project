package 
{
 import flash.display.Sprite;
 import flash.events.Event;
 import flash.display.Graphics;
 import flash.events.MouseEvent;
 import flash.text.TextField;
 import flash.filters.GlowFilter;
import flash.filters.DropShadowFilter;

 public class CPlanet extends CProtoHint{
	 private var button:Sprite;
	 private var w:int, h:int
	 public var act:Function;
	 public var id;
	 
	 public function CPlanet(){

		 addEventListener(MouseEvent.CLICK, buttonClickHandler);
		 addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
		 addEventListener(MouseEvent.ROLL_OUT, buttonRollOutHandler);
	
	 }
	 
	 private function buttonClickHandler(event:MouseEvent):void{
	
		 if (act) {
			act();
		 }
	 }
	 
	 private function buttonRollOverHandler(event:MouseEvent):void{
		
	 }
	 
	 private function buttonRollOutHandler(event:MouseEvent):void{
		
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
