//
//  SettingsScene.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/8/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import "SettingsUIView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SettingsScene : CCLayer {
	SettingsUIView* uiView;
}

+(id) scene;

-(void) backToMain:(id)e;

@end
