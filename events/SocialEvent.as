package events {
	
	import flash.events.Event;
	
	public class SocialEvent extends Event {
		
		public static const READY:String = 'ready';
		public static const LOADED:String = 'loaded';
		public static const USER:String = 'user';
		public static const FRIENDS:String = 'friends';
		
		private var _data:Object;
		
		public function SocialEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function set data(data:Object):void {
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}