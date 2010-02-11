//
//  GameRunner.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameRunner : NSObject {
	NSNumber* currentScore;
	NSNumber* sexyHitCounts;
	NSNumber* carlHitCounts;
	CCTexture2D* creatureSpriteMap;
	NSMutableArray* creatureArray;
}

@property (nonatomic,retain) NSNumber* currentScore;
@property (nonatomic,retain) NSNumber* sexyHitCounts;
@property (nonatomic,retain) NSNumber* carlHitCounts;
@property (nonatomic,retain) CCTexture2D* creatureSpriteMap;

+(GameRunner*) sharedInstance;

-(void) pauseGame;
-(void) startGame;
-(void) checkScoreAndSexyCounts;

@end
