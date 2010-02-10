//
//  AboutScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/8/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "AboutScene.h"
#import "MainMenuScene.h"

@implementation AboutScene
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an MainMenu object.
	AboutScene *layer = [AboutScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) backToMain:(id)e
{
	[[CCDirector sharedDirector] replaceScene: [CCZoomFlipXTransition transitionWithDuration:1.5 scene:[MainMenu scene]]];
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
		
		CCLabel* fuck_yeh = [CCLabel labelWithString:@"Fuck Yeh Bitchez" fontName:@"Arial" fontSize:18];
		fuck_yeh.position = ccp( size.width /2, size.height /2);
		[self addChild: fuck_yeh];
		
		// add the label as a child to this Layer
		[self addChild: main_label];
		[self addChild: menu_back];
	}
	return self;
}
@end
