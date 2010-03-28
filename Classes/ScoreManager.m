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
#import "WABSettings.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AudioController.h"

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
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (joeWarningShown) {
				if ([score intValue] != 0) {
					score = [NSNumber numberWithInt:[score intValue] - 1];
				} else {
					[[[WhackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_FAIL];
					return;
				}
			} else {
				[[[WhackABossAppDelegate get] gameLayer] showCreatureWarning:JOE_TYPE];
				joeWarningShown = TRUE;
				[WABSettings get].joeWarningShown = TRUE;
				[[WABSettings get] saveSettings];
				return;
			}
			break;
		case SEXY_TYPE:
			NSLog(@"Struck SEXY_TYPE");
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (internWarningShown) {
				sexyHitCounts += 1;
				if (sexyHitCounts == (MAXIMUM_SEXY_HITS - 1))
					[[AudioController sharedInstance] playEffect:@"sexy-no.caf"];
			} else {
				[[[WhackABossAppDelegate get] gameLayer] showCreatureWarning:SEXY_TYPE];
				internWarningShown = TRUE;
				[WABSettings get].internWarningShown = TRUE;
				[[WABSettings get] saveSettings];
				return;
			}
			break;
		case CARL_TYPE:
			NSLog(@"Struck CARL_TYPE");
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (carlWarningShown) {
				carlHitCounts += 1;
				if (carlHitCounts == (MAXIMUM_CARL_HITS - 1))
					[[AudioController sharedInstance] playEffect:@"carl-laugh.caf"];
			} else {
				[[[WhackABossAppDelegate get] gameLayer] showCreatureWarning:CARL_TYPE];
				carlWarningShown = TRUE;
				[WABSettings get].carlWarningShown = TRUE;
				[[WABSettings get] saveSettings];
				return;
			}
			break;
		default:
			NSLog(@"Unknown creature type struck");
			break;
	}
	
	// check sexy and carl hit counts
	if (sexyHitCounts == MAXIMUM_SEXY_HITS) {
		[[[WhackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_SEXY];
		return;
	}
	if (carlHitCounts == MAXIMUM_CARL_HITS) {
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
	carlHitCounts = 0;
	sexyHitCounts = 0;
	carlWarningShown = [[WABSettings get] carlWarningShown];
	internWarningShown = [[WABSettings get] internWarningShown];
	joeWarningShown = [[WABSettings get] joeWarningShown];
	score = [NSNumber numberWithInt:0];
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
	level = [NSNumber numberWithInt:1];
	[[[[WhackABossAppDelegate get] gameLayer] scoreLayer] updateLevel:level];
}

@end
