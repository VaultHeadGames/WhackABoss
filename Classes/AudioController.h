//
//  AudioController.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioController : NSObject <AVAudioPlayerDelegate> {

}

+(AudioController *) sharedInstance;

@end
