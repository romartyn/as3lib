package net {
	
	import events.SocialEvent;
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	import utils.Console;
	
	import valueobjects.VKUser;
	
	public class Social extends EventDispatcher {
		
		private var _users:Object;
		private var _viewerId:int;
		private var _lastRequest:String;
		private var _lastResult:String;
		private var _tasks:Array;
		private var _activeTask:Object;
		private var _isWork:Boolean;
		
		public function Social() {
			return;
		}
		
		public function addTask(name:String, data:* = null, callBack:Function = null):void {
			if(_tasks == null) _tasks = new Array();
			_tasks.push({'name' : name, 'data' : data, 'callBack' : callBack});
			if(_isWork) return;
			start();
		}
		
		public function getViewerId():int {
			return _viewerId;
		}
		
		public function getProfile(vk:int):Object {
			var profile:Object;
			profile = (_users[vk] != null) ? _users[vk] : null;
			return profile;
		}
		
		public function getProfiles(condition:Object = null):Object {
			var profiles:Object;
			if(condition == null) profiles = (_users != null) ? _users : null;
			else {
				for(var prop:* in _users) {
					if(_users[prop][condition.prop] == condition.value) {
						if(profiles == null) profiles = new Object();
						profiles[prop] = _users[prop];
					}
				}
			}
			return profiles;
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
			switch(_activeTask.name) {
				case 'user':
					_isWork = true;
					getUser();
					break;
				case 'appFriends':
					_isWork = true;
					getAppFriends();
					break;
			}
		}
		
		private function getUser():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback('getUserData', getUserData);
				ExternalInterface.call('getUser', Connector.flashVars.vk);
			}
			else {
				var data:Object = {
					733093 : [{first_name : 'Alex', last_name : 'Elenvarenko', nickname : 'Prizrak', photo : 'http://cs11312.userapi.com/u733093/e_2ab04e4a.jpg', uid : 733093}],
					322220 : [{first_name : 'Роман', last_name : 'Мартынович', photo : "http://cs305602.userapi.com/u322220/e_74519082.jpg", uid : 322220}]
				};
				var user:VKUser = new VKUser();
				user.bind(data[Connector.flashVars.vk][0]);
				user.isViewer = true;
				_viewerId = user.vk;
				if(_users == null) _users = new Object();
				_users[Connector.flashVars.vk] = user;
				if(_activeTask.callBack != null) {
					_activeTask.callBack();
				}
				_activeTask = null;
				_isWork = false;
				start();
			}
		}
		
		private function getFriends(id:int):void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback('getFriendsData', getFriendsData);
				ExternalInterface.call('getFriends', id);
			}
			else {
				
			}
		}
		
		private function getAppFriends():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback('getAppFriendsData', getAppFriendsData);
				ExternalInterface.call('getAppFriends', Connector.flashVars.vk);
			}
			else {
				var data:Object = {
					733093 : [{first_name : 'Роман', last_name : 'Мартынович', photo : "http://cs305602.userapi.com/u322220/e_74519082.jpg", uid : 322220},{first_name : 'Илья', last_name : 'Антонов', photo : 'http://cs323926.userapi.com/u452251/e_b5d830a0.jpg', uid : 452251}],
					322220 : [{first_name : 'Alex', last_name : 'Elenvarenko', nickname : 'Prizrak', photo : 'http://cs11312.userapi.com/u733093/e_2ab04e4a.jpg', uid : 733093}]
				};
				if(_users == null) _users = new Object();
				for (var prop:* in data[Connector.flashVars.vk]) {
					var user:VKUser = new VKUser();
					user.bind(data[Connector.flashVars.vk][prop]);
					user.isFriend = true;
					_users[data[Connector.flashVars.vk][prop].uid] = user;
				}
				if(_activeTask.callBack != null) {
					_activeTask.callBack();
				}
				_activeTask = null;
				_isWork = false;
				start();
			}
			return;
		}
		
		protected function getUserData(data:*):void {
			if(_users == null) _users = new Object();
			for(var prop:* in data.response) {
				var user:VKUser = new VKUser();
				user.bind(data.response[prop]);
				user.isViewer = true;
				_users[data.response[prop].uid] = user;
			}
			if(_activeTask.callBack != null) {
				_activeTask.callBack();
			}
			_activeTask = null;
			_isWork = false;
			start();
		}
		
		protected function getFriendsData(data:*):void {
		}
		
		protected function getAppFriendsData(data:*):void {
			if(_users == null) _users = new Object();
			for(var prop:* in data.response) {
				var user:VKUser = new VKUser();
				user.bind(data.response[prop]);
				user.isFriend = true;
				_users[data.response[prop].uid] = user;
				Console.log(user);
			}
			if(_activeTask.callBack != null) {
				_activeTask.callBack();
			}
			_activeTask = null;
			_isWork = false;
			start();
		}
	}
}