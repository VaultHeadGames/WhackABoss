//
//  main.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/6/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	int retVal = UIApplicationMain(argc, argv, nil, @"WhackABossAppDelegate");
	[pool release];
	return retVal;
}
