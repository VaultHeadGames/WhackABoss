//
//  ScoreLayer.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/17/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "ScoreLayer.h"

@implementation ScoreLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {	
		levelLabel = [CCLabelAtlas labelAtlasWithString:@"1" charMapFile:@"scoreCharMap.png" itemWidth:6 itemHeight:8 startCharMap:'.'];
		[levelLabel setAnchorPoint:ccp(.5,.5)];
		[levelLabel setPosition:ccp(40,419)];
		[self addChild:levelLabel];
	
		scoreLabel = [CCLabelAtlas labelAtlasWithString:@"0" charMapFile:@"scoreCharMap.png" itemWidth:6 itemHeight:8 startCharMap:'.'];
		[scoreLabel setAnchorPoint:ccp(.5,.5)];
		[scoreLabel setPosition:ccp(102, 419)];
		[self addChild:scoreLabel];
	}
	
	return self;
}

-(void) updateScore:(NSNumber *)score
{
	[scoreLabel setString:[NSString stringWithFormat:@"%i",score]];
}

@end
