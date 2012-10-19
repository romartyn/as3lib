package display.grid {
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Grid extends Sprite {
		
		private var _countX:int;
		private var _countY:int;
		
		private var _sector:GridSector;
		private var _cellWidth:Number;
		private var _cellLength:Number;
		private var _cellHeight:int;
		private var _cells:Vector.<GridSector>;
		
		private var _showBg:Boolean = true;
		private var _showOrigin:Boolean = true;
		private var _showLines:Boolean = true;
		
		private var _bgColor:uint = 0xcccccc;
		private var _bgAlpha:int = 1;
		private var _bg:Shape;
		private var _origin:Shape;
		private var _lines:Sprite;
				
		public function Grid(countX:int, countY:int) {
			_countX = countX;
			_countY = countY;
		}
		
		private function drawBg():void {
			_bg = new Shape();
			_bg.graphics.beginFill(_bgColor, _bgAlpha);
			_bg.graphics.moveTo((_cellWidth * _countX) / 2, 0);
			_bg.graphics.lineTo(_cellWidth * _countX, (_cellLength * _countY) / 2);
			_bg.graphics.lineTo((_cellWidth * _countX) / 2, _cellLength * _countY);
			_bg.graphics.lineTo(0, (_cellLength * _countY) / 2);
			_bg.graphics.endFill();
		}
		
		private function drawOrigin():void {
			_origin = new Shape();
			_origin.graphics.lineStyle(1, 0x00ff00);
			_origin.graphics.moveTo((_cellWidth * _countX) / 2, -2);
			_origin.graphics.lineTo(_cellWidth * _countX + 2, (_cellLength * _countY) / 2 - 1);
			_origin.graphics.lineStyle(1, 0xff0000);
			_origin.graphics.moveTo((_cellWidth * _countX) / 2, -2);
			_origin.graphics.lineTo(-2, (_cellLength * _countY) / 2 - 1);
			_origin.graphics.lineStyle(1, 0x0000ff);
			_origin.graphics.moveTo((_cellWidth * _countX) / 2, -2);
			_origin.graphics.lineTo((_cellWidth * _countX) / 2, - (_cellLength * _countY));
		}
		
		private function drawLines():void {
			_lines = new Sprite();
			_cells = new Vector.<GridSector>;
			_cells.push(new GridSector());
			var lineStart:Object = new Object();
			lineStart.x = (_cellWidth * _countX) / 2 - _cellWidth / 2;
			lineStart.y = _cellLength / 2;
			for(var i:Number = 1; i <= _countY; i++) {
				for(var j:Number = 1; j <= _countX; j++) {
					var sector:GridSector = new GridSector();
					sector = _sector.clone();
					sector.x = lineStart.x + j * _cellWidth / 2;// - _cellWidth / 2;
					sector.y = lineStart.y + j * _cellLength / 2;// - _cellLength / 2;
					_lines.addChild(sector);
					_cells.push(sector);
				}
				lineStart.x = lineStart.x - _cellWidth / 2;
				lineStart.y = lineStart.y + _cellLength / 2;
			}
		}
		
		public function setSector(sector:GridSector):void {
			_sector = sector;
			_cellWidth = _sector.getWidth();
			_cellLength = _sector.getLength();
		}
		
		public function set cellWidth(width:Number):void {
			_cellWidth = width;
		}
		
		public function set cellLength(length:Number):void {
			_cellLength = length;
		}
		
		public function set showBg(flag:Boolean):void {
			_showBg = flag;
		}

		public function set showOrigin(flag:Boolean):void {
			_showOrigin = flag;
		}

		public function set showLines(flag:Boolean):void {
			_showLines = flag;
		}
		
		public function addObject(child:*):DisplayObject {
			var sector:GridSector = _cells[(_countX * (child.y - 1) + child.x)];
			if(child is GridContainer) {
				child.cellWidth = _cellWidth;
				child.cellLength = _cellLength;
				child.render();
			}
			child.x = sector.x;
			child.y = sector.y;
			return addChild(child);
		}
		
		public function render():void {
			if(_showBg) {
				drawBg();
				addChild(_bg);
			}
			if(_showOrigin) {
				drawOrigin();
				addChild(_origin);
			}
			if(_showLines) {
				drawLines();
				addChild(_lines);
			}
		}
	}
}