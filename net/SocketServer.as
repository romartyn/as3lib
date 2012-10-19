package net {
	
	import events.SocketServerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import utils.json.JSON;
	
	import valueobjects.User;
	
	public class SocketServer extends EventDispatcher {
		
		private var _users:Object;
		private var _viewerId:int;
		private var _host:String;
		private var _port:int;
		private var _socket:Socket;
		private var _connected:Boolean;
		private var _lastRequest:String;
		private var _lastResult:String;
		private var _bytesAvailable:uint;
		private var _bytesTotal:uint;
		private var _bytesLoaded:uint;
		private var _tasks:Array;
		private var _activeTask:Object;
		private var _isWork:Boolean;
//		private const _reConnectTimeOut:uint = 3000;
//		private const _reConnectTry:int = 3;
//		private const _taskTimeOut:uint = 1000;
//		private const _waitTimeOut:uint = 3000;
		
		public function SocketServer(host:String = '', port:int = 0) {
			if(host != '') _host = host;
			if(port != 0) _port = port;
		}
		
		public function addTask(name:String, data:* = null, callBack:Function = null):void {
			if(_tasks == null) _tasks = new Array();
			if(_activeTask != null) {
				if(_activeTask.name == 'wait' && name != 'wait') {
					stopWaitData();
					_isWork = false;
					_tasks.unshift(_activeTask);
					_tasks.unshift({'name' : name, 'data' : data, 'callBack' : callBack});
					start();
					return;
				}
				else {
					
				}
			}
			_tasks.push({'name' : name, 'data' : data, 'callBack' : callBack});
			if(_isWork) return;
			start();
		}
		
		public function getViewerId():int {
			return _viewerId;
		}
		
		public function getProfile(id:int):Object {
			return _users[id];
		}
		
		public function getProfiles():Object {
			return _users;
		}
		
		private function start():void {
			if(_tasks.length > 0) {
				_activeTask = _tasks.shift();
				doTask();
			}
			else {
				_isWork = false;
				_tasks = null;
				_activeTask = null;
			}
		}
		
		private function stop():void {
			
		}
		
		private function doTask():void {
			var request:String = '';
			switch(_activeTask.name) {
				case 'connect':
					_isWork = true;
					connect();
					break;
				case 'login':
					_isWork = true;
					request = '{"request":{"pathname":"/login","vk":' + _activeTask.data.vk + '}}';
					sendData(request);
					break;
				case 'user':
					_isWork = true;
					request = '{"request":{"pathname":"/user"'+ ((_activeTask.data != null) ? '"vk:"' + _activeTask.data.vk : '') +'}}';
					sendData(request);
					break;
				case 'friends':
					_isWork = true;
					request = '{"request":{"pathname":"/user"}}';
					break;
				case 'map':
					_isWork = true;
					request = '{"request":{"pathname":"/map","map":0,"method":"get"}}';
					sendData(request);
					break;
				case 'building':
					_isWork = true;
					var id:int = _activeTask.data.iid;
					if(id < 6) id++;
					else id = 1;
					request = '{"request":{"pathname":"/map","map":0,"sector":1,"building":' + _activeTask.data.id + ',"iid":' + id + '}}';
					sendData(request);
					break;
				case 'attack':
					_isWork = true;
					request = '{"request":{"pathname":"/fight","attack":' + 1 + /*_activeTask.data.uid +*/ '}}';
					sendData(request);
					break;
				case 'shot':
					_isWork = true;
					request = '{"request":{"pathname":"/fight","shot":1,"target":"body"}}';
					sendData(request);
					break;
				case 'wait':
					_isWork = true;
					waitData();
					break;
			}
		}
		
		private function connect():void {
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(Event.CLOSE, onClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			_socket.connect(_host, _port);
			_activeTask = null;
		}
		
		private function close(data:*):void {
			_socket.writeUTFBytes(data);
			_socket.flush();
			_socket.close();
			_socket.removeEventListener(Event.CONNECT, onConnect);
			_socket.removeEventListener(Event.CLOSE, onClose);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			_socket = null;
			_connected = false;
		}
		
		private function sendData(data:*, func:Function = null):void {
			sendRequest(data);
		}
		
		private function waitData():void {
			trace('wait data');
			_lastResult = '';
			_bytesLoaded = 0;
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
		}
		
		private function stopWaitData():void {
			_lastResult = '';
			_bytesLoaded = 0;
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
		}
		
		private function sendRequest(data:*):void {
			_lastRequest = data;
			_lastResult = '';
			_bytesLoaded = 0;
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
			_socket.writeUTFBytes(data);
			_socket.flush();
		}
		
		protected function getControlPackage(event:ProgressEvent):void {
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, getControlPackage);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			_bytesTotal = parseInt(_socket.readUTFBytes(_socket.bytesAvailable));
		}
		
		protected function onData(event:ProgressEvent):void {
			_bytesAvailable = _socket.bytesAvailable;
			_bytesLoaded += _bytesAvailable;
			_lastResult += _socket.readUTFBytes(_socket.bytesAvailable);
			if(_bytesLoaded == _bytesTotal) {
				_socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
				trace(_lastResult);
				var obj:*;
				try {
					obj = JSON.decode(_lastResult, false);
					if(obj.e == null) {
						switch(_activeTask.name) {
							case 'login':
								_viewerId = obj.response.uid;
								break;
							case 'user':
								var user:User = new User();
								user.bind(obj.response);
								user.isViewer = true;
								if(_users == null) _users = new Object();
								_users[user.id] = user;
								break;
							case 'friends':
								break;
							case 'attack':
								break;
							case 'shot':
								break;
						}
						if(_activeTask.callBack != null) {
							if(obj.response != null) _activeTask.callBack(obj.response);
							if(obj.error != null) _activeTask.callBack(obj.error);
						}
					}
					_isWork = false;
					_activeTask = null;
					start();
				}
				catch(e:Error) {
					trace(e.message);
				}
			}
		}
		
		protected function onConnect(event:Event):void {
			_isWork = false;
			_connected = true;
			start();
		}
		
		protected function onClose(event:Event):void {
			_connected = false;
			stop();
		}
		
		protected function onIOError(event:IOErrorEvent):void {
			var eObj:SocketServerEvent = new SocketServerEvent(SocketServerEvent.ERROR, true, false);
			var data:Object = new Object();
			eObj.data = event.text;
			trace(event.text);
			dispatchEvent(eObj);
		}
		
		protected function onSecError(event:SecurityErrorEvent):void {
			var eObj:SocketServerEvent = new SocketServerEvent(SocketServerEvent.ERROR, true, false);
			var data:Object = new Object();
			eObj.data = event.text;
			trace(event.text);
			dispatchEvent(eObj);
		}
	}
}