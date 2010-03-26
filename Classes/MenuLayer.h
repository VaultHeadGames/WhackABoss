//
//  MenuLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"


@interface MenuLayer : CCLayer {
	
@private
	CCLabel *versionLabel;
	CCSprite *background;
	CCMenu *mainMenu;
	CCMenuItem *startGame, *achievements, *leaderboard, *settings, *about;
}

-(void) go_start_game:(id)e;
-(void) go_leaderboard:(id)e;
-(void) go_achievements:(id)e;
-(void) go_settings:(id)e;
-(void) go_about:(id)e;

@end
