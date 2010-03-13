//
//  GameScene.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameScene.h"
#import "WBCreature.h"
#import "GameRunner.h"

@implementation GameScene

@synthesize creatureArray;
@synthesize creatureSpriteMap;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an MainMenu object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {		
		CCSprite* background_bottom = [CCSprite spriteWithFile:@"office-V2_04.png"];
		CCSprite* background_cube_row_1 = [CCSprite spriteWithFile:@"office-V2_03.png"];
		CCSprite* background_cube_row_2 = [CCSprite spriteWithFile:@"office-V2_02.png"];
		CCSprite* background_top = [CCSprite spriteWithFile:@"office-V2_01.png"];
		background_bottom.anchorPoint = CGPointZero;
		background_cube_row_1.position = ccp(160, 165.5);
		background_cube_row_2.position = ccp(160, 269);
		background_top.position = ccp(160, 395);
		[self addChild:background_bottom z:7];
		[self addChild:background_cube_row_1 z:5];
		[self addChild:background_cube_row_2 z:3];
		[self addChild:background_top z:0];
		
		levelLabel = [[CCLabelAtlas alloc] initWithString:@"1" charMapFile:@"scoreCharMap.png" itemWidth:6 itemHeight:8 startCharMap:'.'];
		[levelLabel setPosition:ccp(42,414)];
		[self addChild:levelLabel z: 1];
		
		scoreLabel = [[CCLabelAtlas alloc] initWithString:@"0" charMapFile:@"scoreCharMap.png" itemWidth:6 itemHeight:8 startCharMap:'.'];
		[scoreLabel setPosition:ccp(105, 414)];
		[self addChild:scoreLabel z: 1];
	}
	return self;
}

-(void) updateScore
{
	NSString* str = [[NSString alloc] initWithFormat:@"%d", [[GameRunner sharedInstance] currentScore]];
	[scoreLabel setString: str];
	[str release];
	[scoreLabel draw];
}

-(void) updateLevel
{
	NSString* str = [[NSString alloc] initWithFormat:@"%d", [[GameRunner sharedInstance] currentLevel]];
	[levelLabel setString: str];
	[str release];
	[levelLabel draw];
}

-(void) startGame
{
	NSLog(@"<GameScene> START GAME");
	// bring up the WBCreature classes
	creatureArray = [[NSMutableArray alloc] init];
	self.creatureSpriteMap = [CCSpriteSheet spriteSheetWithFile: @"boss-test.png"];
	while ([creatureArray count] < 9)
		[creatureArray addObject:[WBCreature spriteWithSpriteSheet: self.creatureSpriteMap rect: CGRectMake(0,0,48,48)]];
	int currentCreature = 1;
	int currentRow = 1;
	int x;
	int y;
	int z;
	for (WBCreature* c in creatureArray) {
		// Place 'em
		c.anchorPoint = ccp(.5,0); // top-middle?
		if (currentRow == 1) {
			y = 103.5;
			z = 2;
		} else if (currentRow == 2) {
			y = 226.5;
			z = 4;
		} else if (currentRow == 3) {
			y = 309;
			z = 6;
		}
		
		// how the hell are we determining X otuside the middle column?
		switch (currentCreature) {
			case 1:
				x = 42;
				break;
			case 2:
				x = 160;
				break;
			case 3:
				x = 272;
				break;
			case 4:
				x = 66;
				break;
			case 5:
				x = 160;
				break;
			case 6:
				x = 248;
				break;
			case 7:
				x = 86;
				break;
			case 8:
				x = 160;
				break;
			case 9:
				x = 241;
				break;
			default:
				NSLog(@"Uh-oh!  I've got an extra WBCreature - I can't place it!!!");
				[c release];
				break;
		}
		
		// strike the position and add the bitch
		c.position = ccp(x,y);
		[self addChild:c z:z];
		
		if ((currentCreature % 3) == 0) {
			// since this is the last in the row, make sure we know next orund we're up one level
			++currentRow;
		}
		++currentCreature;
	}
}

-(void) endGame
{
	// release the creatures and sprite-map
	for (WBCreature* c in creatureArray) {
		[self removeChild:c cleanup:true];
		[c release];
	}
	[creatureArray release];
	[creatureSpriteMap release];
}

-(void) onEnter
{
	[[GameRunner sharedInstance] startGame];
}

@end
