//
//  Settings.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/22/09.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WABSettings : NSObject {
	NSUserDefaults* savedSettings;
	BOOL soundEnabled;
	BOOL vibrateEnabled;
	BOOL awesomeEnabled;
}

+ (WABSettings *)sharedInstance;
-(void) loadSettings:(BOOL)overrideDefaults withDelegate:(id)target withSelector:(SEL)completionSelector;
-(void) saveSettings;

@property (nonatomic,retain) NSUserDefaults* savedSettings;
@property (nonatomic,readwrite) BOOL soundEnabled;
@property (nonatomic,readwrite) BOOL vibrateEnabled;
@property (nonatomic,readwrite) BOOL awesomeEnabled;

@end
