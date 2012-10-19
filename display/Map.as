package display {
	
	import display.Building;
	import display.Road;
	import display.grid.Grid;
	import display.grid.GridSector;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.Connector;
	
	public class Map extends Sprite {
		
		private var _stage:Stage;
		private var _view:Sprite;
		private var _viewOpts:Object;
		private var _viewCanMove:Boolean;
		private var _map:*;
		private var _buildings:Object;
		
		public function Map() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			return;
		}
		
		public function load(data:*):void {
			_map = data.map;
			render();
		}
		
		public function render():void {
			var pos:Object;
			if(_view != null) {
				pos = {x:_view.x,y:_view.y,sx:_view.scaleX,sy:_view.scaleY};
			}
			if(_view != null && contains(_view)) removeChild(_view);
			var gridSector:GridSector = new GridSector(50, 25, 0xc0c0c0);
			var grid:Grid = new Grid(_map.s[0].w, _map.s[0].h);
			_view = new Sprite();
			_view.cacheAsBitmap = true;
			grid.setSector(gridSector);
			grid.showOrigin = false;
			grid.showBg = false;
			grid.render();
			for each(var obj:Object in _map.s[0].n) {
				switch(obj.t) {
					case 'r' :
						grid.addObject(new Road(RoadsLibrary.road(obj.id), {x : obj.x, y : obj.y}));
						break;
					case 'b' :
						var buildingOptions:Object = BuildingsLibrary.building(obj.lid);
						buildingOptions.id = obj.id;
						buildingOptions.lid = obj.lid;
						buildingOptions.iid = obj.iid;
						buildingOptions.inc = obj.inc;
						buildingOptions.bots = obj.bots.length;
						var building:Building = new Building(buildingOptions, IconsLibrary.icon(obj.iid), {x : obj.x, y : obj.y});
						building.icon.addEventListener(MouseEvent.MOUSE_OVER, onBuildingIconMouseEvent);
						building.icon.addEventListener(MouseEvent.MOUSE_OUT, onBuildingIconMouseEvent);
						building.icon.addEventListener(MouseEvent.CLICK, onBuildingIconMouseEvent);
						if(_buildings == null) _buildings = new Object();
						_buildings[building.id] = building;
						grid.addObject(building);
						break;
				}
			}
			_view.addEventListener(MouseEvent.MOUSE_DOWN, mapMouseDownHandler);
			_view.addEventListener(MouseEvent.MOUSE_UP, mapMouseUpHandler);
			_view.addEventListener(MouseEvent.MOUSE_WHEEL, mapMouseWheelHandler);
			_view.addChild(grid);
			if(pos != null) {
				_view.x = pos.x;
				_view.y = pos.y;
				_view.scaleX = pos.sx;
				_view.scaleY = pos.sy;
				_view.y = pos.y;
			}
			else {
				_view.x = _stage.stageWidth / 2 - _view.width / 2;
				_view.y = _stage.stageHeight / 2 - _view.height / 2;
			}
			addChild(_view);
		}
		
		public function update(map:*):void {
			
		}
		
		private function updateBuilding(data:*):void {
			_buildings[data.id].iid = data.iid;
			_buildings[data.id].icon = IconsLibrary.icon(data.iid).default;
			_buildings[data.id].icon.addEventListener(MouseEvent.MOUSE_OVER, onBuildingIconMouseEvent);
			_buildings[data.id].icon.addEventListener(MouseEvent.MOUSE_OUT, onBuildingIconMouseEvent);
			_buildings[data.id].icon.addEventListener(MouseEvent.CLICK, onBuildingIconMouseEvent);
		}
		
		protected function onAddedToStage(event:Event):void {
			_stage = stage;
		}
		
		protected function mapMouseDownHandler(event:MouseEvent):void {
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, mapMouseMoveHandler);
			if(_viewOpts == null) _viewOpts = new Object();
			_viewOpts.active = true;
			_viewOpts.mouseX = mouseX - _view.x;
			_viewOpts.mouseY = mouseY - _view.y;
			//if(_buildingPreveiwBoxContainer != null && _view.contains(_buildingPreveiwBoxContainer)) _view.removeChild(_buildingPreveiwBoxContainer);
			_viewCanMove = true;
			//_viewInMove = true;
		}
		
		protected function mapMouseUpHandler(event:MouseEvent):void {
			//_viewInMove = false;
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mapMouseMoveHandler);
		}
		
		protected function mapMouseWheelHandler(event:MouseEvent):void {
			var befor:Object = new Object();
			if(event.delta < 0) {
				if(_view.scaleX >= 0.6 && _view.scaleY >= 0.6) {
					befor.x = _view.x;
					befor.y = _view.y;
					befor.width = _view.width;
					befor.height = _view.height;
					_view.scaleX -= 0.1;
					_view.scaleY -= 0.1;
					_view.x += (befor.width - _view.width) / 2;
					_view.y += (befor.height - _view.height) / 2;
				}
			}
			if(event.delta > 0) {
				if(_view.scaleX <= 0.9 && _view.scaleY <= 0.9) {
					befor.x = _view.x;
					befor.y = _view.y;
					befor.width = _view.width;
					befor.height = _view.height;
					_view.scaleX += 0.1;
					_view.scaleY += 0.1;
					_view.x += (befor.width - _view.width) / 2;
					_view.y += (befor.height - _view.height) / 2;
				}
			}
			event.updateAfterEvent();
		}
		
		protected function mapMouseMoveHandler(event:MouseEvent):void {
			if(_viewCanMove) {
				if(_view.width > _stage.stageWidth) {
					if(_view.x >= _stage.stageWidth - _view.width && _view.x <= 0) _view.x = mouseX - _viewOpts.mouseX;
					if(_view.x < _stage.stageWidth - _view.width) _view.x = _stage.stageWidth - _view.width;
					if(_view.x > 0) _view.x = 0;
				}
				else {
					if(_view.x >= 0 && _view.x <= _stage.stageWidth - _view.width) _view.x = mouseX - _viewOpts.mouseX;
					if(_view.x < 0) _view.x = 0;
					if(_view.x > _stage.stageWidth - _view.width) _view.x = _stage.stageWidth - _view.width;
				}
				if(_view.height > _stage.stageHeight) {
					if(_view.y >= _stage.stageHeight - _view.height && _view.y <= 25) _view.y = mouseY - _viewOpts.mouseY;
					if(_view.y < _stage.stageHeight - _view.height) _view.y = stage.stageHeight - _view.height;
					if(_view.y > 25) _view.y = 25;
				}
				else {
					if(_view.y >= 0 && _view.y <= _stage.stageHeight - _view.height) _view.y = mouseY - _viewOpts.mouseY;
					if(_view.y < 10) _view.y = 10;
					if(_view.y > _stage.stageHeight - _view.height) _view.y = _stage.stageHeight - _view.height;
				}
				//if(_buildingPreviewBox != null && stage.contains(_buildingPreviewBox)) stage.removeChild(_buildingPreviewBox);
			}
			event.updateAfterEvent();
		}
		
		protected function onBuildingIconMouseEvent(event:MouseEvent):void {
			switch(event.type) {
				case MouseEvent.CLICK:
					Connector.socket.addTask('building', event.currentTarget.parent, updateBuilding);
					break;
				case MouseEvent.MOUSE_OVER:
					break;
				case MouseEvent.MOUSE_OUT:
					break;
			}
		}
	}
}