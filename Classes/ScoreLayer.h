//
//  ScoreLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/17/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"

@interface ScoreLayer : CCSprite {
	CCLabelAtlas* levelLabel;
	CCLabelAtlas* scoreLabel;
}

-(void) updateScore:(NSNumber *)score;


@end
