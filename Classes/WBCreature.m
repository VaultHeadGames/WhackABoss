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

@synthesize creatureType;

+(id) initWithTexture:(CCTexture2D*)texture andPosition:(NSNumber*)pos
{
	NSLog([NSString stringWithFormat:@"Initializing creature number %n",pos]);
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:false];
	return [super spriteWithTexture:texture];
}

-(bool) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
{
	// handle click
	NSLog([NSString stringWithFormat:@"Creature registered touch"]);
	[[CreatureStrikeHandler sharedInstance] creatureReportsTouch:self];
	return true;
}

@end
