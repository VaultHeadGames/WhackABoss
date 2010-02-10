//
//  SettingsUIView.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/9/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "SettingsUIView.h"
#import "OFHandler.h"
#import "VariableStore.h"

@implementation SettingsUIView

@synthesize switchMusic;
@synthesize switchSound;
@synthesize buttonOpenFeint;

- (IBAction) buttonOpenFeintClicked:(id)sender
{
	NSLog(@"OpenFeintSettingsButtonClicked");
	[[OFHandler sharedInstance] showLeaderboard];
}

- (IBAction) switchMusicChanged:(id)sender
{
	[[VariableStore sharedInstance] setMusicEnabled:(switchMusic.on) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0]];
	[[VariableStore sharedInstance] saveSettings];
}

- (IBAction) switchSoundChanged:(id)sender
{
	[[VariableStore sharedInstance] setSoundEnabled:(switchSound.on) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0]];
	[[VariableStore sharedInstance] saveSettings];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"SettingsUIView post-ViewLoad init");
	[switchMusic setOn: ([VariableStore sharedInstance].musicEnabled == [NSNumber numberWithInt:1])];
	[switchSound setOn: ([VariableStore sharedInstance].soundEnabled == [NSNumber numberWithInt:1])];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
