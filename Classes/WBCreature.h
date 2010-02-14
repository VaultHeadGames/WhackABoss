//
//  WBCreature.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>

typedef enum
{
	BOSS_TYPE,
	SEXY_TYPE,
	CARL_TYPE,
	JOE_TYPE,
	BRICK_TYPE
} CreatureType;

typedef enum
{
	STATE_IDLE,
	STATE_GOING_UP,
	STATE_HOLDING,
	STATE_GOING_DOWN
} CreatureState;

@interface WBCreature : CCSprite <CCTargetedTouchDelegate> {
	CreatureType* type;
	CreatureState* state;
}

@property (nonatomic) CreatureType* type;
@property (nonatomic) CreatureState* state;

-(void) registerForPopUp;
-(void) takeTick;

@end
