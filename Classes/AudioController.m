//
//  AudioController.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "AudioController.h"


@implementation AudioController

+(AudioController *) sharedInstance
{
	static AudioController *instance = nil;
	
	if (!instance)
		instance = [[AudioController alloc] init];
	
	return instance;
}

@end
