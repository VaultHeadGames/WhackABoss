//
//  SettingsScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/8/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "SettingsScene.h"
#import "SettingsUIView.h"
#import "MainMenuScene.h"
#import "VariableStore.h"

@implementation SettingsScene
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an MainMenu object.
	SettingsScene *layer = [SettingsScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(void) backToMain:(id)e
{
	[[uiView view] removeFromSuperview];
	[[CCDirector sharedDirector] replaceScene: [CCPageTurnTransition transitionWithDuration:1.5 scene:[MainMenu scene] backwards:true]];
}

-(void) onEnterTransitionDidFinish
{
	[[[CCDirector sharedDirector] openGLView] addSubview: [uiView view]];
	[super onEnterTransitionDidFinish];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {		
		// create and initialize our labels
		CCLabel* main_label = [CCLabel labelWithString:@"Whack-A-Boss" fontName:@"Marker Felt" fontSize:48];
		
		[CCMenuItemFont setFontName:@"Marker Felt"];
		[CCMenuItemFont setFontSize:16];
		
		CCMenuItem* mi_back_to_main = [CCMenuItemFont itemFromString:@"Back" target:self selector:@selector(backToMain:)];
		CCMenu* menu_back = [CCMenu menuWithItems:mi_back_to_main,nil];
		
		// position the label on the center of the screen
		CGSize size = [[CCDirector sharedDirector] winSize];
		main_label.position =  ccp( size.width /2 , size.height - 24 );	
		menu_back.position = ccp( 24, 16);
		
		// add the label as a child to this Layer
		[self addChild: main_label];
		[self addChild: menu_back];
		
		uiView = [SettingsUIView new];
	}
	return self;
}
@end
