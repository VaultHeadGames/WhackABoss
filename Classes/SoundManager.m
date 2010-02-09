//
//  SoundManager.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/8/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "SoundManager.h"
#import "VariableStore.h"

@implementation SoundManager

+(SoundManager*) sharedInstance {
	static SoundManager* instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}

-(bool) soundIsEnabled
{
}
-(bool) musicIsEnabled
{
}

-(id) init
{
	// always super.init
	if( (self=[super init] )) {
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end