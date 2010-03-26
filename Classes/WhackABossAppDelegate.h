//
//  WhackABossAppDelegate.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuLayer.h"
#import "GameLayer.h"
#import "AboutLayer.h"
#import "SettingsLayer.h"

@interface WhackABossAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	
@private
	MenuLayer *menuLayer;
	GameLayer *gameLayer;
	AboutLayer *aboutLayer;
	SettingsLayer *settingsLayer;
	CCSpriteSheet *spriteSheet;
}

@property (nonatomic,readonly) MenuLayer *menuLayer;
@property (nonatomic,readonly) GameLayer *gameLayer;
@property (nonatomic,readonly) AboutLayer *aboutLayer;
@property (nonatomic,readonly) SettingsLayer *settingsLayer;
@property (nonatomic,readonly) CCSpriteSheet *spriteSheet;

+(WhackABossAppDelegate *) get;


@end
