package {
	
	import display.ErrorMessage;
	import display.Fight;
	import display.Friends;
	import display.InfoMessage;
	import display.Map;
	import display.PreFight;
	import display.TopInformation;
	
	import events.LibraryManagerEvent;
	import events.SocialEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import net.Connector;
	
	import utils.Console;
	import utils.LibraryManager;
	import utils.ResourceManager;
	
	import valueobjects.FlashVars;
	
	import views.FightView;
	import views.FriendsView;
	import views.GangView;
	import views.InfoMessageView;
	import views.MainView;
	import views.MapView;
	import views.PreFightView;
	
	[SWF(width='807', height='730', backgroundColor='0xffffff', frameRate='25')]
	
	public class Index extends Sprite {
		
		private var _libraryManager:LibraryManager;
		private var _resourceManager:ResourceManager;
		
		public function Index() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//
		private function init():void {
			var flashVars:FlashVars = new FlashVars();
			//flashVars.bind((loaderInfo.parameters != null) ? loaderInfo.parameters : {});
			//flashVars.bind({viewer_id : 733093});
			flashVars.bind({viewer_id : 322220});
			loadLibraries();
			Console.log(flashVars);
			Connector.init(flashVars);
			Connector.social.addTask('user');
			Connector.social.addTask('appFriends', null, onSocialReady);
			Connector.socket.addTask('connect');
			Connector.socket.addTask('login', Connector.social.getProfile(Connector.social.getViewerId()));
			Connector.socket.addTask('user', null, updateUser);
			//Connector.socket.addTask('friends', Connector.social.getProfiles());
			//Connector.socket.addTask('map', null, updateMap);
			//Connector.socket.addTask('wait', null, onServerData);
		}
		private function loadLibraries():void {
			_libraryManager = new LibraryManager();
			_libraryManager.addEventListener(LibraryManagerEvent.LOADED, onLibraryManagerLoaded);
			_libraryManager.addEventListener(LibraryManagerEvent.PROGRESS, onLibraryManagerProgress);
			_libraryManager.addEventListener(LibraryManagerEvent.ERROR, onLibraryManagerError);
			_libraryManager.load(Config.LIBRARYES);
		}
		private function initInterface():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.NORMAL;
			MainView.init(stage);
			MainView.infoMessage.setView(new InfoMessage);
			MainView.errorMessage.setView(new ErrorMessage);
			MainView.topInformation.setView(new TopInformation);
			MainView.map.setView(new Map);
			MainView.friends.setView(new Friends);
			MainView.preFight.setView(new PreFight);
			MainView.fight.setView(new Fight);
			MainView.setState('friends');
			MainView.friends.update({});
		}
		//
		protected function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
		}
		//
		protected function onStageEnterFrame(event:Event):void {
			stage.removeEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			init();
		}
		//----------------------------------------- Library manager -----------------------------------------
		protected function onLibraryManagerLoaded(event:LibraryManagerEvent):void {
			_libraryManager.removeEventListener(LibraryManagerEvent.LOADED, onLibraryManagerLoaded);
			_libraryManager.removeEventListener(LibraryManagerEvent.PROGRESS, onLibraryManagerProgress);
			_libraryManager.removeEventListener(LibraryManagerEvent.ERROR, onLibraryManagerError);
			_libraryManager = null;
			//stage.removeChild(_preloader);
			//_preloader = null;
			initInterface();
		}
		protected function onLibraryManagerProgress(event:LibraryManagerEvent):void {
			var pos:int;
			if(event.progress.progress >= 100) pos = 100;
			else pos = event.progress.progress;
			//if(_preloader != null) {
				//_preloader.gotoAndStop(pos);
			//}
			//trace(event.progress.progress);
		}
		protected function onLibraryManagerError(event:LibraryManagerEvent):void {
			trace(event.error.text);
			//Console.log(event.error.text);
		}
		//----------------------------------------- Library manager -----------------------------------------
		//----------------------------------------- -----------------------------------------
		protected function onSocialReady():void {

		}
		protected function updateMap(data:*):void {
			if(MainView.map != null) MainView.map.update(data);
		}
		protected function updateUser(data:*):void {
			if(MainView.topInformation != null) MainView.topInformation.update(data);
			var user:* = Connector.socket.getProfile(Connector.socket.getViewerId());
			trace(Connector.socket.getViewerId());
		}
		protected function onServerData(data:*):void {
			trace(data as String);
		}
		//----------------------------------------- -----------------------------------------
		//----------------------------------------- -----------------------------------------
	}
}