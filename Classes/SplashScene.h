//
//  SplashScene.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/11/09.
//  Copyright Vault Head Games 2010. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface Splash : CCLayer
{
}

- (void) onVariablesLoaded:(id)e;
- (void) continueOn:(ccTime)e;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
