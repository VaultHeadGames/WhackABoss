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
#import "ScoreManager.h"
#import "Constants.h"
#import "EndGameLayer.h"

@implementation GameLayer

@synthesize gState, scoreLayer;

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
		
		[c11 goDown:self];
		[c12 goDown:self];
		[c13 goDown:self];
		[c21 goDown:self];
		[c22 goDown:self];
		[c23 goDown:self];
		[c31 goDown:self];
		[c32 goDown:self];
		[c33 goDown:self];
		
		gState = GAMESTATE_STOPPED;
		levelTickCounts = 0;
		[self schedule:@selector(mainTick:) interval:1];
	}
	
	return self;
}

-(void) reset
{
	if (nil == c11)
		return;
	[c11 goDown:self];
	[c12 goDown:self];
	[c13 goDown:self];
	[c21 goDown:self];
	[c22 goDown:self];
	[c23 goDown:self];
	[c31 goDown:self];
	[c32 goDown:self];
	[c33 goDown:self];
}

-(void) scheduleStart
{
	[self schedule:@selector(doScheduledStart:) interval:4];
	// TODO - flash a message to start
	gState = GAMESTATE_STARTUP;
}

-(void) doScheduledStart:(id)sender
{
	[self unschedule:@selector(doScheduledStart:)];
	gState = GAMESTATE_RUNNING;
}

-(void) mainTick:(ccTime)dt
{
	if (gState != GAMESTATE_RUNNING)
		return;
	
	// GO THE MAGIC!
	++levelTickCounts;
	
	//long nextLevelTick = ((([[[ScoreManager get] level] intValue] - 1) * LEVEL_TICK_MIGRATION_MODIFIER) + 30);
	
	if (levelTickCounts >= 30) {
		gState = GAMESTATE_LEVELCHANGE;
		[self doLevelChange];
		return;
	}
	
	int creaturesUp = 0;
	
	if (c11.state != STATE_IDLE)
		creaturesUp += 1;
	if (c12.state != STATE_IDLE)
		creaturesUp += 1;
	if (c13.state != STATE_IDLE)
		creaturesUp += 1;
	if (c21.state != STATE_IDLE)
		creaturesUp += 1;
	if (c22.state != STATE_IDLE)
		creaturesUp += 1;
	if (c23.state != STATE_IDLE)
		creaturesUp += 1;
	if (c31.state != STATE_IDLE)
		creaturesUp += 1;
	if (c32.state != STATE_IDLE)
		creaturesUp += 1;
	if (c33.state != STATE_IDLE)
		creaturesUp += 1;
	
	NSLog(@"<GameRunner> Tick %i", levelTickCounts);
	
	NSLog(@"<GameRunner> Currently have %d creatures up", creaturesUp);
	
	int creatureMin = 1 + (floor([[[ScoreManager get] level] intValue] * MAXIMUM_CREATURE_LEVEL_MODIFIER) / 2);
	int creatureMax = 2 + floor([[[ScoreManager get] level] intValue] * MAXIMUM_CREATURE_LEVEL_MODIFIER);
	int newCreatureProbability = 0;
	
	if (creaturesUp < creatureMax) {
		// determine the 'odds' that we'll pop up somebody new
		if (creaturesUp < creatureMin)
			newCreatureProbability = 1;
		else
			newCreatureProbability = (((creatureMax / creaturesUp) * TICK_NEW_CREATURE_PROBABILITY_MODIFIER) + (MAXIMUM_CREATURE_LEVEL_MODIFIER * [[[ScoreManager get] level] intValue]));
	}
	
	NSLog(@"<GameRunner> Current probability to popup new creature is %d", newCreatureProbability);
	
	if (newCreatureProbability * 10 > (arc4random() % 10)) {
		// pick a new creature to popup!
		int newCreatureIndex = round(arc4random() % 8);
		NSLog(@"<GameRunner> Creature index %d signaled to popup",newCreatureIndex);
		int newCreatureTypeI = round(arc4random() % 7);
		CreatureType newCreatureType;
		switch (newCreatureTypeI) {
			case 1:
				newCreatureType = SEXY_TYPE;
				break;
			case 2:
				newCreatureType = JOE_TYPE;
				break;
			case 3:
				newCreatureType = CARL_TYPE;
				break;
			default:
				newCreatureType = BOSS_TYPE;
				break;
		}
		switch (newCreatureIndex) {
			case 0:
				if (c11.state != STATE_IDLE)
					break;
				[c11 changeCreatureType:newCreatureType];
				[c11 registerForPopUp];
				break;
			case 1:
				if (c12.state != STATE_IDLE)
					break;
				[c12 changeCreatureType:newCreatureType];
				[c12 registerForPopUp];
				break;
			case 2:
				if (c13.state != STATE_IDLE)
					break;
				[c13 changeCreatureType:newCreatureType];
				[c13 registerForPopUp];
				break;
			case 3:
				if (c21.state != STATE_IDLE)
					break;
				[c21 changeCreatureType:newCreatureType];
				[c21 registerForPopUp];
				break;
			case 4:
				if (c22.state != STATE_IDLE)
					break;
				[c22 changeCreatureType:newCreatureType];
				[c22 registerForPopUp];
				break;
			case 5:
				if (c23.state != STATE_IDLE)
					break;
				[c23 changeCreatureType:newCreatureType];
				[c23 registerForPopUp];
				break;
			case 6:
				if (c31.state != STATE_IDLE)
					break;
				[c31 changeCreatureType:newCreatureType];
				[c31 registerForPopUp];
				break;
			case 7:
				if (c32.state != STATE_IDLE)
					break;
				[c32 changeCreatureType:newCreatureType];
				[c32 registerForPopUp];
				break;
			case 8:
				if (c33.state != STATE_IDLE)
					break;
				[c33 changeCreatureType:newCreatureType];
				[c33 registerForPopUp];
				break;
			default:
				break;
		}
	}
}

-(void) doLevelChange
{
	if ([[[ScoreManager get] level] intValue] == 15) {
		NSLog(@"LAST LEVEL! WE WIN!");
		[self doEndGame:ENDGAME_WIN];
		return;
	}
	NSLog(@"LEVEL CHANGE");
	//[self reset];
	//overlaySprite = [CCSprite spriteWithFile:@"message_level_up.png"];
	//overlaySprite.position = ccp(120,160); // center screen
	//overlaySprite.opacity = 0;
	//[self addChild:overlaySprite z:20];
	//[overlaySprite runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.33 opacity:255],[CCFadeTo actionWithDuration:2 opacity:0],[CCCallFuncN actionWithTarget:self selector:@selector(completeLevelChange:)],nil]];;
	[[ScoreManager get] levelUp];
	[self schedule:@selector(completeLevelChange:) interval:3];
}

-(void) completeLevelChange:(id)sender
{
	//[self removeChild:overlaySprite cleanup:TRUE];
	levelTickCounts = 0;
	[self unschedule:@selector(completeLevelChange:)];
	gState = GAMESTATE_RUNNING;
}

-(void) doEndGame:(EndGameCondition)condition
{
	gState = GAMESTATE_END;
	
	CCScene *scene = [[CCScene alloc] init];
	EndGameLayer *layer = [[EndGameLayer alloc] initWithEndGame:condition];
	
	[scene addChild:layer];

	CCTransitionScene *trans = [CCFadeTransition transitionWithDuration:.2 scene:scene withColor:ccBLACK];
	
	[[CCDirector sharedDirector] replaceScene:trans];
}

@end
