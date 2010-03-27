//
//  Splash.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "Splash.h"
#import "WhackABossAppDelegate.h"
#import "WABSettings.h"

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
	[[WABSettings get] loadSettings:TRUE withDelegate:self withSelector:@selector(switchScenes:)];
}

-(void) switchScenes:(id)sender
{
	@synchronized (self) {
		if (is_fading)
			return;
		is_fading = TRUE;
				
		CCTransitionScene *transition = [CCCrossFadeTransition transitionWithDuration:0.5 scene:[[WhackABossAppDelegate get] menuScene]];
				
		[[CCDirector sharedDirector] replaceScene:transition];
//		[transition release];
	}
}

@end
