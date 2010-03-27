//
//  ScoreManager.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "ScoreManager.h"
#import "WhackABossAppDelegate.h"
#import "Constants.h"

@implementation ScoreManager

@synthesize score, level, sexyHitCounts, carlHitCounts;

+(ScoreManager *) get
{
	static ScoreManager *instance = nil;
	
	if (nil == instance) {
		instance = [[self alloc] init];
	}
	
	return instance;
}

-(id) init
{
	if ((self = [super init])) {
		score = [NSNumber numberWithInt:0];
		level = [NSNumber numberWithInt:1];
	}
	return self;
}

-(void) tallyScoreChange:(CreatureType)cType
{
	switch (cType) {
		case BOSS_TYPE:
			NSLog(@"Struck BOSS_TYPE");
			score = [NSNumber numberWithInt:[score intValue] + 1];
			break;
		case JOE_TYPE:
			NSLog(@"Struck JOE_TYPE");
			if ([score intValue] != 0) {
				score = [NSNumber numberWithInt:[score intValue] - 1];
			} else {
				[[[WhackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_FAIL];
				return;
			}
			break;
		case SEXY_TYPE:
			NSLog(@"Struck SEXY_TYPE");
			sexyHitCounts += 1;
			break;
		case CARL_TYPE:
			NSLog(@"Struck CARL_TYPE");
			carlHitCounts += 1;
			break;
		default:
			NSLog(@"Unknown creature type struck");
			break;
	}
	
	// check sexy and carl hit counts
	if (sexyHitCounts > MAXIMUM_SEXY_HITS) {
		[[[WhackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_SEXY];
		return;
	}
	if (carlHitCounts > MAXIMUM_CARL_HITS) {
		[[[WhackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_POSTAL];
		return;
	}
	
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
}

-(void) levelUp
{
	level = [NSNumber numberWithInt:[level intValue] + 1];
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateLevel:level];
}

-(double) creatureFadeOutTime
{
	return 3 - ((([level intValue] * BASELINE_DIFFICULTY_MODIFIER) * ([level intValue] * BASELINE_DIFFICULTY_MODIFIER)) / (BASELINE_DIFFICULTY_MODIFIER * 10));
}

-(void) reset
{
	score = [NSNumber numberWithInt:0];
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
	level = [NSNumber numberWithInt:1];
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateLevel:level];
}

@end
