//
//  GameRunner.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameRunner.h"
#import "WBCreature.h"

@implementation GameRunner

@synthesize currentScore;
@synthesize sexyHitCounts;
@synthesize carlHitCounts;
@synthesize creatureSpriteMap;

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
}

-(void) checkScoreAndSexyCounts
{
	if (self.sexyHitCounts == 3) {
		// it's sexual harrassment time!
	} else if (self.carlHitCounts == 5) {
		// let's go postal!
	}
	// check for level advancement...
}

-(id) init
{
	// always super.init
	if( (self=[super init] )) {
		self.creatureSpriteMap = [[CCTextureCache sharedTextureCache] addImage: @"creature_spriteMap.png"];
		creatureArray = [[NSMutableArray alloc] init];
		while ([creatureArray count] < 9) {
			[creatureArray addObject:[WBCreature initWithTexture: self.creatureSpriteMap andPosition:[NSNumber numberWithInt:[creatureArray count]]]];
		}
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
