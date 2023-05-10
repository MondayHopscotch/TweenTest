package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	var tween:FlxTween;
	var firstTweenFinished = false;
	var delayBeforeCancel = 0.5;

	override public function create()
	{
		super.create();

		sprite = new FlxSprite();
		sprite.makeGraphic(20, 20, FlxColor.WHITE);
		add(sprite);

		tween = FlxTween.tween(sprite, {x: 200}, {
			onComplete: (t) ->
			{
				firstTweenFinished = true;
			}
		});
		tween.then(FlxTween.color(sprite, 1, FlxColor.WHITE, FlxColor.BLUE).then(FlxTween.tween(sprite, {x: 0})));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (firstTweenFinished)
		{
			delayBeforeCancel -= elapsed;
		}

		if (delayBeforeCancel <= 0)
		{
			tween.cancelChain();
		}
	}
}
