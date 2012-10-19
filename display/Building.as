package display {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Building extends Sprite {
		
		public var _id:String;
		public var _lid:String;
		public var _iid:int;
		public var _inc:String;
		public var _bots:String;
		public var _title:String;
		public var _desc:String;
		public var _mask:Sprite; 
		public var _default:Sprite;
		public var _hover:Sprite;
		public var _icon:Sprite;
		
		public function Building(building:Object = null, icon:Object = null, params:Object = null) {
			if(building != null) {
				_id = building.id;
				_lid = building.lid;
				_iid = building.iid;
				_inc = building.inc;
				_bots = building.bots;
				_title = building.title;
				_desc = building.desc;
				_default = new Sprite();
				_default.addChild(building.default);
				addChild(_default);
				_hover = new Sprite();
				_hover.addChild(building.hover);
				_hover.visible = false;
				addChild(_hover);
				addEventListener(MouseEvent.MOUSE_OVER, buildingMouseOverHandler);
				addEventListener(MouseEvent.MOUSE_OUT, buildingMouseOutHandler);
			}
			if(icon != null) {
				_icon = new Sprite();
				_icon.addChild(icon.default);
				_icon.x = 0;
				_icon.y = - (height / 2 + _icon.height);
				_icon.buttonMode = true;
				addChild(_icon);
			}
			if(params != null) {
				x = params.x;
				y = params.y;
			}
		}
		public function set icon(data:Sprite):void {
			removeChild(_icon);
			_icon = new Sprite();
			_icon.addChild(data);
			_icon.x = 0;
			_icon.y = - (height / 2 + _icon.height);
			_icon.buttonMode = true;
			_icon.mouseEnabled = true;
			addChild(_icon);
		}
		public function get icon():Sprite {
			return _icon;
		}
		public function get id():String {
			return _id;
		}
		public function get lid():String {
			return _lid;
		}
		public function get inc():String {
			return _inc;
		}
		public function set iid(id:int):void {
			_iid = id;
		} 
		public function get iid():int {
			return _iid;
		} 
		public function get bots():String {
			return _bots;
		}
		protected function buildingMouseOverHandler(event:MouseEvent):void {
			_default.visible = false;
			_hover.visible = true;
			event.updateAfterEvent();
		}
		protected function buildingMouseOutHandler(event:MouseEvent):void {
			_default.visible = true;
			_hover.visible = false;
			event.updateAfterEvent();
		}
	}
}