package views {
	
	import display.PreFight;
	
	import flash.display.Sprite;
	
	public class PreFightView extends Sprite implements IView {
		
		private var _view:PreFight;
		
		public function PreFightView() {
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