//
//  EndGameLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/26/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "EndGameLayer.h"
#import "WhackABossAppDelegate.h"
#import "OFHandler.h"
#import "ScoreManager.h"
#import "WABSettings.h"
#import "AudioController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Constants.h"

@implementation EndGameLayer

-(id) initWithEndGame:(EndGameCondition)condition
{
	if ((self == [super init])) {
		switch (condition) {
			case ENDGAME_WIN:
				egSprite = [CCSprite spriteWithFile:@"endGame_win.png"];
				if ([[OFHandler sharedInstance] feintIsActive]) {
					if ([[ScoreManager get] struckNonBoss]) {
						[[OFHandler sharedInstance] registerAchivement:IT_FEELS_GOOD_TO_BE_A_GANGSTA];
					} else {
						[[OFHandler sharedInstance] registerAchivement:DOG_THE_BOSS_HUNTER];
					}
				}
				break;
			case ENDGAME_FAIL:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"endGame_fired.png"];
				[[AudioController sharedInstance] playEffect:@"fired.caf"];
				if ([[OFHandler sharedInstance] feintIsActive]) {
					if ([[ScoreManager get] struckNonJoe]) {
						[[OFHandler sharedInstance] registerAchivement:WHAT_EXACTLY_IS_IT_YOU_DO_HERE];
					} else {
						[[OFHandler sharedInstance] registerAchivement:MASTER_OF_FIRST_IMPRESSIONS];
					}
				}
				break;
			case ENDGAME_POSTAL:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"endGame_postal.png"];
				[[AudioController sharedInstance] playEffect:@"postal-end.caf"];
				if ([[OFHandler sharedInstance] feintIsActive]) {
					if ([[ScoreManager get] struckNonCarl]) {
						[[OFHandler sharedInstance] registerAchivement:POSTAL_CARRIER];
					} else {
						[[OFHandler sharedInstance] registerAchivement:I_LOVE_THE_SMELL_OF_NAPALM_IN_THE_MORNING];
					}
				}
				break;
			case ENDGAME_SEXY:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"endGame_harassment.png"];
				[[AudioController sharedInstance] playEffect:@"uhoh.caf"];
				if ([[OFHandler sharedInstance] feintIsActive]) {
					if ([[ScoreManager get] struckNonIntern]) {
						[[OFHandler sharedInstance] registerAchivement:CASSANOVA_FAIL];
					} else {
						[[OFHandler sharedInstance] registerAchivement:EASY_THERE_TIGER];
					}
				}
				break;
			default:
				break;
		}
		egSprite.anchorPoint = CGPointZero;
		[self addChild:egSprite z:10];
		[self schedule:@selector(finish:) interval:8];
		// determine running losses
		if ([[WABSettings get] lastEnd] == [[WABSettings get] last2End]) {
			if (condition == [[WABSettings get] lastEnd]) {
				switch (condition) {
					case ENDGAME_SEXY:
						if ([[OFHandler sharedInstance] feintIsActive])
							[[OFHandler sharedInstance] registerAchivement:SUPER_FREAK];
						break;
					case ENDGAME_POSTAL:
						if ([[OFHandler sharedInstance] feintIsActive])
							[[OFHandler sharedInstance] registerAchivement:THE_THREE_HORSEMEN];
						break;
					case ENDGAME_FAIL:
						if ([[OFHandler sharedInstance] feintIsActive])
							[[OFHandler sharedInstance] registerAchivement:UNEMPLOYED_FOR_LIFE];
						break;
					default:
						break;
				}
			}
		}
		[WABSettings get].last2End = [WABSettings get].lastEnd;
		[WABSettings get].lastEnd = condition;
		[[WABSettings get] saveSettings];
	}
	
	return self;
}

-(void) finish:(id)sender
{
	if ([[OFHandler sharedInstance] feintIsActive])
		[[OFHandler sharedInstance] registerHighScore:[[ScoreManager get] score]];
	[self unschedule:@selector(finish:)];
	CCCrossFadeTransition *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[WhackABossAppDelegate get] menuScene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

@end
