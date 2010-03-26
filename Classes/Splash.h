//
//  Splash.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"

@interface SplashTransition : CCCrossFadeTransition {

}
@end

@interface Splash : CCSprite {

@private
	BOOL is_fading;
}

-(void) switchScenes:(id)sender;

@end
