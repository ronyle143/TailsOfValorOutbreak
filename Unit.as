package  {
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.*;
	
	public class Unit extends Sprite{
		
		public var ent:Sprite;
		
		public var SELECTED:Boolean = false;
		public var UNIT_ID:int = 0;
		
		public var Move_x:int;
		public var Move_y:int;
		
		public var speed:Number = 1;
		public var xspd:Number;
		public var yspd:Number;
		public var tolerance:Number = 5;
		
		public function Unit(ent_id:String="grenadier") {
			ent = UnitType.getSprite(ent_id);
			speed = UnitType.speed;
			
			
			addChild(ent);
			
			addEventListener(MouseEvent.MOUSE_DOWN, selected);
			addEventListener(Event.ENTER_FRAME, move);
		}
		
		public function selected(e:MouseEvent):void{
			SELECTED = true;
			GameData.SELECTED = UNIT_ID;
		}
		
		public function move(e:Event):void{
			var xdis:Number = Move_x  - this.x;
			var ydis:Number = Move_y  - this.y;
			var disangle:Number = Math.atan2(ydis,xdis);
			
			xspd=Math.cos(disangle) * speed;
			yspd=Math.sin(disangle) * speed;
			
			/*if((this.y < Move_y -tolerance) || (this.y > Move_y +tolerance)){
				this.y+= yspd;
			}
			if((this.x < Move_x -tolerance) || (this.x > Move_x +tolerance)){
				this.x+= xspd;
			}//*/
			
			if(this.y < Move_y +tolerance){
				this.y+= yspd;
			}else
			if(this.y > Move_y -tolerance){
				this.y+= yspd;
			}
			if(this.x < Move_x -tolerance){
				this.x+= xspd;
			}else
			if(this.x > Move_x +tolerance){
				this.x+= xspd;
			}//*/
			
			/*if(this.y < Move_y -tolerance){
				this.y += speed * (1 - calculateX());
			}else
			if(this.y > Move_y +tolerance){
				this.y -= speed * (1 - calculateX());
			}
			if(this.x < Move_x -tolerance){
				this.x += speed * calculateX();
			}else
			if(this.x > Move_x +tolerance){
				this.x -= speed * calculateX();
			}//*/
		}
		
		public function calculateX():Number{
			var percent:Number = 1;
			if(this.rotation <= 90 && this.rotation >= -90){
				percent = (this.rotation/0.9);
			}else if(this.rotation <= 180 && this.rotation > 90){
				percent = ((180 - this.rotation)/0.9);
			}else if(this.rotation >= -180 && this.rotation < -90){
				percent = ((180 + this.rotation)/0.9);
			}
			var percent1 = Math.abs(percent / 100);
			return percent1;
		}
		
		public function face():void{
			// find out mouse coordinates to find out the angle
			var cy:Number = Move_y - this.y; 
			var cx:Number = Move_x - this.x;
			// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
			// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
			// rotate
			ent.rotation = Degrees+90;
		}
	}
}
