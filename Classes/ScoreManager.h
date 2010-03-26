//
//  ScoreManager.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBCreature.h"

@interface ScoreManager : NSObject {

@private
	NSNumber *score;
	NSNumber *level;
	NSNumber *sexyHitCounts;
	NSNumber *carlHitCounts;
}

@property (nonatomic,readonly) NSNumber *score;
@property (nonatomic,readonly) NSNumber *level;
@property (nonatomic,readonly) NSNumber *sexyHitCounts;
@property (nonatomic,readonly) NSNumber *carlHitCounts;

+(ScoreManager *) get;

-(void) tallyScoreChange:(CreatureType) cType;
-(double) creatureFadeOutTime;

@end
