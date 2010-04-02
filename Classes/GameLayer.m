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
#import "OFHandler.h"

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

		// ROW THREE
		c31 = [[WBCreature alloc] init];
		[c31 setScale:ROW_THREE_SCALE];
		[c31 setUpPosition:ccp(77,ROW_THREE_X_BOTTOM)];
		[self addChild:c31 z:2];
		c32 = [[WBCreature alloc] init];
		[c32 setScale:ROW_THREE_SCALE];
		[c32 setUpPosition:ccp(160,ROW_THREE_X_BOTTOM)];
		[self addChild:c32 z:2];
		c33 = [[WBCreature alloc] init];
		[c33 setScale:ROW_THREE_SCALE];
		[c33 setUpPosition:ccp(243,ROW_THREE_X_BOTTOM)];
		[self addChild:c33 z:2];
		// ROW TWO
		c21 = [[WBCreature alloc] init];
		[c21 setScale:ROW_TWO_SCALE];
		[c21 setUpPosition:ccp(68,ROW_TWO_X_BOTTOM)];
		[self addChild:c21 z:4];
		c22 = [[WBCreature alloc] init];
		[c22 setScale:ROW_TWO_SCALE];
		[c22 setUpPosition:ccp(160,ROW_TWO_X_BOTTOM)];
		[self addChild:c22 z:4];
		c23 = [[WBCreature alloc] init];
		[c23 setScale:ROW_TWO_SCALE];
		[c23 setUpPosition:ccp(257,ROW_TWO_X_BOTTOM)];
		[self addChild:c23 z:4];
		// ROW ONE
		c11 = [[WBCreature alloc] init];
		[c11 setScale:ROW_ONE_SCALE];
		[c11 setUpPosition:ccp(45,ROW_ONE_X_BOTTOM)];
		[self addChild:c11 z:6];
		c12 = [[WBCreature alloc] init];
		[c12 setScale:ROW_ONE_SCALE];
		[c12 setUpPosition:ccp(160,ROW_ONE_X_BOTTOM)];
		[self addChild:c12 z:6];
		c13 = [[WBCreature alloc] init];
		[c13 setScale:ROW_ONE_SCALE];
		[c13 setUpPosition:ccp(275,ROW_ONE_X_BOTTOM)];
		[self addChild:c13 z:6];

		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:FALSE];
		
		[self reset];
	}
	
	return self;
}

-(void) reset
{
	if (nil == c11)
		return;
	gState = GAMESTATE_STOPPED;
	levelTickCounts = 0;
	[c11 reset];
	[c12 reset];
	[c13 reset];
	[c21 reset];
	[c22 reset];
	[c23 reset];
	[c31 reset];
	[c32 reset];
	[c33 reset];
	[[ScoreManager get] reset];
}

-(void) scheduleStart
{
//	[self schedule:@selector(doScheduledStart:) interval:4];
	// TODO - flash a message to start
	gState = GAMESTATE_STARTUP;
	[self reset];
	[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:4],[CCCallFuncN actionWithTarget:self selector:@selector(doScheduledStart:)],nil]];
}

-(void) doScheduledStart:(id)sender
{
//	[self unschedule:@selector(doScheduledStart:)];
	[self schedule:@selector(mainTick:) interval:0.73414159];
	gState = GAMESTATE_RUNNING;
	if ([[OFHandler sharedInstance] feintIsActive]) {
		NSDate *today = [NSDate date];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
		NSInteger weekday = [weekdayComponents weekday];
		if (weekday == 2)
			[[OFHandler sharedInstance] registerAchivement:CASE_OF_THE_MONDAYS];
		else if (weekday == 6)
			[[OFHandler sharedInstance] registerAchivement:I_WANNA_GET_THE_HELL_OUTTA_HERE_];
	}
}

