//
//  SplashScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/11/09.
//  Copyright Vault Head Games 2010 All rights reserved.
//

// Import the interfaces
#import "VariableStore.h"
#import "SplashScene.h"
#import "MainMenuScene.h"
#import "Constants.h"

// HelloWorld implementation
@implementation Splash

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Splash *layer = [Splash node];
	
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
		CCSprite *splashSprite = [[CCSprite spriteWithFile:@"Default.png"] retain];
		splashSprite.anchorPoint = CGPointZero;
		[self addChild:splashSprite];
		
		// Load variables and other needed things
		[[VariableStore sharedInstance] loadSettings:false withDelegate:self withSelector:@selector(onVariablesLoaded:)];
	}
	return self;
}

-(void) onVariablesLoaded:(id)e
{
	// we're good to continue on!
	[self schedule:@selector(continueOn:) interval:.5];
}

- (void) continueOn:(ccTime)e
{
	[[CCDirector sharedDirector] replaceScene: [CCFadeTransition transitionWithDuration:1.5 scene: [MainMenu scene]]];
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
