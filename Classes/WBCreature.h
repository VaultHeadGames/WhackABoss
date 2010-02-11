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

@interface WBCreature : CCSprite {
	NSNumber* creatureType;
}

@property (nonatomic,retain) NSNumber* creatureType;

+(id) initWithTexture:(CCTexture2D*)texture andPosition:(NSNumber*)pos;

@end
