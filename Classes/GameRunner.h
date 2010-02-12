//
//  GameRunner.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameRunner : CCNode {
	NSNumber* currentScore;
	NSNumber* sexyHitCounts;
	NSNumber* carlHitCounts;
	NSNumber* brickHitCounts;
	NSNumber* currentLevel;
	CCTexture2D* creatureSpriteMap;
	NSMutableArray* creatureArray;
}

@property (nonatomic,retain) NSNumber* currentScore;
@property (nonatomic,retain) NSNumber* sexyHitCounts;
@property (nonatomic,retain) NSNumber* carlHitCounts;
@property (nonatomic,retain) NSNumber* brickHitCounts;
@property (nonatomic,retain) NSMutableArray* creatureArray;
@property (nonatomic,retain) NSNumber* currentLevel;
@property (nonatomic,retain) CCTexture2D* creatureSpriteMap;

+(GameRunner*) sharedInstance;

-(void) pauseGame;
-(void) startGame;
-(void) checkScoreAndSexyCounts;
-(void) tick:(id)e;

-(double) creatureFadeOutTime;

@end
