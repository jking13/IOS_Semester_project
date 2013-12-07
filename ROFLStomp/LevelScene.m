//
//  LevelScene.m
//  ROFLStomp
//
//  Created by John King on 12/3/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "LevelScene.h"
@interface LevelScene ()

@property (strong, nonatomic) NSMutableArray *Elephants;
@property (strong, nonatomic) NSMutableArray *mouseSpawnPoints;
@end

@implementation LevelScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //initalize arrays
        self.Elephants = [[NSMutableArray alloc]init];
        self.mouseSpawnPoints = [[NSMutableArray alloc]init];
        
        //set background image
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackgroundnotext.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        [self addChild:sn];
        
        //bring in data
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.playerData = appDelegate.playerData;
        self.levelData = appDelegate.levelData;
        
        //set the current level data
        NSDictionary *cLevel = [self.levelData objectForKey:[self.currentLevel stringValue]];
        self.currentLevelData = cLevel;
        
        //spawn sprites
        [self spawnElephants];
        [self initMouseSpawnPoints];
    }
    return self;
}
//function to initialize all mouse spawn points in the level
-(void) initMouseSpawnPoints
{
    NSArray *spawnPointData = [self.currentLevelData objectForKey:@"Mouse Spawn Points"];
    
    for (NSArray *newSpawnPoint in spawnPointData)
    {
        NSNumber *X =[newSpawnPoint objectAtIndex:0];
        NSNumber *Y =[newSpawnPoint objectAtIndex:1];
        [self addMouseSpawnPointAtX:[X intValue] y:[Y intValue]];
    }
}
//function to add the mouse spawn point sprite to the scene
-(void)addMouseSpawnPointAtX:(int)x y:(int)y
{
    SKSpriteNode *spawnPoint;
    spawnPoint = [SKSpriteNode spriteNodeWithImageNamed:@"tallgrass.png"];
    spawnPoint.position =CGPointMake(x, y);
    [self.mouseSpawnPoints addObject:spawnPoint];
    [self addChild:spawnPoint];
}
//function to spawn all the elephants in the level
-(void) spawnElephants
{
    NSArray *elephantData = [self.currentLevelData objectForKey:@"Elephants"];
    
    for (NSArray *newElephant in elephantData)
    {
        NSNumber *X =[newElephant objectAtIndex:0];
        NSNumber *Y =[newElephant objectAtIndex:1];
        [self addElephantAtX:[X intValue] y:[Y intValue]];
    }
}
//function to add the elephant sprite to the scene
-(void)addElephantAtX:(int)x y:(int)y
{
    Elephant *elephant;
    elephant = [Elephant spriteNodeWithImageNamed:@"BasicElephant.png"];
    elephant.position = CGPointMake(x, y);
    [self.Elephants addObject:elephant];
    [self addChild:elephant];
    
}
@end
