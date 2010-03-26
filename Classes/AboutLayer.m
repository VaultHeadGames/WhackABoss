//
//  AboutLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "AboutLayer.h"

@implementation AboutLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		// first the background
		CCSprite *background = [CCSprite spriteWithFile:@"aboutscreen_back.png"];
		CCSprite *foreground = [CCSprite spriteWithFile:@"aboutscreen_for.png"];
		background.anchorPoint = CGPointZero;
		foreground.anchorPoint = CGPointZero;
		[self addChild: background z:-1];
		[self addChild: foreground z: 2];
	}
	
	return self;
}

-(void) onEnter
{
	// this is where we should do some sort of logic to pop up messages on the about screen
}

-(void) backToMainMenu
{
	[[CCDirector sharedDirector] popScene];
}

@end
