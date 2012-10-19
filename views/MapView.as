package views {
	
	import display.Map;
	
	import flash.display.Sprite;
	
	public class MapView extends Sprite implements IView {
		
		private var _view:Map;
		
		public function MapView() {
			return;
		}
		
		public function setView(view:*):void {
			_view = view;
			addChild(_view);
		}
		
		public function update(data:*):void {
			_view.load(data);
		}
	}
}