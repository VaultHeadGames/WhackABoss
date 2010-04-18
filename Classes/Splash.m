//
//  Splash.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "Splash.h"
#import "SmackABossAppDelegate.h"
#import "WABSettings.h"
#import "AudioController.h"

@implementation Splash

-(id) init
{
	if( (self=[super init] )) {
		CCSprite *splashSprite = [[CCSprite spriteWithFile:@"Default.png"] retain];
		splashSprite.anchorPoint = CGPointZero;
		[self addChild:splashSprite];
	}
	return self;
}

-(void) onEnter
{
	//[self performSelector:@selector(switchScenes) withObject:nil afterDelay:2];
	[[AudioController sharedInstance] preload];
#if TARGET_IPHONE_SIMULATOR
	[[WABSettings get] loadSettings:TRUE withDelegate:self withSelector:@selector(switchScenes:)];
#else
	[[WABSettings get] loadSettings:FALSE withDelegate:self withSelector:@selector(switchScenes:)];
#endif
}

-(void) switchScenes:(id)sender
{
	[[AudioController sharedInstance] startMusic];
	@synchronized (self) {
		if (is_fading)
			return;
		is_fading = TRUE;
				
		CCTransitionScene *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[SmackABossAppDelegate get] menuScene]];
				
		[[CCDirector sharedDirector] replaceScene:transition];
//		[transition release];
	}
}

@end
