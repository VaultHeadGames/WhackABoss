//
//  CreatureStrikeHandler.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBCreature.h"

@interface CreatureStrikeHandler : NSObject {
	
}

+(CreatureStrikeHandler*) sharedInstance;

-(void) creatureReportsTouch:(WBCreature*)reporter;

@end
