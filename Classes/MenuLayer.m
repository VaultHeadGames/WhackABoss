//
//  MenuLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "MenuLayer.h"
#import "SmackABossAppDelegate.h"
#import "Constants.h"
#import "OFHandler.h"
#import "AudioController.h"

@implementation MenuLayer
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		// first the background
		background = [CCSprite spriteWithFile:@"startscreen.png"];
		background.anchorPoint = CGPointZero;
		[self addChild: background z:-1];
		
		// create and initialize our labels
		versionLabel = [CCLabel labelWithString:[NSString stringWithFormat:@"v.%i.%i.%i%@",VERSION_MAJOR,VERSION_MINOR,VERSION_REV,VERSION_TAG] fontName:@"Marker Felt" fontSize:12];
		
		startGame = [CCMenuItemImage itemFromNormalImage:@"startgame.png" selectedImage:@"startgameSel.png" target:self selector:@selector(go_start_game:)];
		leaderboard = [CCMenuItemImage itemFromNormalImage:@"leaderboard.png" selectedImage:@"leaderboardSel.png" target:self selector:@selector(go_leaderboard:)];
		achievements = [CCMenuItemImage itemFromNormalImage:@"achievements.png" selectedImage:@"achievementsSel.png" target:self selector:@selector(go_achievements:)];
		settings = [CCMenuItemImage itemFromNormalImage:@"settings.png" selectedImage:@"settingsSel.png" target:self selector:@selector(go_settings:)];
		about = [CCMenuItemImage itemFromNormalImage:@"about.png" selectedImage:@"aboutSel.png" target:self selector:@selector(go_about:)];
		
		startGame.position = ccp(235,280);
		leaderboard.position = ccp(216,242);
		achievements.position = ccp(205,192.5);
		settings.position = ccp(194,120);
		about.position = ccp(190,78.5);
		
		mainMenu = [CCMenu menuWithItems:startGame,leaderboard,achievements,settings,about,nil];
		mainMenu.position = CGPointZero;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// position the label on the center of the screen
		versionLabel.position = ccp( size.width /2, 6);
		versionLabel.color = ccc3(0,0,0);
		
		[self addChild: versionLabel];
		[self addChild: mainMenu];
		[[AudioController sharedInstance] startMusic];
	}
	return self;
}

- (void) go_start_game:(id)e
{	
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	CCTransitionScene *trans = [CCFadeTransition transitionWithDuration:.5 scene:[[SmackABossAppDelegate get] gameScene] withColor:ccWHITE];
	
	[[CCDirector sharedDirector] replaceScene:trans];
	
	[[[SmackABossAppDelegate get] gameLayer] scheduleStart];
}

- (void) go_leaderboard:(id)e
{
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	[[OFHandler sharedInstance] showLeaderboard];
}

- (void) go_achievements:(id)e
{
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	[[OFHandler sharedInstance] showAchievements];
}

- (void) go_settings:(id)e
{	
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	CCTransitionScene *trans = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[SmackABossAppDelegate get] settingsScene]];
	
	[[CCDirector sharedDirector] replaceScene:trans];
}

- (void) go_about:(id)e
{	
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	CCTransitionScene *trans = [CCCrossFadeTransition transitionWithDuration:1 scene:[[SmackABossAppDelegate get] aboutScene]];
	
	[[CCDirector sharedDirector] replaceScene:trans];
}

@end
