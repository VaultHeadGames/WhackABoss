//
//  SoundManager.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/8/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject {

}

+ (SoundManager*) sharedInstance;

+(bool) musicIsEnabled;
+(bool) soundIsEnabled;

@end
