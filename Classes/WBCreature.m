//
//  WBCreature.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WBCreature.h"
#import "CreatureStrikeHandler.h"
#import "CreatureMoveAction.h"
#import "GameRunner.h"

@implementation WBCreature

@synthesize state;

-(id) init
{
	if( (self=[super init] )) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:false];
	}
	
	return self;
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
{
	// handle click
	NSLog(@"Creature registered touch");
	[[CreatureStrikeHandler sharedInstance] creatureReportsTouch:self];
	return true;
}

-(CreatureType) creatureType
{
	return _creatureType;
}

-(void) changeCreatureType:(CreatureType)targetType
{
	_creatureType = targetType;
	self.textureRect = CGRectMake(targetType, 0, 48, 48);
}

-(void) registerForPopUp
{
	[CreatureMoveAction initWithTarget: self andTargetState: STATE_HOLDING];
	[self schedule:@selector(goDown:) interval:[[GameRunner sharedInstance] creatureFadeOutTime]];
}

-(void) goDown: (id)sender
{
	[self unschedule:@selector(goDown:)];
	[CreatureMoveAction initWithTarget: self andTargetState: STATE_IDLE];
}

@end
