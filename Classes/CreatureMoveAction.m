//
//  CreatureMoveAction.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/12/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "CreatureMoveAction.h"
#import "WBCreature.h"

@implementation CreatureMoveAction

@synthesize target;

+(CreatureMoveAction*) initWithTarget: (WBCreature*) tgt andTargetState: (CreatureState) tgtState
{
	return [[[[CreatureMoveAction alloc] init] setTarget: tgt setTargetState: tgtState] autorelease];
}

-(CreatureMoveAction*) setTarget: (WBCreature*) tgt setTargetState: (CreatureState) tgtState
{
	targetState = tgtState;
	targetCreature = tgt;
	[super startWithTarget:tgt];
	return self;
}

-(void) startWithTarget:(id)aTarget
{
	running = true;
	[super startWithTarget:aTarget];
	
	// determine where we're moving to...
	CGPoint currentPosition = targetCreature.position;
	CreatureState currentState = targetCreature.state;
	
	switch (currentState) {
		case STATE_IDLE:
			targetCreature.state = STATE_GOING_UP;
			targetPosition = ccp(currentPosition.x + 40, currentPosition.y);
			break;
		case STATE_HOLDING:
			targetCreature.state = STATE_GOING_DOWN;
			targetPosition = ccp(currentPosition.x - 40, currentPosition.y);
			break;
		default:
			break;
	}
}

-(void) update:(ccTime)time
{
	if (!running)
		return;
	
	CGPoint currentPosition = targetCreature.position;
	if (currentPosition.x == targetPosition.x) {
		running = false;
		return;
	} else {
		CGPoint newPosition;
		if (currentPosition.x < targetPosition.x) {
			newPosition = ccp(currentPosition.x + 1, currentPosition.y);
		} else {
			newPosition = ccp(currentPosition.x	- 1, currentPosition.y);
		}
		[self target].position = newPosition;
	}
}

-(BOOL) isDone
{
	return [super isDone] || !running;
}

@end
