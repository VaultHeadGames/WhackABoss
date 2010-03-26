//
//  WBCreature.m
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/10/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import "WBCreature.h"

@implementation WBCreature

@synthesize state;

-(id) init
{
	if( (self=[super init] )) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:false];
		_creatureSprite = [CCSprite spriteWithSpriteFrameName:@"carl_normal.png"];
		[self addChild:_creatureSprite];
	}
	
	return self;
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
{
	// handle click
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint	location = [[CCDirector sharedDirector] convertToGL: touchLocation];
	CGRect myRect = CGRectMake(self.position.x - (self.contentSize.width * self.scale) / 2, self.position.y - (self.contentSize.height * self.scale) / 2, (self.contentSize.width * self.scale), (self.contentSize.height * self.scale));
	// are we actually being clicked?
	if (CGRectContainsPoint(myRect, location)) {
		NSLog(@"Ceature reports touch");
		return true; // let the delegate know we're handing this event
	}
	return false;
}

-(CreatureType) creatureType
{
	return _creatureType;
}

-(void) setScale:(float)s
{
	// make sure we pass scale down to the creature scale
	[_creatureSprite setScale:s];
	[super setScale:s];
}

-(void) changeCreatureType:(CreatureType)targetType
{
	_creatureType = targetType;

}

-(void) registerForPopUp
{
	
}

-(void) goDown: (id)sender
{
	
}

@end
