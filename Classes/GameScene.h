//
//  GameScene.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"

@interface GameScene : CCLayer {
	CCSpriteSheet* creatureSpriteMap;
	NSMutableArray* creatureArray;
	
	CCLabelAtlas* levelLabel;
	CCLabelAtlas* scoreLabel;
}

@property (nonatomic,retain) CCSpriteSheet* creatureSpriteMap;
@property (nonatomic,retain) NSMutableArray* creatureArray;

+(id) scene;

-(void) updateScore;
-(void) updateLevel;

-(void) startGame;
-(void) endGame;

@end
