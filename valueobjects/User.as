package valueobjects {
	
	public class User extends Object {
		
		public var id:int;
		public var vk:int;
		public var fb:int;
		public var gb:int;
		public var firstName:String;
		public var lastName:String;
		public var nickName:String;
		public var level:int;
		public var experiens:Object;
		public var points:int;
		public var cashPoints:int;
		public var isViewer:Boolean;
		public var isFriend:Boolean;
		
		public function User() {
			return;
		}
		
		public function bind(data:*):void {
			try {
				id = (data.id != null) ? data.id : 0;
				vk = (data.vk != null) ? data.vk : 0;
				fb = (data.fb != null) ? data.fb : 0;
				gb = (data.gb != null) ? data.gb : 0;
				firstName = (data.first_name != null) ? data.first_name : '';
				lastName = (data.last_name != null) ? data.last_name : '';
				nickName = (data.nickname != null) ? data.nickname : '';
				level = (data.le != null) ? data.le : 0;
				experiens = (data.ex != null) ? data.ex : null;
				points = (data.po != null) ? data.po : 0;
				cashPoints = (data.cp != null) ? data.cp : 0;
			}
			catch(e:Error) {
				trace(e.message);
			}
		}
	}
}