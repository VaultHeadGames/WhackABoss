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
	BOOL carlWarningShown;
	BOOL internWarningShown;
	BOOL joeWarningShown;
}

+ (WABSettings *)get;
-(void) loadSettings:(BOOL)overrideDefaults withDelegate:(id)target withSelector:(SEL)completionSelector;
-(void) saveSettings;

@property (nonatomic,retain) NSUserDefaults* savedSettings;
@property (nonatomic,readwrite) BOOL soundEnabled;
@property (nonatomic,readwrite) BOOL vibrateEnabled;
@property (nonatomic,readwrite) BOOL awesomeEnabled;
@property (nonatomic,readwrite) BOOL carlWarningShown;
@property (nonatomic,readwrite) BOOL internWarningShown;
@property (nonatomic,readwrite) BOOL joeWarningShown;

@end
