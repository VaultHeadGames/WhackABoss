//
//  WBCreature.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WBCreature.h"
#import "CreatureStrikeHandler.h"

@implementation WBCreature

@synthesize type;
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

-(void) registerForPopUp
{
	self.state = STATE_GOING_UP;
}

-(void) takeTick
{
}

@end
