//
//  OFHandler.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/7/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OFHandler : NSObject {

}

- (bool) feintIsActive;

- (void) resignActive;

- (void) becomeActive;

- (void) showLeaderboard;

- (void) showAchievements;

+ (OFHandler*) sharedInstance;

@end
