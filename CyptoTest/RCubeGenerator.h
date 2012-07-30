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
    
    NSMutableArray *generatedKeys;
    
    
}

@property (nonatomic, retain) NSMutableArray *generatedCubes;




- (NSString *)transformKeyWithPassword:(NSString *)password;
// gives back the transformKey with an XOR'd password

- (NSString *)cubeDataWithPassword:(NSString *)password;
// returns an NSString of the cube's data with a password modulating'ly XOR'd to it

- (void)encryptCubes;
// calls applyRandomTransform() on every cube

- (NSString *)outputAsString;
// dumps the generated Cubes as an NSString

- (void)generateCubesForString:(NSString *)input;
// this data must be packed

- (NSMutableArray *)chopString:(NSString*)str intoStringsOfSize:(int)size;



@end
