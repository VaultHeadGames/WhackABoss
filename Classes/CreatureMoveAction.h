//
//  CreatureMoveAction.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/12/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import "WBCreature.h"

@interface CreatureMoveAction : CCIntervalAction {

@private
    BOOL running;
	CreatureState targetState;
	WBCreature* targetCreature;
	CGPoint targetPosition;
}

+(CreatureMoveAction*) initWithTarget: (WBCreature*) tgt andTargetState: (CreatureState) tgtState;

-(CreatureMoveAction*) setTarget: (WBCreature*) tgt setTargetState: (CreatureState) tgtState;

@end
