//
//  WABSlider.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface WABSlider : CCSprite <CCTargetedTouchDelegate> {

@private
	BOOL _value;
	BOOL _currentState;
	BOOL _moving;
	CCSprite *_slider;
	CCSprite *_sliderBg;
}

@property (nonatomic, readwrite) BOOL value;

-(void) updateSlidePosition;
-(void) slideMoveFinished:(id)sender;

@end
