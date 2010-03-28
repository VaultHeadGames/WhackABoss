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

@implementation EndGameLayer

-(id) initWithEndGame:(EndGameCondition)condition
{
	if ((self == [super init])) {
		switch (condition) {
			case ENDGAME_WIN:
				egSprite = [CCSprite spriteWithFile:@"endGame_win.png"];
				break;
			case ENDGAME_FAIL:
				egSprite = [CCSprite spriteWithFile:@"endGame_fired.png"];
				break;
			case ENDGAME_POSTAL:
				egSprite = [CCSprite spriteWithFile:@"endGame_postal.png"];
				break;
			case ENDGAME_SEXY:
				egSprite = [CCSprite spriteWithFile:@"endGame_harassment.png"];
				break;
			default:
				break;
		}
		egSprite.anchorPoint = CGPointZero;
		[self addChild:egSprite z:10];
		[self schedule:@selector(finish:) interval:8];
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
