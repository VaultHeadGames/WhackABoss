//
//  AudioController.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SimpleAudioEngine.h"

@interface AudioController : NSObject <AVAudioPlayerDelegate> {
@private
	SimpleAudioEngine *_engine;
}

+(AudioController *) sharedInstance;

-(void) preload;

-(void) playEffect:(NSString *)file;
-(void) playRandomHit;

-(void) startMusic;
-(void) stopMusic;

-(void) mute;
-(void) unMute;

@end
