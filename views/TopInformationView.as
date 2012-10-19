package views {
	
	import display.TopInformation;
	
	import flash.display.Sprite;
	
	public class TopInformationView extends Sprite implements IView {
		
		private var _view:TopInformation;
		
		public function TopInformationView() {
			return;
		}
		
		public function setView(view:*):void {
			_view = view;
			addChild(_view);
		}
		
		public function update(data:*):void {
			_view.update(data);
		}
	}
}