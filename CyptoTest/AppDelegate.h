//
//  AppDelegate.h
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RCube.h"
#import "RFace.h"
#import "RCubeGenerator.h"
#import "NSString+XOR.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
