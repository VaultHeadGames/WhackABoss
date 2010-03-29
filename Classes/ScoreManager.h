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
	BOOL struckNonBoss;
	BOOL struckNonIntern;
	BOOL struckNonJoe;
	BOOL struckNonCarl;
}

@property (nonatomic,readonly) NSNumber *score;
@property (nonatomic,readonly) NSNumber *level;
@property (nonatomic,readonly) uint sexyHitCounts;
@property (nonatomic,readonly) uint carlHitCounts;
@property (nonatomic,readonly) BOOL struckNonBoss;
@property (nonatomic,readonly) BOOL struckNonIntern;
@property (nonatomic,readonly) BOOL struckNonJoe;
@property (nonatomic,readonly) BOOL struckNonCarl;

+(ScoreManager *) get;

-(void) tallyScoreChange:(CreatureType) cType;
-(void) levelUp;
-(double) creatureFadeOutTime;
-(double) creatureMovementTime;

-(void) reset;

@end
