package {
	
	public class Config extends Object {
		
		public static const DEBUG:Boolean = false;
		public static const SOCKET_HOST:String = 'lifeseries.ru';
		public static const SOCKET_PORT:uint = 88;
		public static const PRELOADER:String = 'assets/preloader_0.0.2.swf';
		public static const LIBRARYES:Array = new Array('assets/interfaces_0.0.2.swf', 'assets/textures/icons.swf', 'assets/textures/roads.swf', 'assets/textures/buildings.swf', 'assets/textures/backgrounds.swf', 'assets/textures/heroes.swf', 'assets/textures/weapons.swf', 'assets/textures/equipments.swf');
		public static const DATA:Array = new Array([{target:"buildings",content:'store/buildings.json'},{target:"weapons",content:'store/weapons.json'},{target:"equipments",content:'store/equipments.json'}]);
		
		public function Config() {
			return;
		}
	}
}