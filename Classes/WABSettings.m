//
//  Settings.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/22/09.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WABSettings.h"

@implementation WABSettings

@synthesize vibrateEnabled, awesomeEnabled, soundEnabled, savedSettings;

-(void) loadSettings:(BOOL)overrideDefaults withDelegate:(id)target withSelector:(SEL)completionSelector
{
	NSLog(@"Loading settings...");
	// this is where we load stuffz
	if (([[savedSettings stringForKey:@"use_defaults"] length] == 0) || (overrideDefaults)) {
		// we're using defaults
		NSLog(@"	using defaults");
		vibrateEnabled = FALSE;
		soundEnabled = TRUE;
		awesomeEnabled = TRUE;
	} else {
		NSLog(@"	using saved");
		vibrateEnabled = (BOOL)[savedSettings valueForKey:@"vibrate_on"];
		soundEnabled = (BOOL)[savedSettings valueForKey:@"sound_on"];
		awesomeEnabled = (BOOL)[savedSettings valueForKey:@"awesomeness"];
	}
	if (target && completionSelector && [target respondsToSelector:completionSelector])
	{
		[target performSelector:completionSelector withObject:self];
	}
	NSLog(@"Settings or defaults loaded...");
}

-(void) saveSettings
{
	NSLog(@"Saving settings");
	[savedSettings setObject:[NSString stringWithFormat:@"%i",vibrateEnabled] forKey:@"vibrate_on"];
	[savedSettings setObject:[NSString stringWithFormat:@"%i",soundEnabled] forKey:@"sound_on"];
	[savedSettings setObject:[NSString stringWithFormat:@"%i",awesomeEnabled] forKey:@"awesomeness"];
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

+ (WABSettings *) get {
	static WABSettings *instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}


@end
