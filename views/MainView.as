package views {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class MainView extends Sprite {
		
		public static var _stage:Stage;
		public static var _instance:MainView;
		public static var _infoMessageView:InfoMessageView;
		public static var _errorMessageView:ErrorMessageView;
		public static var _topInformationView:TopInformationView;
		public static var _rightMenu:*;
		public static var _gangView:GangView;
		public static var _friendsView:FriendsView;
		public static var _mapView:MapView;
		public static var _preFightView:PreFightView;
		public static var _fightView:FightView;
		
		public function MainView(stage:Stage = null) {
			return;
		}
		
		public static function init(stage:Stage):void {
			_stage = stage;
			_infoMessageView = new InfoMessageView();
			_errorMessageView = new ErrorMessageView();
			_topInformationView = new TopInformationView();
			_rightMenu = new rightMenu();
			_rightMenu.x = MainView.stage.stageWidth;
			_gangView = new GangView();
			_friendsView = new FriendsView();
			_mapView = new MapView();
			_preFightView = new PreFightView();
			_fightView = new FightView();
		}
		
//		public static function set stage(view:Stage):void {
//			_stage = view;
//		}
		
		public static function get stage():Stage {
			return _stage;
		}
		
//		public static function set infoMessage(view:InfoMessageView):void {
//			_infoMessageView = view;
//		}
		
		public static function get infoMessage():InfoMessageView {
			return _infoMessageView;
		}
		
//		public static function set errorMessage(view:ErrorMessageView):void {
//			_errorMessageView = view;
//		}
		
		public static function get errorMessage():ErrorMessageView {
			return _errorMessageView;
		}
		
//		public static function set topInformation(view:TopInformationView):void {
//			_topInformationView = view;
//		}
		
		public static function get topInformation():TopInformationView {
			return _topInformationView;
		}
		
//		public static function set map(view:MapView):void {
//			_mapView = view;
//		}
		
		public static function get map():MapView {
			return _mapView;
		}
		
//		public static function set friends(view:FriendsView):void {
//			_friendsView = view;
//		}
		
		public static function get friends():FriendsView {
			return _friendsView;
		}
		
//		public static function set preFight(view:PreFightView):void {
//			_preFightView = view;
//		}
		
		public static function get preFight():PreFightView {
			return _preFightView;
		}
		
//		public static function set fight(view:FightView):void {
//			_fightView = view;
//		}
		
		public static function get fight():FightView {
			return _fightView;
		}

		public static function setState(name:String = null):void {
			if(name == null) return;
			MainView.clearState();
			switch(name.toLowerCase()) {
				case 'welcome':
					break;
				case 'map':
					MainView.stage.addChild(_mapView);
					MainView.stage.addChild(_topInformationView);
					MainView.stage.addChild(_rightMenu);
					break;
				case 'friends':
					MainView.stage.addChild(_friendsView);
					break;
				case 'prefight':
					MainView.stage.addChild(_preFightView);
					break;
				case 'fight':
					MainView.stage.addChild(_fightView);
					break;
			}
		}
		
		public static function clearState():void {
			if(_stage != null) {
				if(MainView.stage.contains(_topInformationView)) MainView.stage.removeChild(_topInformationView);
				if(MainView.stage.contains(_rightMenu)) MainView.stage.removeChild(_rightMenu);
				if(MainView.stage.contains(_mapView)) MainView.stage.removeChild(_mapView);
				if(MainView.stage.contains(_friendsView)) MainView.stage.removeChild(_friendsView);
				if(MainView.stage.contains(_preFightView)) MainView.stage.removeChild(_preFightView);
				if(MainView.stage.contains(_fightView)) MainView.stage.removeChild(_fightView);
			}
		}
	}
}