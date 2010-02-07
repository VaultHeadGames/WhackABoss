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

+ (VariableStore *)sharedInstance {
	static VariableStore *instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}


@end
