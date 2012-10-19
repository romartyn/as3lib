package display.grid {
	
	import flash.display.Shape;

	public class GridSector extends Shape {
		
		private var _id:int;
		private var _status:Boolean;
		private var _width:int;
		private var _length:int;
		private var _bgColor:uint;
		private var _bgAlpha:uint;
		private var _border:int;
		private var _borderColor:uint;

		public function GridSector(sectorWidth:int = 16, sectorLenght:int = 16, bgColor:uint = 0x000000, bgAlpha:uint = 1, border:int = 1, borderColor:uint = 0xffffff) {
			_width = sectorWidth;
			_length = sectorLenght;
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			_border = border;
			_borderColor = borderColor;
			draw();
		}
		
		private function draw():void {
			graphics.clear();
			graphics.lineStyle(_border, _borderColor);
			graphics.beginFill(_bgColor, _bgAlpha);
			graphics.moveTo(0, 0);
			graphics.lineTo(- _width / 2, - _length / 2);
			graphics.lineTo(0, - _length);
			graphics.lineTo(_width / 2, - _length / 2);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		
		public function set id(id:Number):void {
			_id = id;
		}
		
		public function get id():Number {
			return _id;
		}
		
		public function set status(status:Boolean):void {
			_status = status;
		}
		
		public function get status():Boolean {
			return _status;
		}
		
		public function getWidth():int {
			return _width;
		}
		
		public function getLength():int {
			return _length;
		}
		
		public function set bgColor(bgColor:uint):void {
			_bgColor = bgColor;
		}
		
		public function get bgColor():uint {
			return _bgColor;
		}
		
		public function set bgAlpha(bgAlpha:uint):void {
			_bgAlpha = bgAlpha;
		}
		
		public function get bgAlpha():uint {
			return _bgAlpha;
		}
		
		public function clone():GridSector {
			var sector:GridSector = new GridSector(_width, _length, _bgColor, _bgAlpha, _border, _borderColor);
			sector.id = _id;
			sector.status = _status;
			return sector;
		}
	}
}