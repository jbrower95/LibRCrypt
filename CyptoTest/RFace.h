//
//  RFace.h
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum kRFaceDirection
{
    RFaceDirectionLeft,
    RFaceDirectionRight
} RFaceDirection;

// this class represents a particular face of the cube. All handling is done in ints.

#include "RDefines.h"

@interface RFace : NSObject
{
    
    int a; int b; int c;
    int d; int e; int f;
    int g; int h; int i;
    
    int relatedFace;

}
@property (nonatomic, assign) int relatedFace;
- (NSString *)cumulativeOutput;
- (NSString *)formattedOutput;

- (id)initWithFace:(RFace *)another;

- (void)twistForDirection:(RFaceDirection)direction;
// rotates the specified side to the "right" or "left"

- (id)initWithStream:(NSString *)stream;

- (NSString *)generateStream;

@property (nonatomic, assign) int a, b, c, d, e, f, g, h, i;

@end
