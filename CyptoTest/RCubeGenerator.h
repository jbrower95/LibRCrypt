//
//  RCubeGenerator.h
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCube.h"
#import "RFace.h"
@interface RCubeGenerator : NSObject
{
    NSMutableArray *generatedCubes;
    
    
    
}

@property (nonatomic, retain) NSMutableArray *generatedCubes;








- (NSString *)outputAsString;

- (void)generateCubesForString:(NSString *)input;
// this data must be packed




@end
