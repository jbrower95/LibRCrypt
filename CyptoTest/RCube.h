//
//  RCube.h
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


/*
 
 This class represents a "cube" of data.
 
 
 
 
 A cube has 6 faces, and so there are 6 "face" class instances created within this class
 
 
 
 */


#import <Foundation/Foundation.h>
#import "RFace.h"
#include "RDefines.h"

typedef enum kRCubeTransformTypes {
    
    RCubeTransformTypeUp = 0,
    RCubeTransformTypeDown = 1,
    RCubeTransformTypeLeft = 2,
    RCubeTransformTypeRight = 3

} RCubeTransformType;

typedef enum kRCubePerspective {
    
    RCubePerspectiveFront = 0,
    RCubePerspectiveBack = 1,
    RCubePerspectiveTop = 2,
    RCubePerspectiveBottom = 3,
    RCubePerspectiveLeft = 4,
    RCubePerspectiveRight = 5
    
} RCubePerspectiveType;




@interface RCube : NSObject
{
    
    RFace *bottom;
    RFace *top;
    RFace *left;
    RFace *right;
    RFace *front;
    RFace *back;
    
    // the six faces of the cube
}

@property (nonatomic, retain) RFace *bottom, *top, *left, *right, *front, *back;

- (NSData *)dataForWriting;
// this method allows an cube to be packed into a stream of numbers

- (id)initWithData:(NSData *)data;
// this method allows a cube be *un*packed from a stream of numbers into a mangable object

- (void)applyVerticalTransformToRow:(int)row type:(RCubeTransformType)t perspective:(RCubePerspectiveType)perspective;
// represents an "up" or "down" twist from multiple perspectives


- (void)applyHorizontalTransformToColumn:(int)column type:(RCubeTransformType)r perspective:(RCubePerspectiveType)perspective;
// represents a "left" or "right" twist from multiple perspectives


- (id)initWithFaces:(NSArray *)faces;

// array must contain in order: Top - Bottom - Left - Right - Front - Back


@end
