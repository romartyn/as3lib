package valueobjects {
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import utils.Console;

	public class VKUser extends Object {
		
		public var vk:int;
		public var firstName:String;
		public var lastName:String;
		public var nickName:String;
		public var photoUrl:String;
		public var photo:Bitmap;
		public var isViewer:Boolean;
		public var isFriend:Boolean;
		private var photoLoader:Loader;
		
		public function VKUser() {
			return;
		}
		
		public function bind(data:Object):void {
			try {
				vk = (data.uid != null) ? data.uid : 0;
				firstName = (data.first_name != null) ? data.first_name : '';
				lastName = (data.last_name != null) ? data.last_name : '';
				nickName = (data.nickname != null) ? data.nickname : '';
				photoUrl = (data.photo != null) ? data.photo : '';
				photo = new Bitmap();
			}
			catch(error:Error) {
				trace(error.message);
				Console.log(error.message);
			}
			if(photoUrl != null) {
				photoLoader = new Loader();
				photoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPhotoLoaded);
				photoLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPhotoIOError);
				photoLoader.load(new URLRequest(photoUrl));
			}
		}
		
		protected function onPhotoLoaded(event:Event):void {
			photo = photoLoader.content as Bitmap;
			photo.smoothing = true;
		}
		
		protected function onPhotoIOError(event:IOErrorEvent):void {
			Console.log(event);
		}
	}
}