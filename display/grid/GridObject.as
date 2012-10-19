package classes.display.grid {
	
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class GridObject extends Sprite {
		
		private var _id:Number;
		private var _states:Array;
		private var _position:Object;
		private var _textures:Array;
		public var _sprite:Sprite;
		private var loader:Loader;
		
		public function GridObject(id:Number) {
			this._id = id;
			this._sprite = new Sprite();
		}
		
		private function loadInformation():void {
		}
		
		public function loadingInfo(event:Event):void {
		}
		
		public function addState():void {
			
		}
		
		public function setPosition():void {
			
		}
		
		public function addTexture():void {
			
		}
	}
}