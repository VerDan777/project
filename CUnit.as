package {
	import flash.display.MovieClip
	
	public class CUnit extends  MovieClip { 
		public var hp, hp_max, laser_max, gid:int, laser, power, speed, reload_max; 
		public var dead:Boolean = false;
		public var sleep_d,v,tx,by,bx,ldx,ldy,moving,ttd;
		public var vx, vy, va
		public var weapon_id, bullet
		public var body;
		public var boss;
		public var gun:Object
		public var gun_id
		public var kills = 0;
		public var utype:String="ship"
		
		var hp_w = 60;
		var hp_bar:MovieClip = new MovieClip();
		public function hprefresh() {
			addChild(hp_bar);
			hp_bar.graphics.clear()
			hp_bar.graphics.lineStyle(6, 0);
			hp_bar.graphics.moveTo( -hp_w / 2, -30)
			hp_bar.graphics.lineTo(hp_w / 2, -30)
			var p = hp / hp_max;
			hp_bar.graphics.lineStyle(4, 0xff0000)
			hp_bar.graphics.moveTo( -hp_w / 2, -30)
			hp_bar.graphics.lineTo(-hp_w/2+p*hp_w,-30)
		
		}
		

	}
}