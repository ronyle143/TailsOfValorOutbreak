package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;

	public class ToV extends Sprite
	{
		public var STAGE_WIDTH:int = 1000;
		public var STAGE_HEIGHT:int = 500;

		public var CREATING_INF:Boolean = false;

		public var base:Sprite = new feild_barracks  ;
		public var spawn_x:Number = 0;
		public var spawn_y:Number = 0;

		public var unit_array:Array = [];

		public var ui:Sprite;
		public static var status:TextField;

		public function ToV()
		{
			addbase();
			generateui();

			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseReleaseOutside);
		}

		public function addbase():void
		{
			addChild(base);
			base.x = base.width / 2;
			base.y = base.height / 2;

			spawn_x = base.x;
			spawn_y = base.y * 2.2;
		}

		public function generateui():void
		{
			var ui_holder:Sprite = new Sprite  ;
			var ui_grenadier:Sprite = new icon_grenadier  ;
			ui_grenadier.x = (ui_grenadier.width / 2);
			ui_grenadier.y = (ui_grenadier.height / 2);
			ui_holder.addChild(ui_grenadier);
			
			var ui_scoutcar:Sprite = new icon_scoutcar  ;
			ui_scoutcar.x = ui_grenadier.width+(ui_scoutcar.width / 2);
			ui_scoutcar.y = (ui_scoutcar.height / 2);
			ui_holder.addChild(ui_scoutcar);
			
			addChild(ui_holder);

			ui_holder.y = STAGE_HEIGHT - ui_holder.height;

			ui_grenadier.addEventListener(MouseEvent.MOUSE_UP, 
				function create_0(e:MouseEvent):void {
				CREATING_INF=true;
				spawn("grenadier");
				CREATING_INF=false;
				});
			ui_scoutcar.addEventListener(MouseEvent.MOUSE_UP, 
				function create_0(e:MouseEvent):void {
				CREATING_INF=true;
				spawn("scoutcar");
				CREATING_INF=false;
				});

			status = new TextField();
			status.width = 400;
			status.x = STAGE_WIDTH - status.width;
			status.text = String(0);
			stage.addChild(status);
			addEventListener(Event.ENTER_FRAME,loop);
		}
		
		public function loop(e:Event):void{
			ToV.status.text = "["+unit_array.length+"]"+GameData.SELECTED + 
			"\n <"+GameData.SEL_rot+"> ROTATION" + 
			"\n <"+GameData.SEL_x+"> PERCENT" +
			"\n {"+GameData.SEL_speed+"} SPEED";
		}

		public function spawn(ent_id:String):void
		{
			var ent:Unit = new Unit(ent_id);
			ent.UNIT_ID = unit_array.push(ent)-1;
			ent.Move_x = spawn_x;
			ent.x = ent.Move_x;
			ent.Move_y = spawn_y;
			ent.y = ent.Move_y;
			addChild(ent);
		}

		private function onMouseReleaseOutside(e:MouseEvent):void
		{
			if (GameData.SELECTED >= 0)
			{
				unit_array[GameData.SELECTED].Move_x = mouseX;
				unit_array[GameData.SELECTED].Move_y = mouseY;
				unit_array[GameData.SELECTED].face();
				unit_array[GameData.SELECTED].SELECTED = false;
				GameData.SEL_x = unit_array[GameData.SELECTED].calculateX();
				GameData.SEL_rot = unit_array[GameData.SELECTED].rotation;
				GameData.SEL_speed = unit_array[GameData.SELECTED].speed * GameData.SEL_x;
				GameData.SELECTED = -1;
			}
		}
	}
}