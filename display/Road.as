package display {
	
	import flash.display.Sprite;
	
	public class Road extends Sprite {
		
		private var _default:Sprite;
		
		public function Road(road:Object = null, params:Object = null) {
			if(road != null) {
				_default = new Sprite();
				_default.addChild(road.default);
				addChild(_default);
			}
			if(params != null) {
				x = params.x;
				y = params.y;
			}
		}
	}
}