package views {
	
	import display.Fight;
	
	import flash.display.Sprite;
	
	public class FightView extends Sprite implements IView {
		
		private var _view:Fight;
		
		public function FightView():void {
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