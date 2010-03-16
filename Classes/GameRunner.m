//
//  GameRunner.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "GameRunner.h"
#import "WBCreature.h"
#import "SoundManager.h"
#import "Constants.h"
#import "GameScene.h"

@implementation GameRunner

@synthesize currentScore;
@synthesize currentLevel;
@synthesize gameRunning;
@synthesize gameHasStarted;
@synthesize sexyHitCounts;
@synthesize brickHitCounts;
@synthesize carlHitCounts;

+(GameRunner*) sharedInstance
{
	static GameRunner* instance = nil;
	
	if (nil == instance) {
		instance = [[[self class] alloc] init];
	}
	
	return instance;
}

-(void) pauseGame
{
	gameRunning = false;
}
-(void) resumeGame
{
	if (!self.gameHasStarted)
		return;
	gameRunning = true;
}

-(void) startGame
{
	[super onEnter];
	NSLog(@"<GameRunner> START GAME");
	// reset the score!
	currentScore = 0;
	sexyHitCounts = 0;
	carlHitCounts = 0;
	brickHitCounts = 0;
	currentLevel = 0;
	gameRunning = true;
	gameHasStarted = true;
	[[GameScene node] startGame];
	NSLog(@"<GameRunner> SCHEDULING TICK: SELECTOR");
	[self schedule: @selector(tick:) interval: 3];
}

-(void) endGame
{
	gameRunning = false;
	gameHasStarted = false;
	[[GameScene node] endGame];
	[self unschedule: @selector(tick:)];
}

-(void) checkScoreAndSexyCounts
{
	if (sexyHitCounts == 3) {
		// it's sexual harrassment time!
		[self proceedToEndGame:SEXUAL_HARASSMENT];
	} else if (carlHitCounts == 5) {
		// let's go postal!
		[self proceedToEndGame:CARL_GOES_POSTAL];
	} else if (brickHitCounts == 7) {
		// what happens when we hit brick?
	}
	[[GameScene node] updateScore];
	// check for level advancement...
	if ((int)self.currentScore > ceil((int)self.currentLevel * NEW_LEVEL_SCORE_REQUIREMENT)) {
		// proceed to next level
		[self proceedToNextLevel];
	}
}

// this is the main 'loop' - this is where we let everything know to advance
-(void) tick:(ccTime)dt
{
	NSLog(@"<GameRunner> TICK");
	
	// don't continue unless we're running, obviously
	if (!self.gameRunning || !self.gameHasStarted)
		return;
	
	// GO THE MAGIC!
	int creaturesUp = 0;
	
	for (WBCreature* c in [[GameScene node] creatureArray]) {
		// this is where we signal each creature to accept the game's main 'tick'
		if (c.state != STATE_IDLE)
			++creaturesUp;
	}
	NSLog(@"<GameRunner> Currently have %d creatures up", creaturesUp);
	
	int creatureMin = 1;
	int creatureMax = 2 + floor(currentLevel * MAXIMUM_CREATURE_LEVEL_MODIFIER);
	int newCreatureProbability = 0;
	
	if (creaturesUp < creatureMax) {
		// determine the 'odds' that we'll pop up somebody new
		if (creaturesUp < creatureMin)
			newCreatureProbability = 1;
		else
			newCreatureProbability = (((creaturesUp / creatureMax) * TICK_NEW_CREATURE_PROBABILITY_MODIFIER) + (MAXIMUM_CREATURE_LEVEL_MODIFIER * currentLevel));
	}
	
	NSLog(@"<GameRunner> Current probability to popup new creature is %d", newCreatureProbability);
	
	if (newCreatureProbability * 10 > (arc4random() % 10)) {
		// pick a new creature to popup!
		int newCreatureIndex = round(arc4random() % 8);
		[[[[GameScene node] creatureArray] objectAtIndex:(uint)newCreatureIndex] registerForPopUp];
		NSLog(@"<GameRunner> Creature index %d signaled to popup",newCreatureIndex);
	}
}

-(void) proceedToNextLevel
{

}

-(void) proceedToEndGame:(EndGameCondition)endCondition
{
	switch (endCondition) {
		case WIN:
			break;
		case SEXUAL_HARASSMENT:
			break;
		case CARL_GOES_POSTAL:
			break;
		default:
			NSLog(@"HOW THE FUCK DID I GET HERE!? You missed an EndGameCondition!");
			break;
	}
}

// this function returns the number of seconds a 'creature' remains up
-(double) creatureFadeOutTime
{
	return (((0 - log((int)self.currentLevel)) * BASELINE_DIFFICULTY_MODIFIER) + BASELINE_POPUP_DELAY);
}

-(id) init
{
	// always super.init
	if( (self=[super init] )) {
		self.gameRunning = false;
		self.gameHasStarted = false;
	}
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
