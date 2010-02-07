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
}

+ (VariableStore *)sharedInstance;

@property (nonatomic,retain) NSString* playerName;

@end