-(void) mainTick:(ccTime)dt
{
	if (gState != GAMESTATE_RUNNING)
		return;
	
	// GO THE MAGIC!
	++levelTickCounts;
	
	//long nextLevelTick = ((([[[ScoreManager get] level] intValue] - 1) * LEVEL_TICK_MIGRATION_MODIFIER) + 30);
	
	if (levelTickCounts > (45 + ([[[ScoreManager get] level] intValue] * LEVEL_TICK_MIGRATION_MODIFIER))) {
		gState = GAMESTATE_LEVELCHANGE;
		[self doLevelChange];
		return;
	}
	
	// dtermine random skip probability
	if ((arc4random() % 1) > 0.8499) {
		NSLog(@"<GameRunner> Skip tick");
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
	
	int creatureMin;
	int creatureMax;
	
	if ([[[ScoreManager get] level] intValue] <= 5) {
		creatureMin = 1 + round([[[ScoreManager get] level] intValue] * 0.125);
	} else if ([[[ScoreManager get] level] intValue] > 10) {
		creatureMin = 5;
	} else {
		creatureMin = 3 + round([[[ScoreManager get] level] intValue] * MAXIMUM_CREATURE_LEVEL_MODIFIER);
	}
	if ([[[ScoreManager get] level] intValue] <= 5) {
		creatureMax = 2 + round([[[ScoreManager get] level] intValue] * 0.125);
	} else if ([[[ScoreManager get] level] intValue] > 10) {
		creatureMax = 9;
	} else {
		creatureMax = round(3 + ([[[ScoreManager get] level] intValue] * MAXIMUM_CREATURE_LEVEL_MODIFIER));
	}
	int newCreatureProbability = 0;
	
	if (creaturesUp < creatureMax) {
		// determine the 'odds' that we'll pop up somebody new
		if (creaturesUp < creatureMin)
			newCreatureProbability = 1;
		else
			newCreatureProbability = arc4random();//(((creatureMax / creaturesUp) * TICK_NEW_CREATURE_PROBABILITY_MODIFIER) + (MAXIMUM_CREATURE_LEVEL_MODIFIER * [[[ScoreManager get] level] intValue]));
	}
	
	NSLog(@"<GameRunner> Current probability to popup new creature is %d", newCreatureProbability);
	
	if (newCreatureProbability * 10 > (arc4random() % 10)) {
		// pick a new creature to popup!
		int newCreatureIndex = round(arc4random() % 8);
		NSLog(@"<GameRunner> Creature index %d signaled to popup",newCreatureIndex);
		int newCreatureTypeI = arc4random() % 100;
		NSLog(@"<GameRunner> Creature roll is %i",newCreatureTypeI);
		int bossCreatureProbability;
		int specialCreatureProbability;
		// grab probability ratios
		bossCreatureProbability = 75 - (([[[ScoreManager get] level] intValue] ^ 3) / 250) + (([[[ScoreManager get] level] intValue] ^ 2) / 30);
		specialCreatureProbability = (100 - bossCreatureProbability) / 3;
		NSLog(@"<GameRunner> Probabilities are %d boss, %d special",bossCreatureProbability,specialCreatureProbability);
		// determine what we're creating
		CreatureType newCreatureType;
		if (newCreatureTypeI <= specialCreatureProbability)
			newCreatureType = SEXY_TYPE;
		else if (newCreatureTypeI <= (specialCreatureProbability * 2))
			newCreatureType = JOE_TYPE;
		else if (newCreatureTypeI <= (specialCreatureProbability * 3))
			newCreatureType = CARL_TYPE;
		else
			newCreatureType = BOSS_TYPE;
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
	if ([[[ScoreManager get] level] intValue] == LAST_LEVEL) {
		NSLog(@"LAST LEVEL! WE WIN!");
		[self doEndGame:ENDGAME_WIN];
		return;
	}
	NSLog(@"LEVEL CHANGE");
	//[self reset];
	overlaySprite = [CCSprite spriteWithFile:@"message_level_up.png"];
	overlaySprite.anchorPoint = CGPointZero;
	overlaySprite.opacity = 0;
	[self addChild:overlaySprite z:20];
	[overlaySprite runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.33 opacity:255],[CCIntervalAction actionWithDuration:2.5],[CCFadeTo actionWithDuration:1 opacity:0],[CCCallFuncN actionWithTarget:self selector:@selector(completeLevelChange:)],nil]];;
	[[ScoreManager get] levelUp];
//	[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:3],[CCCallFuncN actionWithTarget:self selector:@selector(completeLevelChange:)],nil]];
//	[self schedule:@selector(completeLevelChange:) interval:3];
}

-(void) completeLevelChange:(id)sender
{
	[self removeChild:overlaySprite cleanup:TRUE];
	levelTickCounts = 0;
//	[self unschedule:@selector(completeLevelChange:)];
	gState = GAMESTATE_RUNNING;
}

-(void) doEndGame:(EndGameCondition)condition
{
	[self unschedule:@selector(mainTick:)];
	gState = GAMESTATE_END;
	
	CCScene *scene = [[CCScene alloc] init];
	EndGameLayer *layer = [[EndGameLayer alloc] initWithEndGame:condition];
	
	[scene addChild:layer];

	CCTransitionScene *trans = [CCFadeTransition transitionWithDuration:.2 scene:scene withColor:ccBLACK];
	
	[[CCDirector sharedDirector] replaceScene:trans];
	gState = GAMESTATE_STOPPED;
}

-(void) showCreatureWarning:(CreatureType) type
{
	switch (type) {
		case SEXY_TYPE:
			gState = GAMESTATE_WARNING;
			overlaySprite = [CCSprite spriteWithFile:@"message_intern_warning.png"];
			overlaySprite.anchorPoint = CGPointZero;
			overlaySprite.opacity = 0;
			[self addChild:overlaySprite z:20];
			[overlaySprite runAction:[CCFadeTo actionWithDuration:0.33 opacity:255]];
			break;
		case JOE_TYPE:
			gState = GAMESTATE_WARNING;
			overlaySprite = [CCSprite spriteWithFile:@"message_joe_warning.png"];
			overlaySprite.anchorPoint = CGPointZero;
			overlaySprite.opacity = 0;
			[self addChild:overlaySprite z:20];
			[overlaySprite runAction:[CCFadeTo actionWithDuration:0.33 opacity:255]];
			break;
		case CARL_TYPE:
			gState = GAMESTATE_WARNING;
			overlaySprite = [CCSprite spriteWithFile:@"message_carl_warning.png"];
			overlaySprite.anchorPoint = CGPointZero;
			overlaySprite.opacity = 0;
			[self addChild:overlaySprite z:20];
			[overlaySprite runAction:[CCFadeTo actionWithDuration:0.33 opacity:255]];
			break;
		default:
			return;
			break;
	}
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (gState != GAMESTATE_WARNING)
		return FALSE;
	
	[overlaySprite runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.33 opacity:0],[CCCallFuncN actionWithTarget:self selector:@selector(removeWarning:)],nil]];
	return TRUE;
}

-(void) removeWarning:(id)sender
{
	[self removeChild:overlaySprite cleanup:TRUE];
	gState = GAMESTATE_RUNNING;
}

@end
