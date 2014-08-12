package Physics
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Bogdan
	 */
	public class PhysicsControler extends MovieClip
	{
		private var flyTimer:Timer = null;
		private var dropTimer:Timer	= new Timer(25,180);
		private var speedTimer:Timer = new Timer(50, 0);
		
		private var spead:Number = 0;
		private var flyMod:Number = 0;
		private var direction:Number = 0;
		
		private var xMod:int = 1;
		private var yMod:int = 1;
		
		private var canFlyCheck:Boolean = false;
		private var borderSpace:DisplayObject = null;
		private var mod:int = -1;
		private var jampCheck:Boolean = true;
		
		private var lastX:Number = 0;
		private var lastY:Number = 0;
		private var spedX:Number = 0;
		private var spedY:Number = 0;
		
		private var borderRect:Rectangle = null;
		
		public function PhysicsControler():void
		{
			gotoAndStop(0);
			speedTimer.addEventListener(TimerEvent.TIMER, stopDrop);
			borderSpace = new Sprite();
			borderRect = new Rectangle(0, 0, 0, 0);
		}
		
		private function stopDrop(e:TimerEvent):void
		{
			this.y += 1;	
			if (this.y > borderSpace.height)
			{
				allTimerStop();
				this.visible = false;
			}
		}
		
		public function set border(value:DisplayObject):void
		{
			borderSpace = value;
			canFlyCheck = true;
			
			borderRect = new Rectangle(borderSpace.x, borderSpace.y, borderSpace.width-this.width, borderSpace.height-this.height);
		}
		
		public function startFly():void
		{
			if (canFlyCheck)
			{
				canFlyCheck = false;
				vektorMove();
			}
		}
		
		public function mouseStart():void	
		{
			allTimerStop();
			lastX = this.x;
			lastY = this.y;
			this.startDrag(false, borderRect);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, spedometer); 
		}
		
		private function spedometer(e:MouseEvent):void
		{
			spedX = this.x - lastX;
			spedY = this.y - lastY;
			if (spedX >=0)
			{
				xMod = 1;
			}
			else
			{
				xMod = -1;
				spedX *= -1;
			}
			
			if (spedY >=0)
			{
				yMod = 1;
			}
			else
			{
				yMod = -1;
				spedY *= -1;
			}
			lastX = this.x;
			lastY = this.y;
		}
		
		public function mouseStop():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, spedometer);
			this.stopDrag();
			dropTimer.addEventListener(TimerEvent.TIMER, dropTik);
			dropTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dropStop);
			flyMod = 90;
			dropTimer.start();
		}
		
		private function dropTik(e:TimerEvent):void
		{
			borderShot(spedX * Math.sin(3.14 * flyMod / 180), spedY * Math.sin(3.14 * flyMod / 180));
			flyMod-=0.5;
		}
		
		private function dropStop(e:TimerEvent):void
		{
			dropTimer.removeEventListener(TimerEvent.TIMER, dropTik);
			dropTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, dropStop);
			speedTimer.start();
		}
		
		private function allTimerStop():void
		{
			if (flyTimer != null)
			{
				flyTimer.stop();
				flyTimer.reset();
			}
			speedTimer.stop();
			speedTimer.reset();
			dropTimer.stop();
			dropTimer.reset();
		}
		
		private function vektorMove():void
		{
			direction = Math.random();
			var directionMod:int = (100 * direction)/25;
			mod = -1;
			changeDirection(directionMod);
			
			flyMod = int((89 * Math.random()) + 1);
			
			flyTimer = new Timer(25, flyMod);
			flyTimer.addEventListener(TimerEvent.TIMER, flyTic);
			flyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, flyStop);
			flyTimer.start();
		}
		
		private function flyTic(e:TimerEvent):void
		{
			spead = 10 * Math.sin(3.14 * flyMod / 180);
			flyMod--;
			borderShot((spead * direction), (spead * (1-direction)));
		}
		
		private function borderShot(nextStepWidth:Number, nextStepHeight:Number):void
		{
			if (((this.y + this.height) + nextStepHeight * yMod) > borderSpace.height)
			{
				this.y = borderSpace.height - this.height;
				yMod *= -1;
			}
			else if ((this.y + nextStepHeight * yMod) < 0)
			{
				this.y = 0;
				yMod *= -1;
			}
			else
			{
				this.y += nextStepHeight * yMod;
			}
			
			if (((this.x + this.width) + nextStepWidth * xMod) > borderSpace.width)
			{
				this.x = borderSpace.width - this.width;
				xMod*= -1;
			}
			else if ((this.x + nextStepWidth * xMod) < 0)
			{
				this.x = 0;
				xMod*= -1;
			}
			else
			{
				this.x += nextStepWidth * xMod;
			}
		}
		
		private function changeDirection(count:int):void
		{
			var i:int = 0;
			while(i<=count)
			{
				yMod *= mod;
				mod *= -1;
				xMod *= mod;
				i++;
			}
		}
		
		private function flyStop(e:TimerEvent):void
		{
			canFlyCheck = true;
			speedTimer.start();
			flyTimer.removeEventListener(TimerEvent.TIMER, flyTic);
			flyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, flyStop);
		}
	}
	
}