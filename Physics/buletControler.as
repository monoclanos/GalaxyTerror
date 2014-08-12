package Physics
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	
	public class buletControler extends MovieClip 
	{
		private var buletTarget:DisplayObject = null;
		
		public function buletControler() 
		{
			
		}
		
		public function set flyTarget(value:DisplayObject):void
		{
			buletTarget = value;
			var rotationMod:Number = 0;
			var catet1:Number = this.x - buletTarget.x;
			var catet2:Number = this.y - buletTarget.y;
			
			if (catet2 < 0)
			{
				catet2 *= -1;
				if(catet1<0)rotationMod += 90;
			}
			if (catet1<0)
			{
				catet1 *= -1;
				rotationMod += 180;
			}
			
			
			rotationMod += (catet2 / catet1) * 180 / 3.14;
			if (rotationMod < 0) rotationMod *= -1;
			this.rotation = rotationMod;
			trace(this.rotation);
		}
	}
	
}
