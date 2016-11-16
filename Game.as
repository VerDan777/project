package 
{//Размер уровня
//положение босса
//40s-100s
	import fl.transitions.Tween;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mx.core.ButtonAsset;
	import fl.transitions.easing.*
	import flash.filters.GlowFilter
	import flash.filters.DropShadowFilter
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Зонтик2012
	 */
	
	public class Game extends Sprite 
	{
		
		[Embed(source = 'gfx/space_3.png')]var bg_png:Class;
		[Embed(source = 'obj_fire_2.png')]var fruit_png:Class;
		[Embed(source = 'gfx/space_1.png')]var menu_png:Class;
		[Embed(source = 'gfx/asteroids/a2_01.png')]var enemy_png:Class;
		[Embed(source = 'gfx/fx/bullet_1.png')]var bullets_png:Class;
		[Embed(source = 'gfx/units/s_4.png')]var circle_png:Class;
		
		[Embed(source = 'gfx/asteroids/a2_01.png')]var a2_1:Class;
		[Embed (source = 'gfx/asteroids/a2_02.png')]var a2_2:Class;
		[Embed (source = 'gfx/asteroids/a2_03.png')]var a2_3:Class;
		[Embed (source = 'gfx/asteroids/a2_04.png')]var a2_4:Class;
		[Embed (source = 'gfx/asteroids/a2_05.png')]var a2_5:Class;
		
		[Embed (source = 'gfx/planet_1.png')]var planet_1:Class
		[Embed (source = 'gfx/planet_3.png')]var planet_3:Class
		[Embed (source = 'gfx/units/s_2.png')]var boss_png:Class
		[Embed (source = 'gfx/units/h2.png')]var ship2:Class;
		[Embed (source = 'gfx/units/h3.png')]var ship1:Class;
		var ship_arts:Array = [ship1,ship2];
		public function Game(_lvl):void{
		
	
		lvl = _lvl;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//global
		var grad = 180 / Math.PI;
		var lvl
		var rad = Math.PI / 180;
		/*var planet:MovieClip = new MovieClip();
		planet.graphics.beginFill(0xfffff);
		planet.graphics.drawCircle(500, 300, 2);
		addChild(planet);*/
		
        	
		

		var dead_list:Array = [];
		var list_all:Array = [];
		function addTail(x1, y1, x2, y2, w, cl, cf) {
			var tail = new MovieClip();
			gfx_mc.addChild(tail);
			tail.graphics.lineStyle(w,cl);
			tail.graphics.moveTo(x1,y1);
			tail.graphics.lineTo(x2,y2);
			//var glow:GlowFilter = new GlowFilter(cf);
			
			//tail.filters = [glow];
		}
		function addMiniTxt(tx, ty, txt) {
			var item:MovieClip = new MovieClip()
			var dtxt:TextField = new TextField()
			var tf:TextFormat = new TextFormat()
			
			tf.size = 16
			dtxt.text = txt;
			item.x = tx;
		    item.y = ty;
			
			//var glow:GlowFilter = new GlowFilter()
			//item.filters = [glow];
			tf.bold =true;
			
			item.addChild(dtxt);
			gfx_mc.addChild(item);
			dtxt.setTextFormat(tf)
			item.tta = 20;
			item.tty = true;
			tf.font = "Forte";
		}
		//var bosses:Array = []
		//addBoss(tx,ty)
	
		
		var laser_color=0xff0000
		var laser_glow= new GlowFilter(laser_color,1,4,4)
		var gfx_mc:MovieClip = new MovieClip
		var lasers:Array = [];
		var keys_arr:Array = [];
		function keyDownHandler(e) { 
			keys_arr[e.keyCode] = true;
			if (e.keyCode > 48 && e.keyCode < 55)
				circle.weapon_id = e.keyCode-48;
		}
		function keyUpHandler(e) { 
			keys_arr[e.keyCode] = false;
		}
		var space2_mc: MovieClip = new MovieClip();

		var game_mc:MovieClip = new MovieClip();
		var space_mc:MovieClip = new MovieClip();
		
		var	circle:CUnit=new CUnit()
		var pause_mc:CButton = new CButton(100,30);
		var life=3
		var level = 1;
		var circle_r = 100;
		var bg:MovieClip = new MovieClip()
		var glow:GlowFilter = new GlowFilter(0x00ff00, 1, 8, 8)
		var menuScr:MovieClip = new MovieClip()
		
		var scores = 0
		var scores_dtxt:TextField = new TextField();		
		var scores_tf:TextFormat = new TextFormat();
		var asteroid_arts:Array=[]
		
		var fruits:Array = [];
		var enemies:Array = [];
		var bullets:Array = [];
		function get_dd(p1, p2) {
			var dx= p2.x - p1.x
			var dy = p2.y - p1.y
			return dx * dx + dy * dy
		}
		
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			dead_list.push(enemies,bullets,lasers)
			circle.hp = 100;
			circle.hp_max = 100
			circle.gid = 0;
			circle.hprefresh()
			
			game_mc.addChild(gfx_mc);

			circle.weapon_id = 1;
            keys_arr[32]!=true
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler) 
            stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler)
			var art = new planet_1();
			art.x = 700;
			art.y = 600;
			space2_mc.addChild(art)
			var art = new planet_3
			art.x = 500;
			art.y = 100;
			space2_mc.addChild(art)
			addChild(space_mc)
			addChild(space2_mc)			
			
			addChild(game_mc)
			
			circle.v=10
			asteroid_arts.push(a2_1)
			asteroid_arts.push(a2_2)
			asteroid_arts.push(a2_3)
			asteroid_arts.push(a2_4)
			asteroid_arts.push(a2_5)
			
			//circle.filters=[glow]
		
			var art:Bitmap = new bg_png();
			art.scaleX=art.scaleY=2
			space_mc.addChild(art)
			list_all.push(enemies);
			list_all.push([circle]);

		/*
			circle.graphics.lineStyle(3, 0)
			circle.graphics.beginFill(0, 1)
			circle.graphics.drawCircle(0, 0, circle_r)
			
			circle.graphics.beginFill(0xffff00, 1)
			circle.graphics.drawCircle(-50, -30, 40)
			circle.graphics.drawCircle(50, -30, -40)
			circle.graphics.drawCircle(50 , 30 , 40)
			circle.graphics.drawCircle(50, 30, 40 )  
			*/
			
			var art:Bitmap = new circle_png();
			art.x = -art.width / 2;
			art.y = -art.height / 2;
			circle.addChild(art)
			
			game_mc.addChild(circle)
			for (var i = 0; i < 10; i++) {
				addfruit()
				addenemy()
			}
			

			addEventListener(MouseEvent.CLICK,shoot)
		
			addboss(1100,300)
			
			addEventListener(Event.ENTER_FRAME, move);
			pause_mc.x = 800 / 2;
			pause_mc.y = 10;
			addChild(pause_mc);
			pause_mc.addEventListener(MouseEvent.CLICK,pauseHandler)
		}
		
		function shoot(evt) { 
			trace("Phew-Phew")
			var a = (circle.rotation-90) * Math.PI / 180
			if (circle.weapon_id == 1) {
				//оружие 1
				addBullet(circle.x, circle.y, Math.cos(a), Math.sin(a), circle.gid,10,circle)
			}else if (circle.weapon_id == 2) {
				//оружие 2
				addBullet(circle.x, circle.y, Math.cos(a), Math.sin(a), circle.gid,10,circle)
				var al= a - 0.5;
				addBullet(circle.x, circle.y, Math.cos(al), Math.sin(al), circle.gid,10,circle)
				var ar = a + 0.5;
				addBullet(circle.x, circle.y, Math.cos(ar), Math.sin(ar), circle.gid,10,circle)
			}else if (circle.weapon_id == 3) {
				//оружие 3
				addBullet(circle.x, circle.y, Math.cos(a), Math.sin(a), circle.gid,10,circle)
				var al= a - 1;
				addBullet(circle.x, circle.y, Math.cos(al), Math.sin(al), circle.gid,10,circle)
				var ar = a + 1;
				addBullet(circle.x, circle.y, Math.cos(ar), Math.sin(ar), circle.gid,10,circle)
				
			}else if (circle.weapon_id = 4) {
				//оружие 4
				addLasers(circle.x, circle.y, Math.cos(a), Math.sin(a),circle.gid,2,0xff0000,10,circle)
				
				
			}
		}
		
		function tearApart(mc) {
			var sy=0
			var sx=0;
			for (var x = mc.width / 2; x <= mc.width; x += mc.width / 2) {
				for (var y = mc.height / 2; y <= mc.height; y += mc.height / 2) {
					var m = new Matrix()
					m.translate(sx,sy)

					if(x-sx<1)return
					var bmd = new BitmapData(x-sx, y-sy,true,0)
					bmd.draw(mc,m);
					var bm:Bitmap = new Bitmap(bmd);
					var item:MovieClip=new MovieClip()
					item.addChild(bm);
					gfx_mc.addChild(item);
					item.va= Math.random() - 0.5;
					item.vx= Math.random() - 0.5;
					item.vy= Math.random() - 0.5;
					
					item.x =mc.x+sx
					item.y =mc.y+sy
					sx = x
					
					item.tta = 30
				
	
				}
				sy=y
			}
		}
		
		var pause_bol:Boolean = false;
		function pauseHandler(evt) {
			pause_bol = !pause_bol
			
			if (pause_bol) {
				bg.graphics.beginFill(0, 0.5)
				addChild(bg)
				bg.graphics.drawRect(0,0,800,600)
				removeEventListener(Event.ENTER_FRAME,move)
			}else{
				addEventListener(Event.ENTER_FRAME, move)
			}
		}
		
		function addfruit(){
		
		
			var fruit:MovieClip = new	MovieClip()
			fruits.push(fruit)
			//fruit.graphics.beginFill(0xff00)
			//fruit.graphics.drawCircle(0, 0, 30)

			fruit.x = Math.random() * 800
			fruit.y = Math.random() * 600
		
			game_mc.addChild(fruit)
			
			var art:Bitmap = new fruit_png()
			
			fruit.addChild(art)
		}
		function addenemy(power = 5){
			var fruit:CUnit = new CUnit();
			fruit.ttd=3000+Math.random()*2000
			fruit.scaleY =fruit.scaleX = power / 5;
			fruit.power=power
			enemies.push(fruit)
			fruit.graphics.beginFill(0xff00ff)
			fruit.graphics.drawCircle(0, 0, 30)
			
            fruit.x = circle.x;
			fruit.y = circle.y + (Math.round(Math.random()) - 0.5) * 1400
			fruit.vx=(circle.x-fruit.x)/150
			fruit.vy=(circle.y-fruit.y)/150

			fruit.hp = 10 * power
			fruit.gid = 1;
			var art:Bitmap = new asteroid_arts[Math.round(Math.random() * 4)]()
			
			fruit.addChild(art)
			art.x = -art.width / 2;
			art.y = -art.height / 2;
			game_mc.addChild(fruit)
	
			return fruit
			
		}
		function addboss(tx, ty) {
			var fruit:CUnit=new CUnit()
			fruit.sleep_d = 800;
			
			fruit.boss = true;
			
			fruit.gid = 2;
			game_mc.addChild(fruit)
			
			var art:Bitmap = new boss_png();
			fruit.addChild(art)
			art.x = -art.width / 2;
			art.y = -art.height / 2;
			
			fruit.laser = {
				reload:1000,
				reload_max:1000,
				speed:40,
				charge:1000,
				charge_max:1000
			}
			

			enemies.push(fruit)
			
			
            fruit.x = tx;
			fruit.y = ty;
			fruit.vx = 0;
			fruit.vy = 0;
			fruit.bx = tx;
			fruit.by = ty;
			
			return fruit
		}
			
		function addShip(tx, ty, gid, gun_id = 0, art_id = 0) {
		
			var fruit:CUnit=new CUnit()
		
			fruit.gun_id = gun_id;
			
			fruit.gun={}
		
			if (gun_id == 0){
				fruit.gun.dmg = 5
				fruit.gun.speed = 5;
				fruit.gun.reload = 500
				fruit.gun.reload_max=500
				fruit.hp = 100 + 50 * art_id
				fruit.hp_max = fruit.hp;
				fruit.speed = 5;
				fruit.vx = 10
				fruit.vy = 0; 
				fruit.va = 0.1;
			
			}
			fruit.boss = true;
			
			fruit.gid = gid;
			game_mc.addChild(fruit)
			
			var arts =new ship_arts [art_id]();
			fruit.addChild(arts)
			arts.x = -arts.width / 2;
			arts.y = -arts.height / 2;
			

			

			enemies.push(fruit)
			
			
            fruit.x = tx;
			fruit.y = ty;
			fruit.vx = 0;
			fruit.vy = 0;
			fruit.bx = tx;
			fruit.by = ty;
			
			
			var body:MovieClip = new MovieClip()
			body.addChild(arts);
			fruit.addChild(body)
			body.rotation = -90;
	
			return fruit
		}
		
		
		function addBullet(sx,sy,tx,ty, gid, dmg=10,source=null){
			var fruit:MovieClip = new	MovieClip()
			fruit.source = source;
			
			bullets.push(fruit)
			//fruit.graphics.beginFill(0xff00ff)
			//fruit.graphics.drawCircle(0, 0, 30)

			fruit.x=sx
			fruit.y=sy			
			fruit.vx=tx
			fruit.vy=ty
			fruit.gid = gid
			fruit.dmg = dmg
			
			var art:Bitmap = new bullets_png();
			fruit.addChild(art)
			
			game_mc.addChild(fruit)
			fruit.rotation = Math.atan2(ty, tx) * grad+90
			trace("_addBullet:", fruit.x, fruit.y)
		}
		function addLasers(sx,sy,tx,ty, gid=0, w=2, c=0xff0000,dmg=10,source=null){
			var fruit:MovieClip = new	MovieClip()
			fruit.source = source;
			lasers.push(fruit)
			//fruit.graphics.beginFill(0xff00ff)
			//fruit.graphics.drawCircle(0, 0, 30)

			fruit.x=sx
			fruit.y=sy			
			fruit.vx = tx;
			fruit.vy = ty;
			fruit.dmg=dmg
			//var art:Bitmap = new bullets_png();
			//fruit.addChild(art)
			//game_mc.addChild(fruit)
			fruit.rotation = circle.rotation
		}
		var lifes_mc:MovieClip = new MovieClip()
		function drawLifes() {

		}
		
		function restart(evt){
			while (fruits.length > 0){
				var fruit = fruits.pop()
				game_mc.removeChild(fruit)
			}
			removeChild(bg)
			removeEventListener(MouseEvent.CLICK,restart)
		}
		//function Bosses:Array = []
		//addboss(tx,ty)
		//addEnemy
		function turnEnemies(dtime)		{
			var gr = gfx_mc.graphics;
				gr.clear();
			
			for (var i in enemies) {
				var fruit = enemies[i]
				
			
				if (fruit.va) {
					var tc = fruit.rotation;
					var x2 = 100 * Math.cos(tc * rad) + fruit.x;
					var y2 = 100 * Math.sin(tc * rad) + fruit.y;
					gr.moveTo(fruit.x, fruit.y);

					gr.lineStyle(3, 0xff000);
					gr.lineTo(x2, y2)
					//линия героя
			
					var ta = Math.atan2(dy, dx) * grad;
					fruit.rotation += (ta - tc) / 20;
					
					var tc = fruit.rotation;
					fruit.vx =-fruit.speed * Math.cos(tc * rad);
					fruit.vy =-fruit.speed * Math.sin(tc * rad);
					
				}
				if (fruit.gun) {
					var gun = fruit.gun;
					var tc = fruit.rotation * rad;
					var vx = -fruit.gun.speed* Math.cos(tc) * dtime / 200;
					var vy = -fruit.gun.speed * Math.sin(tc) * dtime / 200;
					if (gun.reload < 0) {
						addBullet(fruit.x, fruit.y, vx, vy, fruit.gid, fruit.gun.dmg, fruit)
						gun.reload = gun.reload_max;
					}else {
						gun.reload -= dtime;
					}
				}
				if (fruit.ttd) {
					fruit.ttd -= dtime
					if (fruit.ttd < 0) {
						fruit.dead = true
						continue
					}
				}
				
				
				if (fruit.sleep_d) {
					var d = Math.max(Math.abs(fruit.x - circle.x), Math.abs(fruit.y - circle.y))
					if (d < fruit.sleep_d) {
					//	fruit.sleep_d = null;
					}else {
						continue;
					}
				}
				fruit.x += fruit.vx;
				fruit.y += fruit.vy;
				
				var dx = fruit.x - circle.x;
				var dy = fruit.y - circle.y;
				var dd = dx * dx +dy * dy 
			
				/*if (fruit.x < 0 || fruit.x > 800 || fruit.y > 600 || fruit.y < 0) {
					removeChild(fruit);
					enemies.splice(i, 1);
					continue;
				}*/
				
				if (fruit.laser) {
					if (fruit.moving) {
						var a = Math.atan2(dy, dx)
						fruit.rotation = a * 180 / Math.PI + 90;
					}
					var laser = fruit.laser;
					
					if (laser.reload < 0) {
						if (laser.charge < 0) {
							laser.charge = laser.charge_max;
							laser.reload = laser.reload_max;
							//
							//
							var d=Math.sqrt(dd)
							addLasers(fruit.x, fruit.y, -dx * laser.speed / d, -dy * laser.speed / d, 1, 8);
						}else {
							
							fruit.moving = false;
							laser.charge-= dtime
							//зарядка лазера
							var tail = new MovieClip();
							gfx_mc.addChild(tail);
							tail.graphics.lineStyle(2, 0xFF0000);
							tail.graphics.moveTo(fruit.x + (Math.random() - 0.5)*200, fruit.y + (Math.random() - 0.5)*200);
							tail.graphics.lineTo(fruit.x, fruit.y);
							tail.ttl = 6;
							//tail.filters = [laser_glow];
						}
					}else {
						laser.reload -= dtime;
						if (fruit.moving==false) {
							var ta = Math.random() * Math.PI * 2;
							fruit.x = Math.cos(ta) * 300 + fruit.bx;
							fruit.y = Math.sin(ta) * 200 + fruit.by;
						}
						fruit.moving = true;
					}
				}
				
				
				if (dd < circle_r * circle_r ) {
					//ой больно 
					//life--
					drawLifes();
					if (life < 0){
					addEventListener(MouseEvent.CLICK,restart)
						
					bg.graphics.beginFill(0, 0.5) 
					
						addChild(bg)
			
						removeEventListener	(Event.ENTER_FRAME, move);
						
						bg.graphics.beginFill(0,0.5)
						addChild(bg)
						bg.graphics.drawRect(0, 0, 800, 600)
						bg.graphics.drawRect(0, 0, 800, 600)
						var dtxt:TextField = new TextField();
						new Tween(dtxt, "y", Elastic.easeOut, -50, 300, 24)
						new Tween(bg, "alpha", None.easeOut, 0, 1, 24)
						dtxt.text = "Game Over";
						addChild(dtxt)
						dtxt.textColor = 0xff;
						dtxt.width = 800;
						var ts: TextFormat = new TextFormat()
						ts.size = 36;
						ts.align = "center";
						dtxt.setTextFormat(ts)
				
				
					
						
					}

					fruit.dead = true;

					
					
				}

			}
			
		}
		function damageObj(tar, dmg, source = null) {
			tar.hp -= dmg;
			if (tar.hp < 0) {
				tar.dead = true;
				if (source) {
					if (source.gid != tar.gid) {
						source.kills ++;
						if (source === circle) {
							scores += 100;
							addMiniTxt (tar.x, tar.y, "+100");
						}
					}
				}
			}else {
				tar.hprefresh();
			}
		}
		
		var otime=getTimer()
		function move(evt) {
		
		
			var dtime = getTimer() - otime;
			otime = getTimer();

			if (Math.random()>0.97) {
				addenemy();
			}
			
				
			if (Math.random() > 0.97) {
				addShip(circle.x + 200, circle.y, 1) 
			}
		
		    for (var i = gfx_mc.numChildren - 1; i >= 0; i--) {
				var item = gfx_mc.getChildAt(i);
				if(item.vx) item.x +=item.vx
				if (item.vy) item.y +=item.vy
				if(item.va)item.rotation+=item.va
				
				item.alpha *= 0.9
				if (item.alpha < 0.001) {
					gfx_mc.removeChildAt(i);
				}
			}
		
			turnEnemies(dtime)
			
			var dx = game_mc.mouseX - circle.x;
			var dy  = game_mc.mouseY - circle.y;
			var dd = dx * dx + dy * dy;
			var d = Math.sqrt(dd)
			//паралакс
			if (d > circle.v && keys_arr[32]!= true) {
				var vx = circle.v * dx  / d;	
				var vy = circle.v * dy / d;
				circle.x += vx;
				circle.y += vy;
				
				//r
				if (circle.x + game_mc.x > 500 && vx > 0&& space_mc.x-vx/8>800-space_mc.width) {
					game_mc.x -= vx;
					space2_mc.x -= vx / 4;
					space_mc.x -= vx/8;	
				}
				//left
				if (circle.x + game_mc.x <300 && vx < 0 && space_mc.x- vx/8<0) {
					game_mc.x -= vx;
					space2_mc.x -= vx / 4;
					space_mc.x -= vx/8;	
				}
				//up
				if (circle.y + game_mc.y <200 && vy < 0 && space_mc.y-vy/8<0 ) {
					game_mc.y -= vy;
					space2_mc.y -= vy / 4;
					space_mc.y -= vy/8;	
				}
				//down
				if (circle.y + game_mc.y >400 && vy > 0&& space_mc.y-vy/8>600-space_mc.height ) {
					game_mc.y -= vy;
					space2_mc.y -= vy / 4;
					space_mc.y -= vy/8;	
				}
			}

			circle.rotation = Math.atan2(dy, dx)*180/Math.PI+90
			
			graphics.clear()
			for (var i in fruits) {
				var fruit = fruits[i]
				var dx=fruit.x-circle.x
				var dy=fruit.y-circle.y
				var dd = dx * dx +dy * dy 
			
				if (dd < circle_r * circle_r && fruit.visible == true) {
					//ням-ням-ням
					scores +=100 +level * 10;
					scores_dtxt.text = scores;
					scores_dtxt.x = 700;
					scores_dtxt.y = 10;
					scores_tf.size = 26;
					scores_dtxt.setTextFormat(scores_tf)
					
					
					
					
					addChild(scores_dtxt)
					fruits.splice(i, 1)
				game_mc.removeChild(fruit);

				}

			}

			
			//здесь я считаю пули
			game_mc.graphics.clear()
			
			for (var i in bullets) {
				var bullet = bullets[i]
				
				
				bullet.x += bullet.vx*20;
				bullet.y += bullet.vy * 20;
				//trace(bullet.x, bullet.y)
				 
				for each(var list in list_all){
					for (var j in list) {
						var enemy =  list[j]
						var dd = get_dd(bullet, enemy)
						
						if (bullet.gid != enemy.gid)
							if (dd < 40 * 40) {
								damageObj(enemy, bullet.dmg, bullet.source)
								bullet.dead = true;
							}
						
					}
				}
			}
			
			if (circle.dead) {
				//game over
				var rect:MovieClip = new MovieClip();
				rect.graphics.beginFill(0);
				
				return
			}
			
			//трупы
			
			
			for each(var list in dead_list)
			for (var i in list) {
				
				var item = list[i]
				if (item.dead) {
					
					
					if (game_mc.contains(item))
						game_mc.removeChild(item);
					if (item.utype)
						if (item.utype == "ship")
							tearApart(item)
						
					list.splice(i,1)	
					
					if (item.power) {
						if(item.power>1){	
							var enemy = addenemy(item.power - 1);
							enemy.x=item.x;
							enemy.y = item.y;
							enemy.vx = (Math.random() - 0.5) * 5;
							enemy.vy = (Math.random() - 0.5) * 5;
							
							var enemy = addenemy(item.power - 1);
							enemy.x=item.x;
							enemy.y = item.y;		
							enemy.vx = (Math.random() - 0.5) * 5;
							enemy.vy = (Math.random() - 0.5) * 5;
						}
					}	
				}
			}
			
			
			
			//здесь я считаю лучи
			for (var i in lasers) {
				var fruit = lasers[i];
				var old_x=fruit.x;
				var old_y = fruit.y;
				if ((old_x > 800 - game_mc.x && fruit.vx > 0) || (old_x < 0 - game_mc.x && fruit.x < 0)
				|| (old_y > 600 - game_mc.y && fruit.vy > 0)|| (old_y < 0 - game_mc.y && fruit.vy < 0)){
				//if ((old_x > 800 - game_mc.x && fruit.vx > 0) 
				//	|| (old_x < 0 - game_mc.x && fruit.x < 0)
				//	|| (old_y > 600 - game_mc.y && ftuit.vy > 0)
				//	|| (old_y<0-game_mc.y&&fruit.vy<0)){
					//lasers.splice(i, 1);
					fruit.dead = true;
					continue
				}
				fruit.x += fruit.vx*20;
				fruit.y += fruit.vy*20;
				
			/*	var tail = new MovieClip();
				gfx_mc.addChild(tail);
				tail.graphics.lineStyle(2, 0xFF0000)
				tail.graphics.moveTo(old_x,old_y)
				tail.graphics.lineTo(fruit.x, fruit.y)
				tail.ttl = 6;
				tail.filters = [laser_glow];
				*/
				var c1 = 0xff0000
				var c2 = 0xffff0000
				if (fruit.gid==1) {
					c1 = 0x0000ff
					c2 = 0x00ffff
				}
				
			    addTail(old_x, old_y, fruit.x, fruit.y, 4, c1, c2);
				
				for each(var list in list_all)
				for (var j in list) {
					var enemy = list[j];
					//var dd = get_dd(lasers[i], enemies[j])
					var p1 = { x:old_x, y:old_y };
					var p2 = { x:fruit.x, y:fruit.y }
					var sc_p = enemy;
					if((enemy.x>old_x&&enemy.x<fruit.x)||(enemy.x<old_x&&enemy.x>fruit.x)){
					var ri = CMathExt.InterRayCir(p1, p2, sc_p, enemy.width/2)
					if (ri) {
						damageObj(enemy, fruit.dmg, fruit.source)
					}
					}
				}
			

			}
			
		}
	}	
	}
