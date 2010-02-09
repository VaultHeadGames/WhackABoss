//
//  MainMenuScene.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/6/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface MainMenu : CCLayer
{
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) go_start_game:(id)e;
-(void) go_leaderboard:(id)e;
-(void) go_achievements:(id)e;
-(void) go_settings:(id)e;
-(void) go_about:(id)e;

@end
