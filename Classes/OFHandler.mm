//
//  OFHandler.mm
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/7/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "OFHandler.h"
#import "Constants.h"
#import "OpenFeint.h"
#import "OFAppDelegate.h"

@implementation OFHandler
	
-(void) resignActive {
	[OpenFeint applicationWillResignActive];
}

-(void) becomeActive {
	[OpenFeint applicationDidBecomeActive];
}

-(id) init {
	// always super.init
	if( (self=[super init] )) {
		NSDictionary* feintSettings = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSNumber numberWithInt:UIInterfaceOrientationPortrait], OpenFeintSettingDashboardOrientation,
								  @"ShortName", OpenFeintSettingShortDisplayName, 
								  [NSNumber numberWithBool:NO], OpenFeintSettingEnablePushNotifications,
								  [NSNumber numberWithBool:YES], OpenFeintSettingDisableUserGeneratedContent,
								  nil
		];
		
		[OpenFeint initializeWithProductKey:OPENFEINT_PRODUCTKEY andSecret:OPENFEINT_SECRETKEY andDisplayName:@"Whack-A-Boss" andSettings:feintSettings andDelegates:Nil];
	}
	
	return self;
}

-(void) dealloc {
	[OpenFeint shutdown];
	[super dealloc];
}

+(OFHandler*) sharedInstance {
	static OFHandler* instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}

@end
