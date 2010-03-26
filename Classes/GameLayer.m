//
//  GameLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameLayer.h"
#import "ScoreLayer.h"
#import "WBCreature.h"
#import "WhackABossAppDelegate.h"

@implementation GameLayer

@synthesize isPaused, isRunning, scoreLayer;

-(id) init
{
	if ((self = [super init])) {
		CCSprite* background_bottom = [CCSprite spriteWithFile:@"office-V2_04.png"];
		CCSprite* background_cube_row_1 = [CCSprite spriteWithFile:@"office-V2_03.png"];
		CCSprite* background_cube_row_2 = [CCSprite spriteWithFile:@"office-V2_02.png"];
		CCSprite* background_top = [CCSprite spriteWithFile:@"office-V2_01.png"];
		background_bottom.anchorPoint = CGPointZero;
		background_cube_row_1.position = ccp(160, 165.5);
		background_cube_row_2.position = ccp(160, 268.5);
		background_top.position = ccp(160, 393.5);
		[self addChild:background_bottom z:7];
		[self addChild:background_cube_row_1 z:5];
		[self addChild:background_cube_row_2 z:3];
		[self addChild:background_top z:0];
		
		scoreLayer = [[ScoreLayer alloc] init];
		scoreLayer.anchorPoint = CGPointZero;
		[self addChild:scoreLayer z:6];
		[self schedule:@selector(updateScore:) interval:5];
				
		[self addChild:[[WhackABossAppDelegate get] spriteSheet] z:-1];
		
		// ROW ONE
		c11 = [[WBCreature alloc] init];
		[c11 setScale:ROW_ONE_SCALE];
		c11.position = ccp(45,ROW_ONE_X_BOTTOM);
		[self addChild:c11 z:6];
		c12 = [[WBCreature alloc] init];
		[c12 setScale:ROW_ONE_SCALE];
		c12.position = ccp(160,ROW_ONE_X_BOTTOM);
		[self addChild:c12 z:6];
		c13 = [[WBCreature alloc] init];
		[c13 setScale:ROW_ONE_SCALE];
		c13.position = ccp(275,ROW_ONE_X_BOTTOM);
		[self addChild:c13 z:6];
		// ROW TWO
		c21 = [[WBCreature alloc] init];
		[c21 setScale:ROW_TWO_SCALE];
		c21.position = ccp(68,ROW_TWO_X_BOTTOM);
		[self addChild:c21 z:4];
		c22 = [[WBCreature alloc] init];
		[c22 setScale:ROW_TWO_SCALE];
		c22.position = ccp(160,ROW_TWO_X_BOTTOM);
		[self addChild:c22 z:4];
		c23 = [[WBCreature alloc] init];
		[c23 setScale:ROW_TWO_SCALE];
		c23.position = ccp(257,ROW_TWO_X_BOTTOM);
		[self addChild:c23 z:4];
		// ROW THREE
		c31 = [[WBCreature alloc] init];
		[c31 setScale:ROW_THREE_SCALE];
		c31.position = ccp(77,ROW_THREE_X_BOTTOM);
		[self addChild:c31 z:2];
		c32 = [[WBCreature alloc] init];
		[c32 setScale:ROW_THREE_SCALE];
		c32.position = ccp(160,ROW_THREE_X_BOTTOM);
		[self addChild:c32 z:2];
		c33 = [[WBCreature alloc] init];
		[c33 setScale:ROW_THREE_SCALE];
		c33.position = ccp(243,ROW_THREE_X_BOTTOM);
		[self addChild:c33 z:2];
	}
	
	return self;
}

-(void) updateScore:(ccTime)dt
{
	[scoreLayer updateScore:[NSNumber numberWithInt:round(arc4random() % 10000)]];
}

-(void) reset
{
	return;
}

@end
