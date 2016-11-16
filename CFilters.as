// created by Badim
// if you like - visit http://blog.elite-games.net
// plz - dont delete this
// Usage:
// CFilters.trace_l() - will trace how much filters stored already
// CFilters.getSaturationFilter(val) - creates, stores, return Saturation filter.
// CFilters.getBrightFilter(val) - creates, stores, return Bright filter.
// CFilters.getHueFilter(val) - creates, stores, return Hue filter.
// all filters will be cashed after first reqest. If you going to animate via Filter properties - dont forget to copy instanc of it.
// http://blog.elite-games.net/blog5.php/2011/09/21/filters-hue-saturation-hue

package {
	import flash.filters.ColorMatrixFilter;
	//
	public class CFilters{
		public static var _filters:Object;
		public function CFilters(){
			_filters = {};
			_filters['hue'] = {};
			_filters['bright'] = {};
			_filters['saturation'] = {};
			//
			getSaturationFilter(-100);
		}
		public static function trace_l(){
			trace("")
			var count=0;
			for(var i in _filters['hue']){
				count++
			}
			trace("__filters['hue']:"+count)
			//
			count=0;
			for(var i in _filters['bright']){
				count++
			}
			trace("__filters['bright']:"+count)
		}
		//
		public static function getSaturationFilter(val:Number){
			if (_filters['saturation'][val] === undefined) {
				var r_lum:Number = 0.212671;
				var g_lum:Number = 0.715160;
				var b_lum:Number = 0.072169;
				//
				var ilum:Number=1-val;
				var irlum:Number = ilum * r_lum;
				var iglum:Number = ilum * g_lum;
				var iblum:Number = ilum * b_lum;
				var mat:Array =  [irlum + val, iglum, iblum, 0, 0, irlum, iglum + val, iblum,0,0,irlum,iglum, iblum + val,0, 0,0,0,0,1,0];
				//
				var cm=concat_mat(mat);
				_filters['saturation'][val] = cm;
			}
			return _filters['saturation'][val];
		}
		public static function getBrightFilter(val:Number) {
			if (_filters['bright'][val] === undefined) {
				var mat = [1, 0, 0, 0, val, 0, 1, 0, 0, val, 0, 0, 1, 0, val, 0, 0, 0, 1, 0]
				//
				var cm=concat_mat(mat);
				_filters['bright'][val] = cm;
			}
			//trace_l()
			//trace("__filters['bright'][val]:"+_filters['bright'][val]+":"+val)
			return _filters['bright'][val];
		}
		public static function getHueFilter(angle:Number) {
			if (_filters['hue'][angle] === undefined) {
				angle *= Math.PI/180;
				var c:Number = Math.cos(angle);
				var s:Number = Math.sin(angle);
				var f1:Number = 0.213;
				var f2:Number = 0.715;
				var f3:Number = 0.072;
				var mat = [(f1+(c*(1-f1)))+(s*(-f1)), (f2+(c*(-f2)))+(s*(-f2)), (f3+(c*(-f3)))+(s*(1-f3)), 0, 0, (f1+(c*(-f1)))+(s*0.143), (f2+(c*(1-f2)))+(s*0.14), (f3+(c*(-f3)))+(s*-0.283), 0, 0, (f1+(c*(-f1)))+(s*(-(1-f1))), (f2+(c*(-f2)))+(s*f2), (f3+(c*(1-f3)))+(s*f3), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
				//
				var cm=concat_mat(mat);
				_filters['hue'][angle] = cm;
			}
			//trace_l()
			return _filters['hue'][angle];
		}
		//
		private static function concat_mat(mat){
			var temp:Array = [];
			var IDENTITY = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			var matrix = IDENTITY.concat();
			var i:Number = 0;
			for (var y:Number = 0; y<4; y++) {
				for (var x:Number = 0; x<5; x++) {
					temp[i+x] = mat[i]*matrix[x]+mat[i+1]*matrix[x+5]+mat[i+2]*matrix[x+10]+mat[i+3]*matrix[x+15]+(x == 4 ? mat[i+4] : 0);
				}
				i += 5;
			}
			var cm = new ColorMatrixFilter(temp);
			return cm;
		}
	}
}