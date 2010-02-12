//
//  GameRunner.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameRunner.h"
#import "WBCreature.h"
#import "SoundManager.h"
#import "Constants.h"

@implementation GameRunner

@synthesize currentScore;
@synthesize sexyHitCounts;
@synthesize carlHitCounts;
@synthesize brickHitCounts;
@synthesize currentLevel;
@synthesize creatureSpriteMap;
@synthesize creatureArray;

+(GameRunner*) sharedInstance
{
	static GameRunner* instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}

-(void) pauseGame
{
}

-(void) startGame
{
	// reset the score!
	self.currentScore = 0;
	self.sexyHitCounts = 0;
	self.carlHitCounts = 0;
	self.brickHitCounts = 0;
	self.currentLevel = 0;
	
	// bring up the WBCreature classes
	creatureArray = [[NSMutableArray alloc] init];
	self.creatureSpriteMap = [[CCTextureCache sharedTextureCache] addImage: @"creature_spriteMap.png"];
	while ([creatureArray count] < 9)
		[creatureArray addObject:[WBCreature spriteWithTexture: self.creatureSpriteMap]];
}

-(void) endGame
{
	// release the creatures and sprite-map
	for (WBCreature* c in creatureArray)
		[c release];
	[creatureArray release];
	[self.creatureSpriteMap release];
}

-(void) checkScoreAndSexyCounts
{
	if ((uintptr_t)self.sexyHitCounts == 3) {
		// it's sexual harrassment time!
	} else if ((uintptr_t)self.carlHitCounts == 5) {
		// let's go postal!
	} else if ((uintptr_t)self.brickHitCounts == 7) {
		// what happens when we hit brick
	}
	// check for level advancement...
}

// this is the main 'loop' - this is where we let everything know to advance
-(void) tick:(id)e
{
}

// this function returns the number of seconds a 'creature' remains up
-(double) creatureFadeOutTime
{
	return 2;
}

-(id) init
{
	// always super.init
	if( (self=[super init] )) {
		[self schedule:@selector(tick:) interval:(1/TARGET_FPS)];
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
