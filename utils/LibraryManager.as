package utils {
	
	import events.LibraryManagerEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class LibraryManager extends EventDispatcher {
		
		private var _list:Array;
		private var _count:int;
		private var _loadedCount:int = 0;
		private var _activeIndex:int;
		private var _total:int = 100;
		private var _progress:int = 0;
		private var _progressPos:int = 0;
		private var _loader:Loader;
		private var _context:LoaderContext;
		
		public function LibraryManager() {
			return;
		}
		
		public function load(list:Array):void {
			_list = list;
			_count = _list.length;
			_loadedCount = 0;
			_activeIndex = 0;
			loading();
		}
		
		private function loading():void {
			if(_activeIndex < _count) {
				loadLibrary(_activeIndex);
			}
			else {
				var eObj:LibraryManagerEvent = new LibraryManagerEvent(LibraryManagerEvent.LOADED, true, false);
				dispatchEvent(eObj);
			}
		}
		
		private function loadLibrary(index:int):void {
			_context = new LoaderContext();
			_context.applicationDomain = ApplicationDomain.currentDomain;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadLibraryComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadLibraryProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadLibraryIOError);
			_loader.load(new URLRequest(_list[_activeIndex]), _context);
		}
		
		protected function onLoadLibraryComplete(event:Event):void {
			_activeIndex++;
			_loadedCount++;
			loading();
		}
		
		protected function onLoadLibraryProgress(event:ProgressEvent):void {
			var eObj:LibraryManagerEvent = new LibraryManagerEvent(LibraryManagerEvent.PROGRESS, true, false);
			if(_progressPos >= Math.round(_total / _count)) _progressPos = 0;
			var progress:int = Math.round( Math.round(_total / _count) * (( Math.round((event.bytesLoaded / event.bytesTotal) * 100) ) / 100));
			_progress += progress - _progressPos;
			_progressPos = progress;
			eObj.progress.loaded = _loadedCount;
			eObj.progress.progress = _progress;
			dispatchEvent(eObj);
		}
		
		protected function onLoadLibraryIOError(event:IOErrorEvent):void {
			var eObj:LibraryManagerEvent = new LibraryManagerEvent(LibraryManagerEvent.ERROR, true, false);
			eObj.error.text = event.text;
			dispatchEvent(eObj);
		}
	}
}