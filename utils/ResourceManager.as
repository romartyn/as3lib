package utils {
	
	import events.ResourceManagerEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class ResourceManager extends EventDispatcher {
		
		private var _list:*;
		private var _loader:Loader;
		private var _context:LoaderContext;
		
		public function ResourceManager() {
			return;
		}
		
		public function load(list:*):void {
			_list = list;
			loading();
		}
		
		private function loading():void {
			loadResource();
		}
		
		private function loadResource():void {
			_context = new LoaderContext();
			_context.applicationDomain = ApplicationDomain.currentDomain;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadResourceComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadResourceIOError);
			_loader.load(new URLRequest(_list), _context);
		}
		
		protected function onLoadResourceComplete(event:Event):void {
			var eObj:ResourceManagerEvent = new ResourceManagerEvent(ResourceManagerEvent.LOADED, true, false);
			dispatchEvent(eObj);
		}
		
		protected function onLoadResourceIOError(event:IOErrorEvent):void {
			var eObj:ResourceManagerEvent = new ResourceManagerEvent(ResourceManagerEvent.ERROR, true, false);
			eObj.error.text = event.text;
			dispatchEvent(eObj);
		}
	}
}