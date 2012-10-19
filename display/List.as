package coms {
	
	import events.ListEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class List extends Sprite {
		
		private var _parent:Sprite;
		private var _items:Object;
		private var _cols:int;
		private var _gap:int;
		private var _width:int;
		private var _height:int;
		private var _wrapper:Sprite;
		private var _mask:Sprite;
		private var _itemRenderer:*;
		
		public function List(items:Object = null, options:Object = null, itemRenderer:* = null) {
			if(items != null) _items = items;
			if(options != null) {
				if(options.cols) _cols = options.cols;
				if(options.width) _width = options.width;
				if(options.height) _height = options.height;
				if(options.gap) _gap = options.gap;
			}
			if(itemRenderer != null) _itemRenderer = itemRenderer;
			//else _itemRenderer = new ItemRenderer();
			init();
		}
		
		public function setItems(items:Object):void {
			_items = items;
			render();
		}
		
		private function init():void {
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			render();
		}
		
		private function render():void {
			if(_wrapper != null) removeChild(_wrapper);
			if(_mask != null) removeChild(_mask);
			var index:Number = 0;
			_wrapper = new Sprite();
			_mask = new Sprite();
			_wrapper.graphics.beginFill(0xffffff, 0);
			_wrapper.graphics.drawRect(0, 0, _width, _height);
			_wrapper.graphics.endFill();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, _width + 2, _height);
			_mask.graphics.endFill();
			addChild(_wrapper);
			addChild(_mask);
			_wrapper.mask = _mask;
			for each(var obj:Object in _items) {
				var bg:Sprite = new Sprite();
				var item:* = _itemRenderer.clone();
				item.setData(obj);
				item.y = index * 80 + index * _gap;
				_wrapper.addChild(item);
				index++;
			}
		}
		
		protected function mouseOverHandler(event:MouseEvent):void {
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		
		protected function mouseOutHandler(event:MouseEvent):void {
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		
		protected function mouseWheelHandler(event:MouseEvent):void {
			if(event.delta > 0) {
				if(_wrapper.y < 0) _wrapper.y += 20;
			}
			if(event.delta < 0) {
				if(_wrapper.y > (_height - _wrapper.height)) _wrapper.y -= 20;
			}
		}
	}
}