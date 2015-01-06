package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;

	public class ToV extends Sprite
	{
		public var STAGE_WIDTH:int = GameData.STAGE_WIDTH;
		public var STAGE_HEIGHT:int = GameData.STAGE_HEIGHT;

		public var CREATING_INF:Boolean = false;

		public var base:Sprite = new field_barracks  ;
		public var spawn_x:Number = 0;
		public var spawn_y:Number = 0;

		public var field:Sprite = new Sprite;

		public var unit_array:Array = [];

		public var ui:Sprite;
		public static var status:TextField;

		public function ToV()
		{
			init();
		}
		
		public function init():void{
			addbase();
			generateui();

			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseReleaseOutside);
		}

		public function addbase():void
		{
			field.addChild(base);
			addChild(field);
			base.width = 160 * 0.9;
			base.height = 230 * 0.9;
			base.x = base.width / 2;
			base.y = base.height / 2;

			spawn_x = base.x;
			spawn_y = base.y * 2.2;
		}
		
		public function addIcon(x,y):Sprite{
			var ui_icon:Sprite = y  ;
			ui_icon.width = GameData.ICONSIZE;
			ui_icon.height = GameData.ICONSIZE;
			ui_icon.x = (ui_icon.width / 2)+(GameData.ICONSIZE*GameData.ICONS);
			ui_icon.y = (ui_icon.height / 2);
			ui_icon.addEventListener(MouseEvent.CLICK, 
				function create_0(e:MouseEvent):void {
				CREATING_INF=true;
				spawn(x);
				CREATING_INF=false;
				});
			GameData.ICONS += 1;
			return ui_icon;
		}

		public function generateui():void
		{
			var uniformSize:int = 50;
			var ui_holder:Sprite = new Sprite  ;
			
			ui_holder.addChild(addIcon("guard", new icon_guard));
			ui_holder.addChild(addIcon("grenadier", new icon_grenadier));
			ui_holder.addChild(addIcon("scoutcar", new icon_scoutcar));
			
			
			
			addChild(ui_holder);

			ui_holder.y = STAGE_HEIGHT - ui_holder.height;
			
			status = new TextField();
			status.width = 300;
			status.x = STAGE_WIDTH - status.width;
			status.text = String(0);
			status.selectable = false;
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
			field.addChild(ent);
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