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
// same as above. self explanatory

- (void)encryptCubes;
// calls applyRandomTransform() on every cube

- (NSString *)outputAsString;

- (void)generateCubesForString:(NSString *)input;
// this data must be packed

- (NSMutableArray *)chopString:(NSString*)str intoStringsOfSize:(int)size;



@end
