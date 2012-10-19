package display.grid {
	
	import flash.display.Shape;
	import flash.display.Sprite;

	public class GridContainer extends Sprite {
		
		private var _width:int;
		private var _length:int;
		private var _bgColor:uint;
		private var _bgAlpha:uint;
		private var _border:int;
		private var _borderColor:uint;
		private var _cellWidth:int;
		private var _cellLength:int;
		
		public function GridContainer(containerWidth:int = 1, containerLenght:int = 16, bgColor:uint = 0x000000, bgAlpha:int = 1, border:int = 1, borderColor:uint = 0xffffff) {
			_width = containerWidth;
			_length = containerLenght;
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			_border = border;
			_borderColor = borderColor;
		}
		
		public function render():void {
			var w:int = _width * _cellWidth;
			var l:int = _length * _cellLength;
			var x:int = 0;
			var y:int = 0;
			graphics.clear();
			graphics.lineStyle(_border, _borderColor);
			graphics.beginFill(_bgColor, _bgAlpha);
			graphics.moveTo(0, 0);
			if(_width != _length) {
				x = - _cellLength * _width;
				y = - _cellLength * _width / 2;
				graphics.lineTo(x, y);
				x = x + ((_cellWidth / 2) * _length);
				y = y - ((_cellLength / 2) * _length);
				graphics.lineTo(x, y);
				x = x + _cellWidth * _width / 2;
				y = y + _cellLength * _width / 2;
				graphics.lineTo(x, y);
			}
			if(_width == _length) {
				graphics.lineTo( - w / 2, - l / 2);
				graphics.lineTo(0, - l);
				graphics.lineTo(w / 2, - l / 2);
			}
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		
		public function set cellWidth(cWidth:int):void {
			_cellWidth = cWidth;
		}
		
		public function set cellLength(cLength:int):void {
			_cellLength = cLength;
		}
	}
}