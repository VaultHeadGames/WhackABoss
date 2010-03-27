//
//  SettingsLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"
#import "WABSlider.h"

@interface SettingsLayer : CCLayer {

@private
	WABSlider *vibrateSlider;
	WABSlider *soundSlider;
	WABSlider *awesomeSlider;
	CCMenu *backMenu;
	CCMenuItem *backButton;
}

-(void) backToMainMenu:(id)sender;

@end
