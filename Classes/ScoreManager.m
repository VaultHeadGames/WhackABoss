//
//  ScoreManager.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "ScoreManager.h"
#import "SmackABossAppDelegate.h"
#import "Constants.h"
#import "WABSettings.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AudioController.h"
#import "OFHandler.h"

@implementation ScoreManager

@synthesize score, level, sexyHitCounts, carlHitCounts, struckNonBoss, struckNonIntern, struckNonJoe, struckNonCarl;

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
			struckNonJoe = TRUE;
			struckNonCarl = TRUE;
			struckNonIntern = TRUE;
			NSLog(@"Struck BOSS_TYPE");
			score = [[NSNumber numberWithInt:[score intValue] + 1] retain];
			break;
		case JOE_TYPE:
			NSLog(@"Struck JOE_TYPE");
			struckNonBoss = TRUE;
			struckNonCarl = TRUE;
			struckNonIntern = TRUE;
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (joeWarningShown) {
				if ([score intValue] != 0) {
					score = [[NSNumber numberWithInt:[score intValue] - 1] retain];
				} else {
					[[[SmackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_FAIL];
					return;
				}
			} else {
				[[[SmackABossAppDelegate get] gameLayer] showCreatureWarning:JOE_TYPE];
				joeWarningShown = TRUE;
				[WABSettings get].joeWarningShown = TRUE;
				[[WABSettings get] saveSettings];
				return;
			}
			break;
		case SEXY_TYPE:
			NSLog(@"Struck SEXY_TYPE");
			struckNonBoss = TRUE;
			struckNonJoe = TRUE;
			struckNonCarl = TRUE;
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (internWarningShown) {
				sexyHitCounts += 1;
				if (sexyHitCounts == (MAXIMUM_SEXY_HITS - 1))
					[[AudioController sharedInstance] playEffect:@"sexy-no.caf"];
			} else {
				[[[SmackABossAppDelegate get] gameLayer] showCreatureWarning:SEXY_TYPE];
				internWarningShown = TRUE;
				[WABSettings get].internWarningShown = TRUE;
				[[WABSettings get] saveSettings];
				return;
			}
			break;
		case CARL_TYPE:
			NSLog(@"Struck CARL_TYPE");
			struckNonBoss = TRUE;
			struckNonJoe = TRUE;
			struckNonIntern = TRUE;
			if ([WABSettings get].vibrateEnabled)
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			if (carlWarningShown) {
				carlHitCounts += 1;
				if (carlHitCounts == (MAXIMUM_CARL_HITS - 1))
					[[AudioController sharedInstance] playEffect:@"carl-laugh.caf"];
			} else {
				[[[SmackABossAppDelegate get] gameLayer] showCreatureWarning:CARL_TYPE];
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
		[[[SmackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_SEXY];
		return;
	}
	if (carlHitCounts == MAXIMUM_CARL_HITS) {
		[[[SmackABossAppDelegate get] gameLayer] doEndGame:ENDGAME_POSTAL];
		return;
	}
	
	[[[[SmackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
}

-(void) levelUp
{
	level = [[NSNumber numberWithInt:[level intValue] + 1] retain];
	[[[[SmackABossAppDelegate get] gameLayer] scoreLayer] updateLevel:level];
	if ([[OFHandler sharedInstance] feintIsActive]) {
		if ([level intValue] == 2)
			[[OFHandler sharedInstance] registerAchivement:SURVIVED_YOUR_FIRST_DAY];
		if ([level intValue] == 6)
			[[OFHandler sharedInstance] registerAchivement:BARHOPPIN_];
		if ([level intValue] == 11)
			[[OFHandler sharedInstance] registerAchivement:THANKS_FOR_THE_PEANUTS];
	}
}

-(double) creatureFadeOutTime
{
	return MAX(0,3 - ((([level intValue] * BASELINE_DIFFICULTY_MODIFIER) * ([level intValue] * BASELINE_DIFFICULTY_MODIFIER)) / (BASELINE_DIFFICULTY_MODIFIER * 10)));
}

-(double) creatureMovementTime
{
	double calculatedTime;
	if ([level intValue] >= 5)
		calculatedTime = 0.8;
	else if ([level intValue] >= 15)
		calculatedTime = 0.8 - ([level intValue] * (BASELINE_DIFFICULTY_MODIFIER * 0.1));
	else
		calculatedTime = 0.8 - ([level intValue] * (BASELINE_DIFFICULTY_MODIFIER * 0.18));
	return MAX(0.25,calculatedTime);
}

-(void) reset
{
	carlHitCounts = 0;
	sexyHitCounts = 0;
	struckNonBoss = FALSE;
	struckNonJoe = FALSE;
	struckNonCarl = FALSE;
	struckNonIntern = FALSE;
	carlWarningShown = [[WABSettings get] carlWarningShown];
	internWarningShown = [[WABSettings get] internWarningShown];
	joeWarningShown = [[WABSettings get] joeWarningShown];
	score = [NSNumber numberWithInt:0];
	[[[[SmackABossAppDelegate get] gameLayer] scoreLayer] updateScore:score];
	level = [NSNumber numberWithInt:1];
	[[[[SmackABossAppDelegate get] gameLayer] scoreLayer] updateLevel:level];
}

@end
