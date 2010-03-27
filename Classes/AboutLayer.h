//
//  AboutLayer.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/25/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "cocos2d.h"

@interface AboutLayer : CCLayer {

@private
	CCLabel *aboutInformation;
	CCMenu *backMenu;
	CCMenuItem *backButton;
}

-(void) backToMainMenu:(id)sender;

@end
