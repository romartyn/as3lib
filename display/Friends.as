package display {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import net.Connector;
	
	import renderers.FriendsListRenderer;
	
	import utils.Console;
	
	public class Friends extends Sprite {
		
		private var _stage:Stage;
		private var _view:*;
		private var _data:*;
		
		public function Friends() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_view = new friendsView;
			_view.title.text = 'Друзья';
			render();
		}
		
		public function update(data:*):void {
			var friends:Object = Connector.social.getProfiles({prop : 'isFriend', value : true});
			Console.log(friends);
			var count:int = 1;
			var pos:Object = {x : 2, y : 2};
			for(var prop:* in friends) {
				var renderer:FriendsListRenderer = new FriendsListRenderer();
				renderer.x = pos.x;
				renderer.y = pos.y;
				renderer.update(friends[prop]);
				_view.content.addChild(renderer);
				pos = {x : pos.x, y : parseInt(pos.y + 80 + count * 2)};
				count++;
			}
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
	}
}