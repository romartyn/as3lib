package views {
	
	import display.ErrorMessage;
	
	import flash.display.Sprite;
	
	public class ErrorMessageView extends Sprite implements IView {
		
		private var _view:ErrorMessage;
		
		public function ErrorMessageView() {
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