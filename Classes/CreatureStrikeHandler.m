//
//  CreatureStrikeHandler.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "CreatureStrikeHandler.h"
#import "GameRunner.h"
#import "WBCreature.h"
#import "SoundManager.h"

@implementation CreatureStrikeHandler

+(CreatureStrikeHandler*) sharedInstance {
	static CreatureStrikeHandler* instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}

-(void) creatureReportsTouch:(WBCreature*)reporter
{
	if (reporter.state == STATE_IDLE)
		return; // this isn't a valid click
	switch ((CreatureType)reporter.type) {
		case BOSS_TYPE:
			[GameRunner sharedInstance].currentScore += 1;
			break;
		case JOE_TYPE:
			[GameRunner sharedInstance].currentScore -= 1;
			break;
		case SEXY_TYPE:
			[GameRunner sharedInstance].sexyHitCounts += 1;
			break;
		case CARL_TYPE:
			[GameRunner sharedInstance].carlHitCounts += 1;
			break;
		case BRICK_TYPE:
			[GameRunner sharedInstance].brickHitCounts += 1;
			break;
		default:
			NSLog(@"Unknown creature type struck");
			break;
	}
	[[GameRunner sharedInstance] checkScoreAndSexyCounts];
}

@end
