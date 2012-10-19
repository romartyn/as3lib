package display {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.Connector;
	
	import views.MainView;
	
	public class Fight extends Sprite {
		
		private var _stage:Stage;
		private var _view:*;
		private var _data:*;
		
		public function Fight() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_view = new fightView;
			_view.title.text = 'Бой';
			//_view.hero1.userName.text = ;
			_view.hero1.body.buttonMode = true;
			_view.hero1.body.addEventListener(MouseEvent.CLICK, onMouseEvents);
			_view.hero2.body.buttonMode = true;
			_view.hero2.body.addEventListener(MouseEvent.CLICK, onMouseEvents);
			_view.hero1.hp.stop();
			_view.hero2.hp.stop();
			render();
		}
		
		public function update(data:*):void {
			_data = data;
			_view.hero1.hp.gotoAndStop((_data.fight.users[0].health != null) ? _data.fight.users[0].health : 100);
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
						case _view.hero2.body:
							Connector.socket.addTask('shot', null, onShot);
							break;
					}
					break;
			}
		}
		
		protected function onShot(data:*):void {
			trace(data.d);
			if(data.e != null) {
				MainView.infoMessage.show('Сообщение', data.d);
			}
			else {
				update(data.response);
			}
		}
	}
}