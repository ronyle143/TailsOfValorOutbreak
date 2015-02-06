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
		public var map:Sprite = new maps;
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

			field.addEventListener(MouseEvent.MOUSE_UP, onMouseReleaseInside);
			stage.addEventListener(Event.ENTER_FRAME, keyBind);
		}
		
		public function keyBind(e:Event):void{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}

		public function addbase():void
		{
			field.addChild(map);
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
			ui_holder.addChild(addIcon("wyatt", new icon_wyatt));
			
			
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
			
			if(field.x <= 1  && field.x >= (-map.width+STAGE_WIDTH)){
				if(GameData.camMoveX == "left"){
						field.x += GameData.camSpeed;
						GameData.camPosX = field.x;
				}else if(GameData.camMoveX == "right"){
						field.x -= GameData.camSpeed;
						GameData.camPosX = field.x;
				}
				if(!(field.x < 0 )){
					field.x=0;
					GameData.camPosX = field.x;
				}
				if(!(field.x > (-map.width+STAGE_WIDTH))){
						field.x=(-map.width+STAGE_WIDTH);
						GameData.camPosY = field.y;
				}
			}
			
			if(field.y <= 1 && field.y >= (-map.height+STAGE_HEIGHT)){
				if(GameData.camMoveY == "up"){
						field.y += GameData.camSpeed;
						GameData.camPosY = field.y;
				}else if(GameData.camMoveY == "down"){
						field.y -= GameData.camSpeed;
						GameData.camPosY = field.y;
				}
				if(!(field.y < 0 )){
						field.y=0;
						GameData.camPosY = field.y;
				}
				if(!(field.y > (-map.height+STAGE_HEIGHT))){
						field.y=(-map.height+STAGE_HEIGHT);
						GameData.camPosY = field.y;
				}
			}
			
			
			ToV.status.text = "["+unit_array.length+"]"+GameData.SELECTED +
			"\n {"+GameData.SEL_speed+"} SPEED" +
			"\n X="+GameData.camPosX+
			"\n Y="+GameData.camPosY+
			"\n D="+GameData.Diff ;
		}
		
		public function onKeyPress( e:KeyboardEvent ):void{
				// [A] or [<]
				if ( e.keyCode == 65 || e.keyCode == 37 )
				{
					GameData.camMoveX = "left";
				}else
				// [D] or [>]
				if ( e.keyCode == 68 || e.keyCode == 39 )
				{
					GameData.camMoveX = "right";
				}
				
				// [W] or [^]
				if ( e.keyCode == 87 || e.keyCode == 38 )
				{
					GameData.camMoveY = "up";
				}else
				// [S] or [v]
				if ( e.keyCode == 83 || e.keyCode == 40 )
				{
					GameData.camMoveY = "down";
				}
		}
		
		public function onKeyRelease( e:KeyboardEvent ):void{
				// [A] or [<]
				if ( e.keyCode == 65 || e.keyCode == 37 )
				{
					GameData.camMoveX = "";
				}else
				// [D] or [>]
				if ( e.keyCode == 68 || e.keyCode == 39 )
				{
					GameData.camMoveX = "";
				}
				
				// [W] or [^]
				if ( e.keyCode == 87 || e.keyCode == 38 )
				{
					GameData.camMoveY = "";
				}else
				// [S] or [v]
				if ( e.keyCode == 83 || e.keyCode == 40 )
				{
					GameData.camMoveY = "";
				}
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
			ent.MOVING=false;
		}

		private function onMouseReleaseInside(e:MouseEvent):void
		{
			if (GameData.SELECTED >= 0)
			{
				unit_array[GameData.SELECTED].Move_x = mouseX;
				GameData.Diff = (field.x - unit_array[GameData.SELECTED].FldX);
				unit_array[GameData.SELECTED].Move_y = mouseY;
				unit_array[GameData.SELECTED].face();
				unit_array[GameData.SELECTED].SELECTED = false;
				GameData.SEL_speed = unit_array[GameData.SELECTED].speed;
				GameData.SELECTED = -1;
			}
		}
	}
}