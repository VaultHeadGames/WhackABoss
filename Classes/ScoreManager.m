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
		score = 0;
		level = 0;
	}
	return self;
}

-(void) tallyScoreChange:(CreatureType)cType
{
	switch (cType) {
		case BOSS_TYPE:
			NSLog(@"Struck BOSS_TYPE");
			score += 1;
			break;
		case JOE_TYPE:
			NSLog(@"Struck JOE_TYPE");
			score -= 1;
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
	if (score < 0)
		score = 0;
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
}

-(double) creatureFadeOutTime
{
	return 2;
}

@end
