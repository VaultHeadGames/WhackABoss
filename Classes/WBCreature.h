//
//  WBCreature.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>

#define CREATURE_TYPE_BOSS	0x01
#define CREATURE_TYPE_SEXY	0x02
#define CREATURE_TYPE_CARL	0x03
#define CREATURE_TYPE_JOE	0x04
#define CREATURE_TYPE_BRICK	0x05

#define CREATURE_STATE_IDLE			0x00
#define CREATURE_STATE_GOING_UP		0x01
#define CREATURE_STATE_HOLDING		0x02
#define CREATURE_STATE_GOING_DOWN	0x03

@interface WBCreature : CCSprite <CCTargetedTouchDelegate> {
	NSNumber* creatureType;
	NSNumber* state;
}

@property (nonatomic,retain) NSNumber* creatureType;
@property (nonatomic,retain) NSNumber* state;

-(void) registerForPopUp;
-(void) takeTick;

@end
