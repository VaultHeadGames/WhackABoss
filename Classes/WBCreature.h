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
	JOE_TYPE
//	BRICK_TYPE
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
	CGPoint upPosition;
	CGPoint downPosition;
}

@property (nonatomic) CreatureState state;
//@property (nonatomic) CGPoint upPosition;
//@property (nonatomic) CGPoint downPosition;
@property (nonatomic,readonly) CreatureType creatureType;

-(void) changeCreatureType:(CreatureType)targetType;
-(void) registerForPopUp;
-(void) upCompleted:(id)sender;
-(void) completeStrikeDown:(id)sender;
-(void) strikeDown:(id)sender;
-(void) goDown:(id)sender;
-(void) downCompleted: (id)sender;
-(void) reset;
-(void) setUpPosition:(CGPoint)p;

@end
