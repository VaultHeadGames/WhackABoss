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
	uint sexyHitCounts;
	uint carlHitCounts;
	
	BOOL internWarningShown;
	BOOL carlWarningShown;
	BOOL joeWarningShown;
}

@property (nonatomic,readonly) NSNumber *score;
@property (nonatomic,readonly) NSNumber *level;
@property (nonatomic,readonly) uint sexyHitCounts;
@property (nonatomic,readonly) uint carlHitCounts;

+(ScoreManager *) get;

-(void) tallyScoreChange:(CreatureType) cType;
-(void) levelUp;
-(double) creatureFadeOutTime;

-(void) reset;

@end
