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
		_condition = condition;
		switch (condition) {
			case ENDGAME_WIN:
				egSprite = [CCSprite spriteWithFile:@"end-00-pre-win-screen.png"];
				eg2Sprite = [CCSprite spriteWithFile:@"end-01-win-screen.png"];
				break;
			case ENDGAME_FAIL:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"end-20-pre-fired-screen.png"];
				eg2Sprite = [CCSprite spriteWithFile:@"end-21-pre-fired-screen.png"];
				break;
			case ENDGAME_POSTAL:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"end-10-pre-postal-screen.png"];
				eg2Sprite = [CCSprite spriteWithFile:@"end-11-postal-screen.png"];
				break;
			case ENDGAME_SEXY:
				if ([WABSettings get].vibrateEnabled)
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				egSprite = [CCSprite spriteWithFile:@"end-30-pre-harassment-screen.png"];
				eg2Sprite = [CCSprite spriteWithFile:@"end-31-harassment-screen.png"];
				break;
			default:
				break;
		}
		egSprite.anchorPoint = CGPointZero;
		eg2Sprite.anchorPoint = CGPointZero;
		[self addChild:egSprite z:10];
		[self addChild:eg2Sprite z: 2];
		[egSprite runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:5],[CCFadeTo actionWithDuration:0.5 opacity:0],[CCCallFuncN actionWithTarget:self selector:@selector(finish:)],nil]];
	}
	return self;
}

-(void) checkFeintAchivementsAndPlaySound
{
	switch (_condition) {
		case ENDGAME_WIN:
			if ([[OFHandler sharedInstance] feintIsActive]) {
				if ([[ScoreManager get] struckNonBoss]) {
					[[OFHandler sharedInstance] registerAchivement:IT_FEELS_GOOD_TO_BE_A_GANGSTA];
				} else {
					[[OFHandler sharedInstance] registerAchivement:DOG_THE_BOSS_HUNTER];
				}
			}
			break;
		case ENDGAME_POSTAL:
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
			[[AudioController sharedInstance] playEffect:@"uhoh.caf"];
			if ([[OFHandler sharedInstance] feintIsActive]) {
				if ([[ScoreManager get] struckNonIntern]) {
					[[OFHandler sharedInstance] registerAchivement:CASSANOVA_FAIL];
				} else {
					[[OFHandler sharedInstance] registerAchivement:EASY_THERE_TIGER];
				}
			}
			break;
		case ENDGAME_FAIL:
			[[AudioController sharedInstance] playEffect:@"fired.caf"];
			if ([[OFHandler sharedInstance] feintIsActive]) {
				if ([[ScoreManager get] struckNonJoe]) {
					[[OFHandler sharedInstance] registerAchivement:WHAT_EXACTLY_IS_IT_YOU_DO_HERE];
				} else {
					[[OFHandler sharedInstance] registerAchivement:MASTER_OF_FIRST_IMPRESSIONS];
				}
			}
			break;
	}
	// determine running losses
	if ([[WABSettings get] lastEnd] == [[WABSettings get] last2End]) {
		if (_condition == [[WABSettings get] lastEnd]) {
			switch (_condition) {
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
	[WABSettings get].lastEnd = _condition;
	[[WABSettings get] saveSettings];
}

-(void) finish:(id)sender
{
	[self checkFeintAchivementsAndPlaySound];
	if ([[OFHandler sharedInstance] feintIsActive])
		[[OFHandler sharedInstance] registerHighScore:[[ScoreManager get] score]];
	[self runAction:[CCSequence actions:[CCIntervalAction actionWithDuration:8],[CCCallFuncN actionWithTarget:self selector:@selector(fadeBackToMenu:)],nil]];
}

-(void) fadeBackToMenu:(id)sender
{
	CCCrossFadeTransition *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[WhackABossAppDelegate get] menuScene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

@end
