//
//  MainMenuScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/6/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

// Import the interfaces
#import "MainMenuScene.h"
#import "Constants.h"
#import "OFHandler.h"
#import "AboutScene.h"
#import "SettingsScene.h"
#import "GameScene.h"
#import "GameRunner.h"

// HelloWorld implementation
@implementation MainMenu

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an MainMenu object.
	MainMenu *layer = [MainMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize our labels
		CCLabel* main_label = [CCLabel labelWithString:@"Whack-A-Boss" fontName:@"Marker Felt" fontSize:48];
		CCLabel* version_label = [CCLabel labelWithString:[NSString stringWithFormat:@"v.%i.%i.%i",VERSION_MAJOR,VERSION_MINOR,VERSION_REV] fontName:@"Marker Felt" fontSize:12];
		
		[CCMenuItemFont setFontName:@"Marker Felt"];
		[CCMenuItemFont setFontSize:28];
		
		CCMenuItem* mi_start_game = [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(go_start_game:)];
		CCMenuItem* mi_leaderboards = [CCMenuItemFont itemFromString:@"Leaderboards" target:self selector:@selector(go_leaderboard:)];
		CCMenuItem* mi_achievements = [CCMenuItemFont itemFromString:@"Achievements" target:self selector:@selector(go_achievements:)];
		CCMenuItem* mi_settings = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(go_settings:)];
		CCMenuItem* mi_about = [CCMenuItemFont itemFromString:@"About" target:self selector:@selector(go_about:)];
		
		CCMenu* main_menu = [CCMenu menuWithItems:mi_start_game,mi_leaderboards,mi_achievements,mi_settings,mi_about,nil];
		[main_menu alignItemsVertically];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		main_label.position =  ccp( size.width /2 , size.height - 24 );
		version_label.position = ccp( size.width /2, 6);
		
		// add the label as a child to this Layer
		[self addChild: main_label];
		[self addChild: version_label];
		[self addChild: main_menu];
		
		// display the background
		CCSprite* background = [CCSprite spriteWithFile:@"mm_background.png"];
		background.anchorPoint = CGPointZero;
		[self addChild: background z:-1];
	}
	return self;
}

- (void) go_start_game:(id)e
{
	[[CCDirector sharedDirector] replaceScene: [CCFadeTransition transitionWithDuration:1.5 scene: [GameScene scene] withColor: ccBLACK]];
}

- (void) go_leaderboard:(id)e
{
	[[OFHandler sharedInstance] showLeaderboard];
}
- (void) go_achievements:(id)e
{
	[[OFHandler sharedInstance] showAchievements];
}
- (void) go_settings:(id)e
{
	[[CCDirector sharedDirector] replaceScene: [CCPageTurnTransition transitionWithDuration:1.5 scene: [SettingsScene scene]]];
}
- (void) go_about:(id)e
{
	[[CCDirector sharedDirector] replaceScene: [CCZoomFlipYTransition transitionWithDuration:1.5 scene: [AboutScene scene]]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
