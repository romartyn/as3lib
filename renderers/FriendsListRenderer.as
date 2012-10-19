package renderers {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import views.MainView;
	
	public class FriendsListRenderer extends Sprite {
		
		private var _view:*;
		private var _data:*;
		
		public function FriendsListRenderer() {
			_view = new friendsRenderer;
			_view.userName.text = '';
			_view.level.text = '';
			_view.attackBtn.addEventListener(MouseEvent.CLICK, onMouseEvents);
			_view.mapBtn.addEventListener(MouseEvent.CLICK, onMouseEvents);
			render();
		}
		
		public function update(data:*):void {
			_data = data;
			_view.userName.text = _data.firstName + ' ' + _data.lastName;
			if(_data.photo != null) {
				_data.photo.x = 10;
				_data.photo.y = 10;
				_view.photo.addChild(_data.photo);
			}
		}
		
		private function render():void {
			addChild(_view);
		}
		
		protected function onMouseEvents(event:MouseEvent):void {
			switch(event.type) {
				case MouseEvent.CLICK:
					switch(event.currentTarget) {
						case _view.attackBtn:
							MainView.infoMessage.show('', _data.vk);
							break;
						case _view.mapBtn:
							MainView.infoMessage.show('Cообщение', 'Показ карты отключен, для тестирования боя.');
							break;
					}
					break;
			}
		}
	}
}