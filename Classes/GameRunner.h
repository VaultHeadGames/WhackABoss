//
//  GameRunner.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface GameRunner : CCNode {
	NSNumber* currentScore;
	NSNumber* sexyHitCounts;
	NSNumber* carlHitCounts;
	NSNumber* brickHitCounts;
	NSNumber* currentLevel;
	BOOL gameRunning;
	BOOL gameHasStarted;
	CCTexture2D* creatureSpriteMap;
	NSMutableArray* creatureArray;
}

@property (nonatomic,retain) NSNumber* currentScore;
@property (nonatomic,retain) NSNumber* sexyHitCounts;
@property (nonatomic,retain) NSNumber* carlHitCounts;
@property (nonatomic,retain) NSNumber* brickHitCounts;
@property (nonatomic,retain) NSMutableArray* creatureArray;
@property (nonatomic,retain) NSNumber* currentLevel;
@property (nonatomic) BOOL gameRunning;
@property (nonatomic) BOOL gameHasStarted;
@property (nonatomic,retain) CCTexture2D* creatureSpriteMap;

+(GameRunner*) sharedInstance;

-(void) pauseGame;
-(void) resumeGame;
-(void) startGame;
-(void) checkScoreAndSexyCounts;
-(void) tick:(id)e;
-(void) proceedToNextLevel;
-(void) proceedToEndGame:(EndGameCondition)endCondition;

-(double) creatureFadeOutTime;

@end
