//
//  AboutLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "AboutLayer.h"
#import "AudioController.h"
#import "WhackABossAppDelegate.h"

@implementation AboutLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		// first the background
		CCSprite *background = [CCSprite spriteWithFile:@"aboutscreen_back.png"];
		CCSprite *foreground = [CCSprite spriteWithFile:@"aboutscreen_for.png"];
		background.anchorPoint = CGPointZero;
		foreground.anchorPoint = CGPointZero;
		[self addChild: background z:-1];
		[self addChild: foreground z: 2];
		
		backButton = [CCMenuItemImage itemFromNormalImage:@"aboutBack.png" selectedImage:@"aboutBackSel.png" target:self selector:@selector(backToMainMenu:)];
		backButton.position = ccp(73,104);
		backMenu = [CCMenu menuWithItems:backButton,nil];
		backMenu.position = CGPointZero;
		[self addChild:backMenu z:3];
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:backMenu priority:1 swallowsTouches:FALSE];
	}
	
	return self;
}

-(void) backToMainMenu:(id)sender
{
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	CCCrossFadeTransition *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[WhackABossAppDelegate get] menuScene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

@end
