//
//  AppDelegate.m
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#include "RDefines.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
    
    // RCube + RFace test
 
  
    RCubeGenerator *steve = [[RCubeGenerator alloc] init];
    
    [steve generateCubesForString:@"The idea's pretty simple: If you represent data as the squares on a rubix cube you can apply transformations to the data and get back completely encrypted data -- all of which is commutatitive. Just as a rubix cube can be solved if you know all of the moves this data can be \"unwound\" so to speak if you know all of the transforms applied. Except the encryption is even deeper than that."];
    
    
    
    RCube *cube1 = [[steve generatedCubes] objectAtIndex:0];
    
    NSMutableArray *transforms = [NSMutableArray array];
    
    
    NSString *t1 = [cube1 applyRandomTransforms];
    
    [transforms addObject:t1];
    
    for ( int i = 0; i < [[steve generatedCubes] count]; i++)
    {
        if ( i > 0 )
        {
            if ( [[steve generatedCubes] objectAtIndex:i] != nil)
            {
               NSString *t = [(RCube*)[[steve generatedCubes] objectAtIndex:i] applyRandomTransforms];
                [transforms addObject:t];
             }
        
        }
    }
    
    
    
    
    printf("---------With Transforms--------\n%s\n",[[steve outputAsString] UTF8String]);
    // now we get back a big string for everything
    
    for ( int i = 0; i < [[steve generatedCubes] count]; i++)
    {
        NSString *t = [RCubeDecoder negatingTransformStringForString:[transforms objectAtIndex:i]];
        
        
        [[[steve generatedCubes] objectAtIndex:i] applyTransformsFromString:t];
           
            
    }
    
    
    printf("------Negated Transforms---------\n%s\n",[[steve outputAsString] UTF8String]);

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
