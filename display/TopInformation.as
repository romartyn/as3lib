package display {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TopInformation extends Sprite {
		
		private var _stage:Stage;
		private var _view:*;
		private var _data:*;
		
		public function TopInformation() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_view = new topInformation;
			_view._le.mouseChildren = false;
			_view._le_progress.mouseChildren = false;
			_view._po.mouseChildren = false;
			_view._cp.mouseChildren = false;
			_view._le.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_view._le.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_view._le_progress.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_view._le_progress.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_view._po.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_view._po.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_view._cp.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_view._cp.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			render();
			return;
		}
		
		public function update(data:*):void {
			_data = data;
			_view._le._text.text = _data.le;
			_view._le_progress._pointer.x = (_view._le_progress._pointer.width * ((Math.round((_data.ex.c / _data.ex.cn) * 100)) * 0.01)) - _view._le_progress._pointer.width;
			_view._po._text.text = _data.po;
			_view._cp._text.text = _data.cp;
		}
		
		private function render():void {
			addChild(_view);
		}
		
		protected function onAddedToStage(event:Event):void {
			_stage = stage;
			_stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		protected function onStageResize(event:Event):void {
			x = 0;
			y = 0;
		}
		
		protected function onMouseOver(event:MouseEvent):void {
			if(_data == null) return;
			switch(event.currentTarget) {
				case _view._le:
					_view.tooltip.text.text = 'Уровень';
					_view.tooltip.x = 0;
					_view.tooltip.y = _view._le.y + _view._le.height + 2;
					break;
				case _view._le_progress:
					_view.tooltip.text.text = 'Опыт: ' + _data.ex.c + ' / ' + _data.ex.cn;
					_view.tooltip.x = _view._le_progress.x - (_view.tooltip.width - _view._le_progress._pointer.width) / 2;
					_view.tooltip.y = _view._le_progress.y + _view._le_progress.height + 10;
					break;
				case _view._po:
					_view.tooltip.text.text = 'Поинты';
					_view.tooltip.x = _view._po.x - (_view.tooltip.width - _view._po.width) / 2;
					_view.tooltip.y = _view._po.y + _view._po.height + 2;
					break;
				case _view._cp:
					_view.tooltip.text.text = 'Кэш Поинты';
					_view.tooltip.x = _view._cp.x - (_view.tooltip.width - _view._cp.width) / 2;
					_view.tooltip.y = _view._cp.y + _view._cp.height + 2;
					break;
			}
		}
		
		protected function onMouseOut(event:MouseEvent):void {
			_view.tooltip.text.text = '';
			_view.tooltip.x = 0; 
			_view.tooltip.y = -_view.tooltip.height; 
		}
	}
}