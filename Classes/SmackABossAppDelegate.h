//
//  SmackABossAppDelegate.h
//  SmackABoss
//
//  Created by Jonathan Enzinna on 4/15/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuLayer.h"
#import "GameLayer.h"
#import "AboutLayer.h"
#import "SettingsLayer.h"

@interface SmackABossAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	
@private
	MenuLayer *menuLayer;
	GameLayer *gameLayer;
	AboutLayer *aboutLayer;
	SettingsLayer *settingsLayer;
	CCSpriteSheet *spriteSheet;
	CCScene *gameScene, *settingsScene, *aboutScene, *menuScene;
}

@property (nonatomic,readonly) MenuLayer *menuLayer;
@property (nonatomic,readonly) GameLayer *gameLayer;
@property (nonatomic,readonly) AboutLayer *aboutLayer;
@property (nonatomic,readonly) SettingsLayer *settingsLayer;
@property (nonatomic,readonly) CCSpriteSheet *spriteSheet;
@property (nonatomic,readonly) CCScene *gameScene;
@property (nonatomic,readonly) CCScene *settingsScene;
@property (nonatomic,readonly) CCScene *aboutScene;
@property (nonatomic,readonly) CCScene *menuScene;

+(SmackABossAppDelegate *) get;

@end
