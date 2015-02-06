package  {
    import flash.display.Stage;
    import flash.events.Event;
	
	public class GameData {

		public function GameData(stage) {
			// constructor code
		}
		
		public static var STAGE_WIDTH:int = 960;
		public static var STAGE_HEIGHT:int = 640;
		
		public static var SELECTED:int = -1;
		public static var SEL_speed:Number = 0;
		
		public static var Diff:Number = 0;
		
		public static var camSpeed:Number = 5;
		public static var camMoveX:String = "";
		public static var camMoveY:String = "";
		public static var camPosX:Number = 0;
		public static var camPosY:Number = 0;
		
		public static var ICONSIZE:Number = 50;
		public static var ICONS:int = 0;
		public static var ENTITYSIZE:Number = 1.5;
	}
	
}
