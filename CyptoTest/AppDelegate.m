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
    
    [steve generateCubesForString:@"As a describer of life and manners, he must be allowed to stand perhaps the first of the first rank. His humour, which, as Steele observes, is peculiar to himself, is so happily diffused as to give the grace of novelty to domestic scenes and daily occurrences. He never \"o'ersteps the modesty of nature,\" nor raises merriment or wonder by the violation of truth. His figures neither divert by distortion nor amaze by aggravation. He copies life with so much fidelity that he can be hardly said to invent; yet his exhibitions have an air so much original, that it is difficult to suppose them not merely the product of imagination."];

    [steve encryptCubes];
    
    printf("Steve's encrypted cubes: %s\n",[[steve cubeDataWithPassword:@"THIS IS A TEST"] UTF8String]);
 
    
    NSString *decrypted = [RCubeDecoder decodeData:[steve cubeDataWithPassword:@"THIS IS A TEST"] withTransformKey:[steve transformKeyWithPassword:@"THIS IS A TEST"] password:@"THIS IS A TEST"];
    printf("Decrypted: %s\n",[decrypted UTF8String]);
    
    
    
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
