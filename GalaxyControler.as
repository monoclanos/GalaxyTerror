package 
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Physics.PhysicsControler;
	
	public class GalaxyControler extends MovieClip 
	{		
		public function GalaxyControler() 
		{
			//this.addEventListener(MouseEvent.CLICK, clickControler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downControler);
			this.addEventListener(MouseEvent.MOUSE_UP, upControler);
			for (var i:int = 1; i <= 7; i++ )
			{
			this["d" + i].border = this["bord"];
			this["b" + i].flyTarget = this["myShip"];
			}
		}
		
		private function clickControler(e:MouseEvent):void
		{
			if (e.target.parent is PhysicsControler)
			{
				this["d1"].startFly();
			}
		}
		
		private function downControler(e:MouseEvent):void
		{
			if (e.target.parent is PhysicsControler)
			{
				e.target.parent.mouseStart();
			}
		}
		
		private function upControler(e:MouseEvent):void
		{
			if (e.target.parent is PhysicsControler)
			{
				e.target.parent.mouseStop();
			}
		}
	}
	
}
