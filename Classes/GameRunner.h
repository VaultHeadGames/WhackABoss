//
//  GameRunner.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"

@interface GameRunner : CCNode {
	uint currentScore;
	uint sexyHitCounts;
	uint carlHitCounts;
	uint brickHitCounts;
	uint currentLevel;
	BOOL gameRunning;
	BOOL gameHasStarted;
}

@property (nonatomic,readwrite) uint currentScore;
@property (nonatomic,readwrite) uint currentLevel;
@property (nonatomic,readwrite) uint sexyHitCounts;
@property (nonatomic,readwrite) uint carlHitCounts;
@property (nonatomic,readwrite) uint brickHitCounts;
@property (nonatomic) BOOL gameRunning;
@property (nonatomic) BOOL gameHasStarted;

+(GameRunner*) sharedInstance;

-(void) pauseGame;
-(void) resumeGame;
-(void) startGame;
-(void) checkScoreAndSexyCounts;
-(void) proceedToNextLevel;
-(void) proceedToEndGame:(EndGameCondition)endCondition;
-(void) tick:(ccTime)dt;
-(double) creatureFadeOutTime;

@end
