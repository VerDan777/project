package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import badim.CHint;
	//
	dynamic public class CProtoHint extends MovieClip {
		private var hint_txt:String;
		private function hintMouseHandler(evt){
			CHint.show(hint_txt);
		}
		public function showHint(txt:String){
			CHint.show(txt);
		}
		public function revokeHint(){
			if(hint_txt==null){
				removeEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
				return true;
			}
			removeEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
			addEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
		}
		public function removeHint(){
			removeEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
		}
		public function addHint(txt:String){
			if(txt==null){
				removeEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
				return true;
			}
			hint_txt=txt;
			removeEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
			addEventListener(MouseEvent.MOUSE_OVER,hintMouseHandler);
		}
	}
}