//
//  VariableStore.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 9/22/09.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VariableStore : NSObject {
	NSString* playerName;
	NSUserDefaults* savedSettings;
	NSNumber* soundEnabled;
	NSNumber* musicEnabled;
}

+ (VariableStore *)sharedInstance;
-(void) loadSettings:(bool)overrideDefaults withDelegate:(id)target withSelector:(SEL)completionSelector;
-(void) saveSettings;

@property (nonatomic,retain) NSString* playerName;
@property (nonatomic,retain) NSUserDefaults* savedSettings;
@property (nonatomic,retain) NSNumber* soundEnabled;
@property (nonatomic,retain) NSNumber* musicEnabled;

@end
