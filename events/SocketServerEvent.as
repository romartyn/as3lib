package events {
	
	import flash.events.Event;
	
	public class SocketServerEvent extends Event {
		
		public static const CONNECTED:String = 'connected';
		public static const DISCONNECTED:String = 'disconnected';
		public static const LOGIN:String = 'login';
		public static const LOGOUT:String = 'logout';
		public static const USER:String = 'user';
		public static const MAP:String = 'map';
		public static const FIGHT:String = 'fight';
		public static const DATA:String = 'data';
		public static const ERROR:String = 'error';
		public static const DATAERROR:String = 'data error';
		private var _data:Object;
		private var _error:Object;
		
		public function SocketServerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public function set data(data:*):void {
			if(data != null) _data = data;
		}
		
		public function get data():* {
			if(_data == null) return null;
			return _data;
		}
	}
}