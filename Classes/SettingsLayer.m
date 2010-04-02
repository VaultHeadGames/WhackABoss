//
//  SettingsLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "SettingsLayer.h"
#import "WABSettings.h"
#import "WhackABossAppDelegate.h"
#import "AudioController.h"

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
		
		vibrateSlider = [[[WABSlider alloc] init] retain];
		vibrateSlider.position = ccp(222,378);
		
		soundSlider = [[[WABSlider alloc] init] retain];
		soundSlider.position = ccp(222,317);
		
		awesomeSlider = [[[WABSlider alloc] init] retain];
		awesomeSlider.position = ccp(222,254);
		
		backButton = [CCMenuItemImage itemFromNormalImage:@"settingsBack.png" selectedImage:@"settingsBackSel.png" target:self selector:@selector(backToMainMenu:)];
		backButton.anchorPoint = CGPointZero;
		
		warningsReset = [CCMenuItemImage itemFromNormalImage:@"settingsReset.png" selectedImage:@"settingsResetSel.png" target:self selector:@selector(doResetWarnings:)];
		warningsReset.anchorPoint = ccp(0.5,0.5);
		warningsReset.position = ccp(160,200);
		
		backMenu = [CCMenu menuWithItems:backButton,warningsReset,nil];
		backMenu.position = CGPointZero;
		[self addChild:backMenu z:1];
		
		[vibrateSlider setValue: [[WABSettings get] vibrateEnabled]];
		[self addChild:vibrateSlider z:0];
		[soundSlider setValue: [[WABSettings get] soundEnabled]];
		[self addChild:soundSlider z:0];
		[awesomeSlider setValue: [[WABSettings get] awesomeEnabled]];
		[self addChild:awesomeSlider z:0];
	}
	
	return self;
}

-(void) backToMainMenu:(id)sender
{
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	
	CCCrossFadeTransition *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[WhackABossAppDelegate get] menuScene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(void) doResetWarnings:(id)sender
{
	[[AudioController sharedInstance] playEffect:@"Select5.caf"];
	
	[WABSettings get].joeWarningShown = FALSE;
	[WABSettings get].carlWarningShown = FALSE;
	[WABSettings get].internWarningShown = FALSE;
	[[WABSettings get] saveSettings];
}

-(void) saveSettings
{
	[WABSettings get].vibrateEnabled = vibrateSlider.value;
	[WABSettings get].soundEnabled = soundSlider.value;
	[WABSettings get].awesomeEnabled = awesomeSlider.value;
	[[WABSettings get] saveSettings];
}

@end
