package valueobjects {
	
	public class FlashVars extends Object {
		
		public var apiUrl:String;
		public var apiId:int;
		public var sId:String;
		public var vk:int;
		
		public function FlashVars() {
			return;
		}
		
		public function bind(data:*):void {
			try {
				vk = (data.viewer_id != null) ? parseInt(data.viewer_id) : 0;
			}
			catch(error:Error) {
				trace(error.message);
			}
		}
	}
}