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
    
    
    
  //  NSString *data = [NSString stringWithFormat:@"1,4,3,6,4,66,4,9,7%@1,6,4,9,4,3,2,3,2%@7,4,9,5,4,7,5,6,3%@4,6,3,4,6,8,9,1,0%@4,6,4,8,3,8,9,4,6%@1,2,3,4,5,6,7,8,9",SEPERATOR,SEPERATOR,SEPERATOR,SEPERATOR,SEPERATOR];
    
 //   NSString *data = [NSString stringWithFormat:@"t,h,i,s, ,i,s, ,m%@y,a,g,r,i,g,h,t,h%@e,r,e,b,o,y,w,h,a%@t,s,',g,o,o,o,d,m%@a,h,d,u,d,e,h,o,w%@a,r,e,y,o,u,m,a,n",SEPERATOR,SEPERATOR,SEPERATOR,SEPERATOR,SEPERATOR];
    
    
   // NSData *d = [data dataUsingEncoding:NSUTF8StringEncoding];
  
    RCubeGenerator *steve = [[RCubeGenerator alloc] init];
    
    [steve generateCubesForString:@"Hello:This is a test of the LibRCrypt API. This works."];
    
    RCube *myCube = [[steve generatedCubes] objectAtIndex:0];
    
    printf("Original Cube: %s\n\n",[[myCube spillData] UTF8String]);

    [myCube applyRandomTransforms];
    
   
    printf("Encoded Cube With \"PASSWORD\": %s",[[[myCube spillData] stringByEncodingWithCipher:@"PASSWORD"] UTF8String]);;
    

    
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
