//
//  EndGameLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/26/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"

typedef enum
{
	ENDGAME_WIN,
	ENDGAME_FAIL,
	ENDGAME_POSTAL,
	ENDGAME_SEXY
} EndGameCondition;

@interface EndGameLayer : CCLayer {
	
@private
	CCSprite *egSprite;
}

-(id) initWithEndGame:(EndGameCondition)condition;

@end
