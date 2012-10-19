package events {
	
	import flash.events.Event;
	
	public class ResourceManagerEvent extends Event {
		
		public static const LOADED:String = 'loaded';
		public static const ERROR:String = 'error';
		
		private var _error:Object;
		
		public function ResourceManagerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function set error(error:Object):void {
			_error = error;
		}
		
		public function get error():Object {
			if(_error == null) _error = new Object();
			return _error;
		}
	}
}