//
//  GameLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import "ScoreLayer.h"
#import "WBCreature.h"

#define ROW_ONE_SCALE (135.5/150)
#define ROW_ONE_X_BOTTOM 164
#define ROW_TWO_SCALE (112.5/150)
#define ROW_TWO_X_BOTTOM 268
#define ROW_THREE_SCALE (103.5/150)
#define ROW_THREE_X_BOTTOM 345

@interface GameLayer : CCLayer {
	ScoreLayer *scoreLayer;
	
@private
	BOOL isPaused;
	BOOL isRunning;
	
	WBCreature *c11;
	WBCreature *c12;
	WBCreature *c13;
	WBCreature *c21;
	WBCreature *c22;
	WBCreature *c23;
	WBCreature *c31;
	WBCreature *c32;
	WBCreature *c33;
}

@property (nonatomic, readwrite) BOOL isPaused;
@property (nonatomic, readonly) BOOL isRunning;
@property (nonatomic, retain) ScoreLayer *scoreLayer;

-(void) reset;

-(void) mainTick:(ccTime)dt;

@end
