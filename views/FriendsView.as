package views {
	
	import display.Friends;
	
	import flash.display.Sprite;
	
	public class FriendsView extends Sprite implements IView {
		
		private var _view:Friends;
		
		public function FriendsView() {
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