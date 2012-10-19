package events {
	
	import flash.events.Event;
	
	public class LibraryManagerEvent extends Event {
		
		public static const LOADING:String = 'loading';
		public static const LOADED:String = 'loaded';
		public static const PROGRESS:String = 'progress';
		public static const ERROR:String = 'error';
		
		private var _error:Object;
		
		private var _progress:Object;
		private var _libraryIndex:int;
		private var _libraryLoaded:int;
		private var _libraryProgress:Object;
		
		public function LibraryManagerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function set error(error:Object):void {
			_error = error;
		}
		
		public function get error():Object {
			if(_error == null) _error = new Object();
			return  _error;
		}
		
		public function set progress(progress:Object):void {
			
		}
		
		public function get progress():Object {
			if(_progress == null) _progress = new Object();
			return _progress;
		}
	}
}