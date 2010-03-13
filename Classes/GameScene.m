//
//  GameScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameScene.h"
#import "WBCreature.h"
#import "GameRunner.h"

@implementation GameScene

@synthesize creatureArray;
@synthesize creatureSpriteMap;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an MainMenu object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		CCSprite* background_bottom = [CCSprite spriteWithFile:@"office-00.png"];
		CCSprite* background_cube_row_1 = [CCSprite spriteWithFile:@"office-01.png"];
		CCSprite* background_cube_row_2 = [CCSprite spriteWithFile:@"office-02.png"];
		CCSprite* background_cube_row_3 = [CCSprite spriteWithFile:@"office-03.png"];
		CCSprite* background_top = [CCSprite spriteWithFile:@"office-04.png"];
		background_bottom.anchorPoint = CGPointZero;
		background_cube_row_1.position = ccp(160, 163);
		background_cube_row_2.position = ccp(160, 266);
		background_cube_row_3.position = ccp(160, 340);
		background_top.position = ccp(160, 425.5);
		[self addChild:background_bottom z:6];
		[self addChild:background_cube_row_1 z:4];
		[self addChild:background_cube_row_2 z:2];
		[self addChild:background_cube_row_3 z:0];
		[self addChild:background_top z:0];
	}
	return self;
}

-(void) startGame
{
	// bring up the WBCreature classes
	creatureArray = [[NSMutableArray alloc] init];
	self.creatureSpriteMap = [CCSpriteSheet spriteSheetWithFile: @"boss-test.png"];
	while ([creatureArray count] < 9)
		[creatureArray addObject:[WBCreature spriteWithSpriteSheet: self.creatureSpriteMap rect: CGRectMake(0,0,48,48)]];
	for (WBCreature* c in creatureArray) {
		// Place 'em
	}
}

-(void) endGame
{
	// release the creatures and sprite-map
	for (WBCreature* c in creatureArray) {
		[self removeChild:c cleanup:true];
		[c release];
	}
	[creatureArray release];
	[creatureSpriteMap release];
}
@end
