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
@property (strong, nonatomic) NSMutableArray *Projectiles;
@property (strong, nonatomic) NSMutableArray *Mice;
@property (strong, nonatomic) NSMutableArray *Enemies;

@property (strong, nonatomic) SKShapeNode *currentSpawnCircle;
@property (strong, nonatomic) SKNode *currentSpawn;

@property (strong, nonatomic) NSMutableArray *healthBars;
@property int healthbarWidth;

@property BOOL gameover;

@property CGSize screenSize;

@end

@implementation LevelScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //initialize properties
        self.healthbarWidth = 60;
        self.gameover = false;
        self.currentSpawnCircle = [[SKShapeNode alloc] init];
        self.currentSpawn = NULL;
        self.screenSize = size;
        self.Elephants = [[NSMutableArray alloc]init];
        self.mouseSpawnPoints = [[NSMutableArray alloc]init];
        self.Projectiles = [[NSMutableArray alloc]init];
        self.Mice = [[NSMutableArray alloc]init];
        self.Enemies = [[NSMutableArray alloc]init];
        self.healthBars = [[NSMutableArray alloc]init];
        
        //set background image
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackgroundnotext.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        [self addChild:sn];
        
        //bring in data
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.playerData = appDelegate.playerData;
        self.levelData = appDelegate.levelData;
        self.enemyData = appDelegate.enemyData;
        self.projectileData = appDelegate.projectileData;
        
        //set the current level data
        NSDictionary *cLevel = [self.levelData objectForKey:[self.currentLevel stringValue]];
        self.currentLevelData = cLevel;
        
        //spawn sprites
        [self spawnElephants];
        [self initMouseSpawnPoints];
        [self spawnEnemies];
    }
    return self;
}
//function called when the level is over
-(void) endLevel
{
    if (self.gameover) {
        return;
    }
    SKAction *fadeAway = [SKAction fadeAlphaTo:0 duration:1];
    for(SKNode *node in self.children)
    {
        [node runAction: fadeAway];
    }
    [self runAction: fadeAway completion:^{
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        // Create and configure the scene.
        SKScene * scene = [LevelSelectScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }];
}
//updates data every frame
- (void)update:(NSTimeInterval)currentTime {
    
    //checks to see if the game should end
    if([self.Enemies count]==0||[self.Elephants count]==0)
    {
        [self endLevel];
        self.gameover = true;
    }
    //initialize arrays of sprites to be deleted later
    NSMutableArray *elephantsToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    
    //checks if a mouse should scare an elephant
    for (Elephant *elephant in self.Elephants) {
        float distance = 50;
        CGPoint elephantCenter = elephant.position;
        for (Mouse *mouse in self.Mice) {
            bool alreadyScared = false;
            for(Elephant *scaredElephant in mouse.scaredElephants)
            {
                if(scaredElephant== elephant)
                    alreadyScared = true;
            }
            //calculates distance between mouse and elephant
            CGPoint mouseCenter = mouse.position;
            float newX = mouseCenter.x-elephantCenter.x;
            float newY = mouseCenter.y-elephantCenter.y;
            if (abs(newX*newX+newY*newY)<=distance*distance) {
                //determines if an elephant should run and reanimates it
                if(!alreadyScared && !elephant.attacking){
                    [elephant removeAllActions];
                    elephant.scaredCount = [NSNumber numberWithInt:5];
                    float angleDegrees = [self angleBetweenPositions:elephantCenter :mouseCenter];
                    float temp = mouse.zRotation;
                    float newAngle = (angleDegrees + temp) / 2;
                    elephant.zRotation = newAngle;
                    [mouse.scaredElephants addObject:elephant];
                    [self animateEntity:elephant];
                }
            }
        }
        //collision detection for projectiles
        for (Projectile *projectile in self.Projectiles)
        {
            if (CGRectIntersectsRect(projectile.frame, elephant.frame)) {
                [projectilesToDelete addObject:projectile];
                elephant.health = [NSNumber numberWithInt:[elephant.health intValue] - [projectile.damage intValue]];
                
                if([elephant.health intValue] <=0)
                {
                    [elephantsToDelete addObject:elephant];
                }
                
            }
        }
        for (Enemy *enemy in self.Enemies)
        {
            //collision detection for elephants attacking enemies
            CGPoint enemyCenter = enemy.position;
            float newX = elephantCenter.x-enemyCenter.x;
            float newY = elephantCenter.y-enemyCenter.y;
            float realDistance =sqrt(abs(newX*newX+newY*newY));
            if(realDistance <= distance && !elephant.attacking)
            {
                float actualDuration = [elephant.movementSpeed floatValue]/realDistance;
                elephant.attacking = true;
                [elephant removeAllActions];
                [enemy removeAllActions];
                elephant.zRotation = [self angleBetweenPositions:enemyCenter :elephantCenter];
                SKAction * actionMove = [SKAction moveTo:enemyCenter duration:actualDuration];
                [elephant runAction: actionMove completion:^{
                    [enemy removeFromParent];
                    [self.Enemies removeObject:enemy];
                    elephant.attacking = false;
                    [self animateEntity:elephant];
                }];
            }
         
            //calculates enemies firing projectiles
            if(realDistance <= [enemy.fireRange intValue])
            {
            CFTimeInterval timeSinceLast = currentTime - enemy.lastUpdateTimeInterval;
            [enemy updateWithTimeSinceLastUpdate:timeSinceLast];
            enemy.lastUpdateTimeInterval = currentTime;
            if (enemy.shouldFire) {
                Projectile *newProjectile = [Projectile spriteNodeWithImageNamed:enemy.projectile.projectileImageName];
                newProjectile.movementSpeed = enemy.projectile.movementSpeed;
                newProjectile.damage = enemy.projectile.damage;
                newProjectile.position = enemy.position;
                [self.Projectiles addObject:newProjectile];
                CGPoint realDestination;
                float newX=elephant.position.x;
                float newY=(elephant.position.y);
                while (newX<self.screenSize.width&&newX>0&&newY>0&&newY<self.screenSize.height) {
                    newX+=elephant.position.x-newProjectile.position.x;
                    newY+=(elephant.position.y)-newProjectile.position.y;
                }
                realDestination = CGPointMake(newX, newY);
                float distanceX = realDestination.x - newProjectile.position.x;
                float distanceY = realDestination.y - newProjectile.position.y;
                float realDistance = sqrt(distanceX*distanceX+distanceY*distanceY);
                float realDuration = realDistance/[newProjectile.movementSpeed floatValue];
                newProjectile.zRotation = [self angleBetweenPositions:realDestination :newProjectile.position];
                [self addChild:newProjectile];
                enemy.shouldFire = FALSE;
                SKAction * actionMove = [SKAction moveTo:realDestination duration:realDuration];
                [newProjectile runAction: actionMove completion:^{
                    [newProjectile removeFromParent];
                    [self.Projectiles removeObject:newProjectile];
                }];

                
            }
            }

        }
    }
    //deletes appropriate elephants
    for (Elephant *removeElephant in elephantsToDelete) {
        [self.Elephants removeObject:removeElephant];
        [removeElephant removeFromParent];
    }
    //deletes appropriate projectiles
    for (Projectile *projectile in projectilesToDelete) {
        [self.Projectiles removeObject:projectile];
        [projectile removeFromParent];
    }
    //deletes old healthbars
    for (SKShapeNode *node in self.healthBars) {
        [node removeFromParent];
    }
    self.healthBars = [[NSMutableArray alloc] init];
    
    //calculates and shows healthbars for elephants
    for (Elephant *elephant in self.Elephants)
    {
        int height = elephant.frame.origin.y+elephant.frame.size.height;
        int xStart = elephant.position.x - self.healthbarWidth/2;
        if(height>self.screenSize.height)
        {
            height = elephant.frame.origin.y-5;
        }
        CGRect backgroundRect = CGRectMake(xStart,
                                 height,
                                 self.healthbarWidth,
                                 5.0);
        
        
        CGMutablePathRef backgroundPath = CGPathCreateMutable();
        CGPathAddRect(backgroundPath, NULL, backgroundRect);
        SKShapeNode* backgroundHealthbar = [SKShapeNode node];
        backgroundHealthbar.path = backgroundPath;
        backgroundHealthbar.fillColor = [UIColor redColor];
        [self addChild:backgroundHealthbar];
        [self.healthBars addObject:backgroundHealthbar];
        
        CGRect rect = CGRectMake(xStart,
                                 height,
                                 self.healthbarWidth*([elephant.health floatValue]/[elephant.maxHealth floatValue]),
                                 5.0);
        
        
        CGMutablePathRef myPath = CGPathCreateMutable();
        CGPathAddRect(myPath, NULL, rect);
        SKShapeNode* healthbar = [SKShapeNode node];
        healthbar.path = myPath;
        healthbar.fillColor = [UIColor greenColor];
        healthbar.strokeColor = [UIColor clearColor];
        healthbar.zPosition++;
        [self addChild:healthbar];
        [self.healthBars addObject:healthbar];
    }
    //calculates and shows healthbars for enemies
    for (Enemy *enemy in self.Enemies)
    {
        int height = enemy.frame.origin.y+enemy.frame.size.height;
        int xStart = enemy.position.x - self.healthbarWidth/2;
        if(height>self.screenSize.height)
        {
            height = enemy.frame.origin.y-5;
        }
        CGRect rect = CGRectMake(xStart,
                                 height,
                                 self.healthbarWidth*([enemy.health floatValue]/[enemy.maxHealth floatValue]),
                                 5.0);
        
        
        CGMutablePathRef myPath = CGPathCreateMutable();
        CGPathAddRect(myPath, NULL, rect);
        SKShapeNode* backgroundHealthbar = [SKShapeNode node];
        backgroundHealthbar.path = myPath;
        backgroundHealthbar.fillColor = [UIColor redColor];
        backgroundHealthbar.strokeColor = [UIColor whiteColor];
        [self addChild:backgroundHealthbar];
        [self.healthBars addObject:backgroundHealthbar];
        
        rect = CGRectMake(xStart,
                          height,
                          self.healthbarWidth,
                          5.0);
        SKShapeNode* healthbar = [SKShapeNode node];
        healthbar.path = myPath;
        healthbar.fillColor = [UIColor greenColor];
        healthbar.strokeColor = [UIColor clearColor];
        [self addChild:healthbar];
        [self.healthBars addObject:healthbar];
    }
}
//called when the user taps the screen
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //determines if the user clicked a spawn point
    bool justClicked = false;
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        if ([node.name isEqualToString:@"Mouse Spawn Point"]) {
            if(self.currentSpawn!=NULL)
            {
                [self.currentSpawnCircle removeFromParent];
            }
            self.currentSpawn = node;
            CGMutablePathRef myPath = CGPathCreateMutable();
            float radius = sqrt(node.frame.size.height/2*node.frame.size.height/2 + node.frame.size.width/2*node.frame.size.width/2)+5;
            CGPathAddArc(myPath, NULL, node.position.x,node.position.y, radius, 0, M_PI*2, YES);
            self.currentSpawnCircle.path = myPath;
            self.currentSpawnCircle.lineWidth = 1.0;
            self.currentSpawnCircle.strokeColor = [SKColor whiteColor];
            self.currentSpawnCircle.glowWidth = 0.5;
            [self addChild:self.currentSpawnCircle];
            justClicked = true;
        }
    }
    if(self.currentSpawn==NULL||justClicked)
        return;
    //if the user has selected a spawnpoint and clicked elsewhere to fire a mouse this fires that mouse
    Mouse *mouse = [Mouse spriteNodeWithImageNamed:@"mouse.png"];
    
    [mouse initialize];
    mouse.position = CGPointMake(self.currentSpawn.position.x, self.currentSpawn.position.y);
    [self addChild:mouse];
    [self.Mice addObject:mouse];
    CGPoint realDestination;
    float newX=[touch locationInView:self.view].x;
    float newY=self.screenSize.height-([touch locationInView:self.view].y);
    while (newX<self.screenSize.width&&newX>0&&newY>0&&newY<self.screenSize.height) {
        newX+=[touch locationInView:self.view].x-mouse.position.x;
        newY+=self.screenSize.height-([touch locationInView:self.view].y)-mouse.position.y;
    }
    realDestination = CGPointMake(newX, newY);
    float distanceX = realDestination.x - mouse.position.x;
    float distanceY = realDestination.y - mouse.position.y;
    float realDistance = sqrt(distanceX*distanceX+distanceY*distanceY);
    float realDuration = realDistance/[mouse.movementSpeed floatValue];
    mouse.zRotation = [self angleBetweenPositions:realDestination :mouse.position];
    SKAction * actionMove = [SKAction moveTo:realDestination duration:realDuration];
    [mouse runAction: actionMove completion:^{
        [mouse removeFromParent];
        [self.Mice removeObject:mouse];
    }];
    

}
//function to spawn all the enemies in the level
-(void) spawnEnemies
{
    //bring in the enemy data
    NSArray *enemyData = [self.currentLevelData objectForKey:@"Enemies"];
    
    for (NSArray *newEnemy in enemyData)
    {
        
        NSNumber *x =[newEnemy objectAtIndex:1];
        NSNumber *y =[newEnemy objectAtIndex:2];
        NSMutableArray *prototype = [self.enemyData objectForKey:[newEnemy objectAtIndex:0]];
        
        //set enemy data
        Enemy *enemy;
        enemy = [Enemy spriteNodeWithImageNamed:[prototype objectAtIndex:0]];
        enemy.position = CGPointMake([x floatValue], [y floatValue]);
        enemy.movementSpeed = [prototype objectAtIndex:2];
        enemy.hasProjectile = [[prototype objectAtIndex:3] boolValue];
        enemy.fireRate = [prototype objectAtIndex:4];
        enemy.maxHealth = [prototype objectAtIndex:1];
        enemy.health = [NSNumber numberWithInt:[enemy.maxHealth intValue]];
        enemy.shouldFire = FALSE;
        
        //set the enemy's projectile data
        if(enemy.hasProjectile)
        {
            enemy.fireRange =[prototype objectAtIndex:5];
            NSMutableArray *newProjectileData = [self.projectileData objectForKey:[prototype objectAtIndex:6]];
            Projectile *projectile = [Projectile spriteNodeWithImageNamed:[newProjectileData objectAtIndex:0]];
            projectile.movementSpeed = [newProjectileData objectAtIndex:1];
            projectile.damage = [newProjectileData objectAtIndex:2];
            projectile.projectileImageName = [newProjectileData objectAtIndex:0];
            enemy.projectile = projectile;
        }
        [self.Enemies addObject:enemy];
        [self addChild:enemy];
        [self animateEntity:enemy];
    }
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
    spawnPoint.name = @"Mouse Spawn Point";
    [self.mouseSpawnPoints addObject:spawnPoint];
    [self addChild:spawnPoint];
    
}
//function to spawn all the elephants in the level
-(void) spawnElephants
{
    NSArray *elephantData = [self.currentLevelData objectForKey:@"Elephants"];
    
    for (NSArray *newElephant in elephantData)
    {
        NSNumber *x =[newElephant objectAtIndex:0];
        NSNumber *y =[newElephant objectAtIndex:1];
        Elephant *elephant;
        elephant = [Elephant spriteNodeWithImageNamed:@"BasicElephant.png"];
        elephant.position = CGPointMake([x floatValue], [y floatValue]);
        NSNumber *health = [NSNumber numberWithInt:20];
        NSNumber *maxHealth = [NSNumber numberWithInt:20];
        NSNumber *movementSpeed = [NSNumber numberWithInt:50];
        elephant.health = health;
        elephant.maxHealth = maxHealth;
        [elephant initializeData:health :movementSpeed];
        [self.Elephants addObject:elephant];
        [self addChild:elephant];
        elephant.movementSpeed = [NSNumber numberWithInt:20];
        [self animateEntity:elephant];
    }
}
//called when the movement is done, restarts the movement
- (void) entityMoveFinished:(id)sender {
    BasicEntity *entity = (BasicEntity*)sender;
    
    [self animateEntity: entity];
}
//begins the animation for the elephant sprite
- (void) animateEntity:(BasicEntity*)entity
{
    CGSize winSize = self.screenSize;
    int distance = 20;
    float actualDuration =  [entity.movementSpeed floatValue]/distance;
    if([entity.scaredCount intValue]>0)
    {
        actualDuration = [entity.movementSpeed floatValue]/40;
        entity.scaredCount = [NSNumber numberWithInt:[entity.scaredCount intValue]-1];
    }
    float newAngle = [entity getNextAngle];
    CGPoint newPosition = [self getNewPosition:entity.position :newAngle :distance];
    while (newPosition.x<0||newPosition.x>winSize.width||newPosition.y<0||newPosition.y>winSize.height) {
        newAngle += M_PI/4;
        newPosition = [self getNewPosition:entity.position :newAngle :distance];
    }
    entity.zRotation = newAngle;
    SKAction *moveToNewPostion = [SKAction moveTo:newPosition duration:actualDuration];
    [entity runAction: moveToNewPostion completion:^{
        [self entityMoveFinished:entity];
    }];

}

- (CGPoint) getNewPosition: (CGPoint) oldPosition : (float) newAngle : (int) distance
{
    CGPoint newPosition;
    newPosition.y = sinf(newAngle)*distance+oldPosition.y;
    newPosition.x = cosf(newAngle)*distance+oldPosition.x;
    return newPosition;
}
-(float) angleBetweenPositions: (CGPoint) start : (CGPoint) end
{
    float diffX = start.x - end.x;
    float diffY = start.y - end.y;
    float angleDegrees = atan2f(diffY, diffX);
    return angleDegrees;
}



@end
