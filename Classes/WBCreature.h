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
	BOSS_TYPE = 0,
	SEXY_TYPE = 48,
	CARL_TYPE = 96,
	JOE_TYPE = 144,
	BRICK_TYPE = 192
} CreatureType;

typedef enum
{
	STATE_IDLE,
	STATE_GOING_UP,
	STATE_HOLDING,
	STATE_GOING_DOWN
} CreatureState;

@interface WBCreature : CCSprite <CCTargetedTouchDelegate> {
	CreatureState state;

@private
	CreatureType _creatureType;
	CCSprite *_creatureSprite;
}

@property (nonatomic) CreatureState state;
@property (nonatomic,readonly) CreatureType creatureType;

-(void) changeCreatureType:(CreatureType)targetType;
-(void) registerForPopUp;
-(void) upCompleted:(id)sender;
-(void) completeStrikeDown:(id)sender;
-(void) strikeDown:(id)sender;
-(void) goDown:(id)sender;
-(void) downCompleted: (id)sender;

@end
