//
//  VariableStore.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/22/09.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "VariableStore.h"

@implementation VariableStore

@synthesize playerName;
@synthesize musicEnabled;
@synthesize soundEnabled;
@synthesize savedSettings;

-(void) loadSettings:(bool)overrideDefaults withDelegate:(id)target withSelector:(SEL)completionSelector
{
	NSLog(@"Loading settings...");
	// this is where we load stuffz
	if ([[savedSettings stringForKey:@"use_defaults"] length] == 0) {
		// we're using defaults
		playerName = @"Lumberg";
		musicEnabled = 1;
		soundEnabled = 1;
	} else {
		playerName = [savedSettings stringForKey:@"player_name"];
		musicEnabled = [savedSettings valueForKey:@"music_on"];
		soundEnabled = [savedSettings valueForKey:@"sound_on"];
	}
	if (target && completionSelector && [target respondsToSelector:completionSelector])
	{
		[target performSelector:completionSelector withObject:self];
	}
	NSLog(@"Settings or defaults loaded...");
}

-(void) saveSettings
{
	[savedSettings setObject:musicEnabled forKey:@"music_on"];
	[savedSettings setObject:soundEnabled forKey:@"sound_on"];
	[savedSettings setObject:playerName forKey:@"player_name"];
	[savedSettings setObject:@"no" forKey:@"use_defaults"];
	[savedSettings synchronize];
}

-(id) init
{
	if( (self=[super init] )) {
		savedSettings = [NSUserDefaults standardUserDefaults];
	}
	return self;
}

+ (VariableStore *)sharedInstance {
	static VariableStore *instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}


@end
