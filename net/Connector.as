package net {
	
	import flash.events.EventDispatcher;
	
	import valueobjects.FlashVars;
	
	public class Connector extends EventDispatcher {
		
		public static var _flashVars:FlashVars;
		public static var _users:Object;
		public static var _social:Social;
		public static var _socket:SocketServer;
		
		public function Connector() {
			return;
		}
		
		public static function init(flashVars:FlashVars):void {
			_flashVars = flashVars;
			_social = new Social();
			_socket = new SocketServer(Config.SOCKET_HOST, Config.SOCKET_PORT);
			return;
		}
		
		public static function get flashVars():Object {
			return _flashVars;
		}
		
		public static function get social():Social {
			return _social;
		}
		
		public static function get socket():SocketServer {
			return _socket;
		}
	}
}