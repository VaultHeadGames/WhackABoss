//
//  WhackABossAppDelegate.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 3/24/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

#import "WhackABossAppDelegate.h"
#import "cocos2d.h"
#import "Splash.h"
#import "MenuLayer.h"
#import "Constants.h"
#import "OFHandler.h"
#import "GameLayer.h"
#import "AboutLayer.h"
#import "SettingsLayer.h"

@implementation WhackABossAppDelegate

@synthesize menuLayer, gameLayer, aboutLayer, settingsLayer;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// cocos2d will inherit these values
	[window setUserInteractionEnabled:YES];	
	[window setMultipleTouchEnabled:YES];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:CCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:CCDirectorTypeDefault];
	
	// Use RGBA_8888 buffers
	// Default is: RGB_565 buffers
	[[CCDirector sharedDirector] setPixelFormat:kPixelFormatRGBA8888];
	
	// Create a depth buffer of 16 bits
	// Enable it if you are going to use 3D transitions or 3d objects
	//	[[CCDirector sharedDirector] setDepthBufferFormat:kDepthBuffer16];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];
	
	// before creating any layer, set the landscape mode
	[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationPortrait];
	[[CCDirector sharedDirector] setAnimationInterval:1.0/60];
	[[CCDirector sharedDirector] setDisplayFPS:NO];
	
	// create an openGL view inside a window
	[[CCDirector sharedDirector] attachInView:window];	
	[window makeKeyAndVisible];
	
	CCScene *splashScene = [[CCScene node] retain];
	CCSprite *splash = [Splash node];
	[splashScene addChild:splash];
	
	menuLayer = [[MenuLayer alloc] init];
	gameLayer = [[GameLayer alloc] init];
	
	NSLog([NSString stringWithFormat:@"Logged In To Feint? %i",[[OFHandler sharedInstance] feintIsActive]]);
	
	[[CCDirector sharedDirector] replaceScene:splashScene];
	do {
#if ! TARGET_IPHONE_SIMULATOR
        @try {
#endif
            [[CCDirector sharedDirector] startAnimation];
#if ! TARGET_IPHONE_SIMULATOR
        }
        @catch (NSException * e) {
            NSLog(@"=== Exception Occurred! ===");
            NSLog(@"Name: %@; Reason: %@; Context: %@.\n", [e name], [e reason], [e userInfo]);
			// perhaps there shoudl be something here to alert the user that something bad happened?
        }
#endif
    } while ([[CCDirector sharedDirector] runningScene]);
}

+ (WhackABossAppDelegate *) get
{
	return (WhackABossAppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (AboutLayer *) aboutLayer
{
	if (!aboutLayer)
		aboutLayer = [[AboutLayer alloc] init];
	
	return aboutLayer;
}

- (SettingsLayer *) settingsLayer
{
	if (!settingsLayer)
		settingsLayer = [[SettingsLayer alloc] init];
	
	return settingsLayer;
}

- (CCSpriteSheet *) spriteSheet
{
	if (!spriteSheet) {
		spriteSheet = [[CCSpriteSheet spriteSheetWithFile:@"character_sheet.png" capacity:12] retain];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"character_sheet.plist"];
	}
	
	return spriteSheet;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
	[[OFHandler sharedInstance] resignActive];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
	[[OFHandler sharedInstance] becomeActive];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
	[[OFHandler sharedInstance] dealloc];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
