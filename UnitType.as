package  {
    import flash.display.Stage;
    import flash.display.Sprite;
	
	public class UnitType {

		public function UnitType() {
			// constructor code
		}
		
		public static var  speed:Number = 1;
		
		public static function getSprite(ent_id:String):Sprite{
			var ent:Sprite = new Sprite;
			switch(ent_id){
				case "guard":
					ent = new field_guard;
					speed = 1;
					break;
				case "grenadier":
					ent = new field_grenadier;
					speed = 1;
					break;
				case "scoutcar":
					ent = new field_scoutcar;
					speed = 3;
					break;
				case "wyatt":
					ent = new field_wyatt;
					speed = 1.2;
					break;
			}
			ent.scaleX = GameData.ENTITYSIZE;
			ent.scaleY = GameData.ENTITYSIZE;
			return ent;
		}

	}
	
}
