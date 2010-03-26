//
//  SettingsLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "SettingsLayer.h"
#import "WABSettings.h"

@implementation SettingsLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		// first the background
		CCSprite *background = [CCSprite spriteWithFile:@"settingsscreen.png"];
		background.anchorPoint = CGPointZero;
		[self addChild: background z:-1];
		
		vibrateSlider = [[WABSlider alloc] init];
		vibrateSlider.position = ccp(222,348);
		[vibrateSlider setValue: [[WABSettings get] vibrateEnabled]];
		[self addChild:vibrateSlider z:0];
		
		soundSlider = [[WABSlider alloc] init];
		soundSlider.position = ccp(222,287);
		[soundSlider setValue: [[WABSettings get] soundEnabled]];
		[self addChild:soundSlider z:0];
		
		awesomeSlider = [[WABSlider alloc] init];
		awesomeSlider.position = ccp(222,224);
		[awesomeSlider setValue: [[WABSettings get] awesomeEnabled]];
		[self addChild:awesomeSlider z:0];
	}
	
	return self;
}

-(void) backToMainMenu
{
	[[CCDirector sharedDirector] popScene];
}

@end
