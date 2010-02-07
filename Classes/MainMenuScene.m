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

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		main_label.position =  ccp( size.width /2 , size.height - 24 );
		version_label.position = ccp( size.width /2, 6);
		
		// add the label as a child to this Layer
		[self addChild: main_label];
		[self addChild: version_label];
	}
	return self;
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
