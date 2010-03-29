//
//  WABSlider.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WABSlider.h"
#import "AudioController.h"
#import "WABSettings.h"
#import "WhackABossAppDelegate.h"

@implementation WABSlider

-(id) init
{
	if ((self = [super init])) {
		_slider = [[CCSprite alloc] initWithFile:@"slider.png"];
		_sliderBg = [[CCSprite alloc] initWithFile:@"slider_bg.png"];
		_value = FALSE;
		_currentState = FALSE;
		_moving = FALSE;
		_slider.position = ccp(((contentSize_.width - _slider.contentSize.width) / 2),0);
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:TRUE];
		[self addChild:_sliderBg z:0];
		[self addChild:_slider z:1];
	}
	return self;
}

-(void) setValue:(BOOL)v
{
	_value = v;
	[self updateSlidePosition];
}

-(BOOL) value
{
	return _value;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (_moving)
		return false;
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint	location = [[CCDirector sharedDirector] convertToGL: touchLocation];
	CGRect myRect = CGRectMake(self.position.x - _sliderBg.contentSize.width / 2, self.position.y - _sliderBg.contentSize.height / 2, _sliderBg.contentSize.width, _sliderBg.contentSize.height);
	// are we actually being clicked?
	if (CGRectContainsPoint(myRect, location)) {
		_value = !_value;
		[[[WhackABossAppDelegate get] settingsLayer] saveSettings];
		[[AudioController sharedInstance] playEffect:@"IncDec5a.caf"];
		[self updateSlidePosition];
		return true; // let the delegate know we're handing this event
	}
	return false;
}

-(void) updateSlidePosition
{
	if (_value == _currentState)
		return;
	_moving = TRUE;
	
	CGPoint movePosition;
	
	switch (_value) {
		case TRUE:
			movePosition = ccp(_slider.contentSize.width / 2,0);
			break;
		case FALSE:
			movePosition = ccp(((contentSize_.width - _slider.contentSize.width) / 2),0);
			break;
	}
	NSLog(@"MOVING");
	[_slider runAction: [CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:movePosition],[CCCallFuncN actionWithTarget:self selector:@selector(slideMoveFinished:)],nil]];
}

-(void) slideMoveFinished:(id)sender
{
	NSLog(@"MOVE FINISHED");
	_moving = FALSE;
	_currentState = _value;
	[[WABSettings get] saveSettings];
}

@end
