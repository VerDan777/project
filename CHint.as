package 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	/**
	 * выводит всплывающую подсказку (String | BitmapData | DisplayObject)<br>
	 * нужен вызов Alert.register() - привязка к контейнеру
	 * @example 
	 * <a href="http://www.silin.fatal.ru/AS3/utils/hint">silin.fatal.ru</a>
	 * @author silin (www.silin.fatal.ru)
	 * @version 0.2
	CHint.register(this);
	CHint.dragHint = true;
	CHint.delayOn = 0;
	 */
	public class CHint {
		/**
		 * убирать ли подсказку при любом движении мыши
		 */
		public static var clearOnMouseMove:Boolean = false;
		/**
		 * двигать ли подсказку за курсором
		 */
		public static var dragHint:Boolean = true;
		
		private static var _shadow:Boolean = true;
		private static var _hintBody:Sprite=new Sprite();
		private static var _bmp:Bitmap = new Bitmap();
		private static var _tf:TextField = new TextField();
		private static var _obj:DisplayObject;
		private static var _host:DisplayObjectContainer;
		private static var _timerOff:Timer = new Timer(9000, 1);
		private static var _timerOn:Timer = new Timer(500, 1);
		

		/**
		 * there's no constructor. экземпляры не создаем
		 */
		public function CHint():void 
		{
			trace ("Hint is a static class and should not be instantiated. Use Hint.register()");
		}
		/**
		 * TextFormat текстовой подсказки<br>
		 * должен быть задан до вызова Hint.register()
		 */
		public static var FORMAT:TextFormat=new TextFormat(
							"tahoma",	//font
							11,			//size
							0x333333,	//color
							null, null, null, null, null, null,
							2, 1,		//margins
							null,		//indent
							0			//leading
							);
		 /**
		  * привязка к базовому контейнеру, обязательный метод
		  * @param	host 		
		  */
		public static function register(host:DisplayObjectContainer)	:void
		{
			if (_host ) 
			{
				trace("Hint: double Hint.register() call");
				return;
			}
			
			_host = host;
			
			_hintBody.addChild(_tf);
			_hintBody.addChild(_bmp);
			
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.selectable=false;
			_tf.background=true;
			_tf.backgroundColor = 0xFFFDDA;
			_tf.border = true;
			_tf.borderColor = 0x404040;
			
			
			_host.addEventListener(MouseEvent.MOUSE_OUT, clear);
			_timerOn.addEventListener(TimerEvent.TIMER, add);
			_timerOff.addEventListener(TimerEvent.TIMER, clear);
			
			shadow = _shadow;
			
		}
		/**
		 * удаляет хинт
		 */
		public static function clear(evnt:Event=null):void	
		{
			
			_bmp.bitmapData = null;
			_tf.text = "";
			if (_obj && _obj.parent) 
			{
				_hintBody.removeChild(_obj);
			}
			_bmp.visible = _tf.visible = false;
			
			_timerOn.stop();
			_timerOff.stop();
			
			if (_host) 
			{
				_host.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				if(_hintBody.parent) _host.removeChild(_hintBody);
				
			}
		}
		
		/**
		 * выводит messge (текст, битмапдата, димплейобжет)
		 * @param	message	: String|bitmapData|DisplayObject 
		 */
		public static function show(message:Object):void
		{
			if (!_host)
			{
				trace("Hint: no register");
				return;
			}
			clear();
			
			//var str:String = message as String;
			var bmd:BitmapData = message as BitmapData;
			var displayObj:DisplayObject = message as DisplayObject;
			
			if (bmd)
			{
				_bmp.bitmapData = bmd;
				_bmp.visible = true;
			}else if(displayObj)
			{
				_obj = displayObj;
				_hintBody.addChild(_obj);
				
			}else
			{
				try
				{
					var str:String = message.toString();
				}catch (err:Error)
				{
					return;
				}
				_tf.text = str.split("\r\n").join("\r").split("\t").join("");
				if (_tf.text == "") return;//не показывам ничего, если пусто
				_tf.setTextFormat(FORMAT);
				_tf.visible = true;
			}
			
			/*
			if (str)
			{
				//текст без табов и лишних переносов
				_tf.text = str.split("\r\n").join("\r").split("\t").join("");
				if (_tf.text == "") return;//не показывам ничего, если пусто
				_tf.setTextFormat(FORMAT);
				_tf.visible = true;
			}else if (bmd)
			{
				_bmp.bitmapData = bmd;
				_bmp.visible = true;
			}else if (displayObj)
			{
				_obj = displayObj;
				_hintBody.addChild(_obj);
				
			}else
			{
				return;
			}
			*/
			_timerOn.start();
		}
		
		//добавляет контенер хинта в дисплейЛист _host
		//включает удаляльный таймер и прослушку MOUSE_MOVE
		private static function add(event:TimerEvent = null):void
		{
			
			_host.addChild(_hintBody);
			setPosition();

			_host.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			_timerOff.start();
		}
		
		private static function setPosition():void
		{
			//стандартное положене
			_hintBody.x = _host.mouseX + 5;
			_hintBody.y = _host.mouseY - _hintBody.height - 5;
			
			//двигаем, если не умещаемся в сцену
			while (_hintBody.getBounds(_host.stage).right > _host.stage.stageWidth-3) _hintBody.x --;
			while (_hintBody.getBounds(_host.stage).top < 3) _hintBody.y++;
		}
		
		private static function mouseMove(evnt:MouseEvent):void
		{
			if (clearOnMouseMove)
			{
				clear();
			}
			if (dragHint)
			{
				setPosition();
			}
		}
		
		/**
		 * задержка выключения (default=2000)
		 */
		public static function get delayOff():int
		{
			return _timerOff.delay;
		}
		public static function set delayOff(value:int):void 
		{
			_timerOff.delay = value;
		}
		/**
		 * задержка включения (default=500)
		 */
		public static function get delayOn():int
		{
			return _timerOn.delay;
		}
		public static function set delayOn(value:int):void 
		{
			_timerOn.delay = value;
		}
		/**
		 * нужна ли тень
		 */
		public static function get shadow():Boolean
		{
			return _shadow;
		}
		public static function set shadow(value:Boolean):void 
		{
			_shadow = value;
			_hintBody.filters = _shadow ? [new DropShadowFilter(3, 45, 0x333333, 0.5)] : [];
		}
	}
}

