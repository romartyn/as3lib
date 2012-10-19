package utils {
	import flash.external.ExternalInterface;
	
	public class Console {
		
		public function Console(){
			return;
		}
		
		public static function log(data:*):void {
			if(ExternalInterface.available) {
				ExternalInterface.call('console.log', data);
			}
		}
	}
}