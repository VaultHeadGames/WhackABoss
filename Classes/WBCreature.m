//
//  WBCreature.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WBCreature.h"
#import "ScoreManager.h"
#import "WhackABossAppDelegate.h"
#import "AudioController.h"

@implementation WBCreature

@synthesize state;//, upPosition, downPosition;

-(id) init
{
	if( (self=[super init] )) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:TRUE];
		_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"joe_normal.png"];
		_creatureType = JOE_TYPE;
		state = STATE_HOLDING;
		[self addChild:_creatureSprite];
	}
	
	return self;
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
{
	// handle click
	if ((state == STATE_IDLE) || ([[[WhackABossAppDelegate get] gameLayer] gState] != GAMESTATE_RUNNING))
		return false;
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint	location = [[CCDirector sharedDirector] convertToGL: touchLocation];
	CGRect myRect = CGRectMake(self.position.x - (_creatureSprite.contentSize.width * self.scale) / 2, self.position.y - (_creatureSprite.contentSize.height * self.scale) / 2, (_creatureSprite.contentSize.width * self.scale), (_creatureSprite.contentSize.height * self.scale));
	// are we actually being clicked?
	if (CGRectContainsPoint(myRect, location)) {
		NSLog(@"Ceature reports touch");
		[[ScoreManager get] tallyScoreChange:_creatureType];
		switch (_creatureType) {
			case BOSS_TYPE:
				[[AudioController sharedInstance] playRandomHit];
				[self removeChild:_creatureSprite cleanup:TRUE];
				_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"boss_strike.png"];
				[self addChild:_creatureSprite];
				break;
			case SEXY_TYPE:
				[[AudioController sharedInstance] playEffect:@"sexy-hit.caf"];
				[self removeChild:_creatureSprite cleanup:TRUE];
				_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"intern_strike.png"];
				[self addChild:_creatureSprite];
				break;
			case JOE_TYPE:
				[[AudioController sharedInstance] playRandomHit];
				[self removeChild:_creatureSprite cleanup:TRUE];
				_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"joe_strike.png"];
				[self addChild:_creatureSprite];
				break;
			case CARL_TYPE:
				[[AudioController sharedInstance] playRandomHit];
				[self removeChild:_creatureSprite cleanup:TRUE];
				_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"carl_strike.png"];
				[self addChild:_creatureSprite];
				break;
			default:
				break;
		}
		state = STATE_GOING_DOWN;
		[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:.1], [CCCallFuncN actionWithTarget:self selector:@selector(strikeDown:)], nil]];
		return true; // let the delegate know we're handing this event
	}
	return false;
}

-(void) strikeDown:(id)sender
{
	switch (_creatureType) {
		case BOSS_TYPE:
			[self removeChild:_creatureSprite cleanup:TRUE];
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"boss_struck.png"];
			[self addChild:_creatureSprite];
			break;
		case SEXY_TYPE:
			[self removeChild:_creatureSprite cleanup:TRUE];
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"intern_struck.png"];
			[self addChild:_creatureSprite];
			break;
		case JOE_TYPE:
			[self removeChild:_creatureSprite cleanup:TRUE];
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"joe_struck.png"];
			[self addChild:_creatureSprite];
			break;
		case CARL_TYPE:
			[self removeChild:_creatureSprite cleanup:TRUE];
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"carl_struck.png"];
			[self addChild:_creatureSprite];
			break;
		default:
			break;
	}
	[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:.45], [CCCallFuncN actionWithTarget:self selector:@selector(completeStrikeDown:)], nil]];
}

-(void) completeStrikeDown:(id)sender
{	
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.25 position:downPosition], [CCCallFuncN actionWithTarget:self selector:@selector(downCompleted:)], nil]];
}

-(CreatureType) creatureType
{
	return _creatureType;
}

-(void) setScale:(float)s
{
	// make sure we pass scale down to the creature scale
	[_creatureSprite setScale:s];
	[super setScale:s];
}

-(void) setUpPosition:(CGPoint)p
{
	upPosition = p;
	downPosition = ccp(p.x, p.y - (_creatureSprite.contentSize.height * self.scale));
}

-(void) changeCreatureType:(CreatureType)targetType
{
	_creatureType = targetType;
	[self removeChild:_creatureSprite cleanup:TRUE];
	switch (_creatureType) {
		case BOSS_TYPE:
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"boss_normal.png"];
			break;
		case SEXY_TYPE:
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"intern_normal.png"];
			break;
		case CARL_TYPE:
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"carl_normal.png"];
			break;
		case JOE_TYPE:
			_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"joe_normal.png"];
			break;
	}
	[self addChild:_creatureSprite];
}

-(void) registerForPopUp
{
	if (state != STATE_IDLE)
		return;
	[self reset];
	state = STATE_GOING_UP;
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.8 position:upPosition], [CCCallFuncN actionWithTarget:self selector:@selector(upCompleted:)], nil]];
}

-(void) upCompleted:(id)sender
{
	state = STATE_HOLDING;
	[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:[[ScoreManager get] creatureFadeOutTime]],[CCCallFuncN actionWithTarget:self selector:@selector(goDown:)],nil]];
}

-(void) goDown: (id)sender
{
	if (state != STATE_HOLDING)
		return;
	state = STATE_GOING_DOWN;
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.8 position:downPosition], [CCCallFuncN actionWithTarget:self selector:@selector(downCompleted:)], nil]];
}

-(void) downCompleted: (id)sender
{
	state = STATE_IDLE;
}

-(void) reset
{
	[self stopAllActions];
	state = STATE_IDLE;
	self.position = downPosition;
}

@end
