package display {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class InfoMessage extends Sprite {
		
		private var _stage:Stage;
		private var _view:*;
		private var _data:*;
		
		public function InfoMessage() {
			_view = new infoMessage;
			_view.title.text = '';
			_view.text.text = '';
			render();
			return;
		}
		
		public function update(data:*):void {
			_view.title.text = (data.title != null) ? data.title : '';
			_view.text.text = (data.text != null) ? data.text : '';
		}
		
		private function render():void {
			addChild(_view);
		}
	}
}