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
@synthesize gameRunning;
@synthesize gameHasStarted;
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
	self.gameRunning = false;
}
-(void) resumeGame
{
	if (!self.gameHasStarted)
		return;
	self.gameRunning = true;
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
	self.gameRunning = false;
	// release the creatures and sprite-map
	for (WBCreature* c in creatureArray)
		[c release];
	[creatureArray release];
	[self.creatureSpriteMap release];
	self.gameHasStarted = false;
}

-(void) checkScoreAndSexyCounts
{
	if ((uintptr_t)self.sexyHitCounts == 3) {
		// it's sexual harrassment time!
	} else if ((uintptr_t)self.carlHitCounts == 5) {
		// let's go postal!
	} else if ((uintptr_t)self.brickHitCounts == 7) {
		// what happens when we hit brick?
	}
	// check for level advancement...
}

// this is the main 'loop' - this is where we let everything know to advance
-(void) tick:(id)e
{
	// don't continue unless we're running, obviously
	if (!self.gameRunning || !self.gameHasStarted)
		return;
	
	// GO THE MAGIC!
	int creaturesUp = 0;
	
	for (WBCreature* c in self.creatureArray) {
		[c takeTick];
		if (c.state != CREATURE_STATE_IDLE)
			++creaturesUp;
	}
	
	// determine the number of creatures we want to have up at a maximum
	// and if we're under the maximum, randomly determine if we want to
	// pop one up - and furthermore randomly pick which one we want to pop
	// up...
}

// this function returns the number of seconds a 'creature' remains up
-(double) creatureFadeOutTime
{
	return (((0 - log((int)self.currentLevel)) * BASELINE_DIFFICULTY_MODIFIER) + BASELINE_POPUP_DELAY);
}

-(id) init
{
	// always super.init
	if( (self=[super init] )) {
		self.gameRunning = false;
		self.gameHasStarted = false;
		[self schedule:@selector(tick:) interval:(1/TARGET_FPS)];
	}
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
