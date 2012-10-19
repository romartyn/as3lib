package views {
	
	import display.InfoMessage;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class InfoMessageView extends Sprite implements IView {
		
		private var _view:InfoMessage;
		private var _timer:Timer;
		
		public function InfoMessageView() {
			return;
		}
		
		public function setView(view:*):void {
			_view = view;
			addChild(_view);
		}
		
		public function update(data:*):void {
			_view.update(data);
		}
		
		public function show(title:String = '', text:String = '', timer:uint = 3000, callBack:Function = null):void {
			if(MainView.stage.contains(MainView.infoMessage)) MainView.stage.removeChild(MainView.infoMessage);
			if(_timer == null) _timer = new Timer(timer, 1);
			if(_timer.running) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
			MainView.infoMessage.update({'title' : title, 'text' : text});
			MainView.infoMessage.x = MainView.stage.stageWidth / 2 - MainView.infoMessage.width / 2; 
			MainView.infoMessage.y = MainView.stage.stageHeight / 2 - MainView.infoMessage.height / 2; 
			MainView.stage.addChild(MainView.infoMessage);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
		}
		
		public function hide():void {
			if(MainView.stage.contains(MainView.infoMessage)) MainView.stage.removeChild(MainView.infoMessage);
		}
		
		protected function onTimerComplete(event:TimerEvent):void {
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			hide();
		}
	}
}