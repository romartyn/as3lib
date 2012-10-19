package display {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.Connector;
	
	import views.MainView;
	
	public class PreFight extends Sprite {
		
		private var _stage:Stage;
		private var _view:*;
		private var _data:*;
		
		public function PreFight() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_view = new preFightView;
			_view.title.text = 'Подготовка';
			_view.acceptBtn.visible = false;
			_view.fightBtn.addEventListener(MouseEvent.CLICK, onMouseEvents);
			_view.cancelBtn.addEventListener(MouseEvent.CLICK, onMouseEvents);
			render();
			return;
		}
		
		public function update(data:*):void {
			_data = data;
		}
		
		private function render():void {
			addChild(_view);
		}
		
		protected function onAddedToStage(event:Event):void {
			_stage = stage;
			_stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		protected function onStageResize(event:Event):void {
			
		}
		
		protected function onMouseEvents(event:MouseEvent):void {
			switch(event.type) {
				case MouseEvent.CLICK:
					switch(event.currentTarget) {
						case _view.fightBtn:
							Connector.socket.addTask('attack', null, onAttack);
							break;
						case _view.cancelBtn:
							trace('cancel');
							break;
					}
					break;
			}
		}
		
		protected function onAttack(data:*):void {
			trace(data.d);
			if(data.e != null) {
				MainView.infoMessage.show('Сообщение', data.d);
			}
			else {
				var user1:* = Connector.socket.getProfile(Connector.socket.getViewerId());
				var user2:* = Connector.socket.getProfile(Connector.socket.getViewerId());
				MainView.fight.update([user1, user2]);
				MainView.setState('fight');
			}
		}
	}
}