//
//  AudioController.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "AudioController.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "WABSettings.h"

@implementation AudioController

+(AudioController *) sharedInstance
{
	static AudioController *instance = nil;
	
	if (!instance)
		instance = [[AudioController alloc] init];
	
	return instance;
}

-(id) init
{
	if ((self = [super init])) {
		_engine = [SimpleAudioEngine sharedEngine];
	}
	
	return self;
}

-(void) preload
{	
	[_engine preloadEffect:@"Select5.caf"];
	[_engine preloadEffect:@"IncDec5a.caf"];
	[_engine preloadEffect:@"hit1.caf"];
	[_engine preloadEffect:@"hit2.caf"];
	[_engine preloadEffect:@"hit3.caf"];
	[_engine preloadEffect:@"carl-laugh.caf"];
	[_engine preloadEffect:@"sexy-hit.caf"];
	[_engine preloadEffect:@"sexy-no.caf"];
}

-(void) playEffect:(NSString *)file
{
	if ([[WABSettings get] soundEnabled])
		[_engine playEffect:file];
}

-(void) playRandomHit
{
	int myPick = arc4random() % 3;
	if (myPick <= 1)
		[self playEffect:@"hit1.caf"];
	else if (myPick <= 2)
		[self playEffect:@"hit2.caf"];
	else 
		[self playEffect:@"hit3.caf"];

}

@end
