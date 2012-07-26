//
//  RCube.m
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCube.h"

@implementation RCube
@synthesize top, left, bottom, right, front, back;

- (id)initWithFaces:(NSArray *)faces
{
    self = [super init];
    
    if ( self )
    {
       top = [[faces objectAtIndex:0] retain];
        [top setRelatedFace:0];
        
        bottom = [[faces objectAtIndex:1] retain];
        [bottom setRelatedFace:1];
        
        left = [[faces objectAtIndex:2] retain];
        [left setRelatedFace:2];
        
        right = [[faces objectAtIndex:3] retain];
        [right setRelatedFace:3];
        
        front = [[faces objectAtIndex:4] retain];
        [front setRelatedFace:4];
        
        back = [[faces objectAtIndex:5] retain];
        [back setRelatedFace:5];
        
    }
    
    return self;
    
    
}

- (void)applyTransformsFromString:(NSString *)transformString
{
    int ticker = 0;
    // traverse through the transform string.
    
    if (transformString.length % 3 != 0 )
    {
        printf("Error: INVALID LENGTH - Transform String (RCube applyTransformsFromString)\n");
        return;
    }
    
    for ( int i = 0; i < transformString.length; i++)
    {
        RCubeTransformType currentType;
        RCubePerspectiveType currentPerspective;
        int area;
        
        if ( ticker == 0)
        {
            // random number between 0 and 1
            
            // we're figuring out our type
            
            int value = [[transformString substringWithRange:NSMakeRange(i, 1)] intValue];
            
            // now that we have the value, cast it to currentType;
            
            currentType = (RCubeTransformType)value;
        
            ticker++;
        }
        else if ( ticker == 1)
        {
            // '' between 0 and 5
            
            int value = [[transformString substringWithRange:NSMakeRange(i, 1)] intValue];
            currentPerspective = (RCubePerspectiveType)value;
            
               ticker++;
            
        }
        else if ( ticker == 2 )
        {
            // '' between 0 and 1
            
            // this bit is the row/column
            
           area = [[transformString substringWithRange:NSMakeRange(i, 1)] intValue];
           
            
            
            ticker++;
            
        }
        
        if ( ticker == 3 )
        {
            
            // apply the transform
            
          if ( currentType == RCubeTransformTypeUp || currentType == RCubeTransformTypeDown)
          {
              [self applyVerticalTransformToRow:area type:currentType perspective:currentPerspective];
          }
           else {
                    [self applyHorizontalTransformToColumn:area type:currentType perspective:currentPerspective];
            }   
            
            ticker = 0;
            
            }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}

- (NSString *)applyRandomTransforms
{
    
    int length = 3 * ENCRYPTION_LEVEL;
    
    // max length must be a multiple of 3
    
    NSMutableString *str = [NSMutableString string];
    
    int ticker = 0;
    
    for ( int i = 0; i < length; i++)
    {
        //srand((unsigned)time(NULL));
        
        
        if ( ticker == 0)
        {
            // random number between 0 and 1
            int r = (arc4random() % 1 ? 0 : 1);
            [str appendFormat:@"%d",r];
            ticker++;
        }
        else if ( ticker == 1)
        {
            // '' between 0 and 5
            
            int r = arc4random() % 6;
            [str appendFormat:@"%d",r];
            ticker++;
            
        }
        else if ( ticker == 2 )
        {
            // '' between 0-2 inclusive, row/column
            
            int r = (arc4random() % 3);
            [str appendFormat:@"%d",r];
            ticker++;
            
        }
        
        if ( ticker == 3 )
        {
            ticker = 0;
        }
        
        
        
        
    }
    
   // NSLog(@"Generated Transform String: %@",str);
    
    [self applyTransformsFromString:str];
    
    
    
    return str;
    
}


- (void)printFormatted
{
    NSArray *a = [NSArray arrayWithObjects:top,bottom,left,right,front,back,nil];

    
    printf("Logging RCube:\n--------------\n");
    int i = 1;
    for ( RFace *face in a)
    {
        printf("Face %d\n\n",i);
        
        
        printf("%s\n\n",[[face formattedOutput] UTF8String]);
        
        
        i++;
        
    }
    
  
    
}

- (NSString*)spillData
{
    
    
    NSMutableString *cumulative = [NSMutableString string];
    
    NSArray *a = [NSArray arrayWithObjects:top,bottom,left,right,front,back,nil];
    
    int i = 1;
    for ( RFace *face in a)
    {        
        [cumulative appendString:[face cumulativeOutput]];
        
        i++;
        
    }
    return cumulative;
    
}


- (NSData *)dataForWriting
{
    NSMutableString *cube = [NSMutableString string];
    
    
    [cube appendString:[top generateStream]];
    [cube appendString:[bottom generateStream]];
    [cube appendString:[left generateStream]];
    [cube appendString:[right generateStream]];
    [cube appendString:[front generateStream]];
    [cube appendString:[back generateStream]];

    
    return [cube dataUsingEncoding:NSUTF8StringEncoding];
    
    //    
    
    
}

- (id)initWithData:(NSData *)data
{
    self = [super init];
    
    
    NSString *stream = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *components = [stream componentsSeparatedByString:SEPERATOR];
    
    // each component should be a different face! :)
    
    top = [[RFace alloc] initWithStream:[components objectAtIndex:0]];
    [top setRelatedFace:0];
    
    bottom = [[RFace alloc] initWithStream:[components objectAtIndex:1]];
    [bottom setRelatedFace:1];
    
    left = [[RFace alloc] initWithStream:[components objectAtIndex:2]];
    [left setRelatedFace:2];
    
    right = [[RFace alloc] initWithStream:[components objectAtIndex:3]];
    [right setRelatedFace:3];
    
    front = [[RFace alloc] initWithStream:[components objectAtIndex:4]];
    [front setRelatedFace:4];
    
    back = [[RFace alloc] initWithStream:[components objectAtIndex:5]];
    [back setRelatedFace:5];
    
    
    return self;
}
// this method allows a cube be *un*packed from a stream of numbers into a mangable object







- (void)applyVerticalTransformToRow:(int)row type:(RCubeTransformType)t perspective:(RCubePerspectiveType)perspective
{
/*
    RFace *_bottom = [[RFace alloc] initWithFace:bottom];
    RFace *_top = [[RFace alloc] initWithFace:top];
   
    RFace *_front = [[RFace alloc] initWithFace:front];
    RFace *_back = [[RFace alloc] initWithFace:back];
    
    RFace *_left = [[RFace alloc] initWithFace:left];
    RFace *_right = [[RFace alloc] initWithFace:right];
    */
    
    RFace *_bottom, *_top, *_front, *_back, *_left, *_right;
    
    _bottom = bottom;
    _top = top;
    _front = front;
    _back = back;
    _left = left;
    _right = right;
    
    
    if ( perspective == RCubePerspectiveLeft )
    {
        _left = back;
        _right = front; 
        _front = left;
        _back = right;
        
    }
    
    if ( perspective == RCubePerspectiveRight )
    {
        _left = front;
        _right = back;   
        _front = right;
        _back = left;
        
    }
    
    if ( perspective == RCubePerspectiveTop )
    {
        
        _top = back;
        _bottom = front;
        _front = top;
        _back = bottom;
        
    }
    
    if ( perspective == RCubePerspectiveBottom )
    { 
        _top = front;
        _bottom = back;
        _front = bottom;
        _back = top;
    }
    if ( perspective == RCubePerspectiveBack ) 
    {
        _left = right;
        _right = left;
        _front = back;
        _back = front;
    }
    
    
    // we're gonna make copies
    /*
    if ( perspective == RCubePerspectiveLeft )
    {
        _left = [[RFace alloc] initWithFace:back];
        _right = [[RFace alloc] initWithFace:front]; 
        _front = [[RFace alloc] initWithFace:left];
        _back = [[RFace alloc] initWithFace:right];
        
    }
    
    if ( perspective == RCubePerspectiveRight )
    {
        _left = [[RFace alloc] initWithFace:front];
        _right = [[RFace alloc] initWithFace:back];   
        _front = [[RFace alloc] initWithFace:right];
        _back = [[RFace alloc] initWithFace:left];
        
    }
    
    if ( perspective == RCubePerspectiveTop )
    {
   
        _top = [[RFace alloc] initWithFace:back];
        _bottom = [[RFace alloc] initWithFace:front];
        _front = [[RFace alloc] initWithFace:top];
        _back = [[RFace alloc] initWithFace:bottom];
   
    }
    
    if ( perspective == RCubePerspectiveBottom )
    { 
        _top = [[RFace alloc] initWithFace:front];
        _bottom = [[RFace alloc] initWithFace:back];
        _front = [[RFace alloc] initWithFace:bottom];
        _back = [[RFace alloc] initWithFace:top];
    }
    if ( perspective == RCubePerspectiveBack ) 
    {
        _left = [[RFace alloc] initWithFace:right];
        _right = [[RFace alloc] initWithFace:left];
        _front = [[RFace alloc] initWithFace:back];
        _back = [[RFace alloc] initWithFace:front];
    }
    */
    
    
    RFace *__front = [[RFace alloc] initWithFace:_front];
    [__front setRelatedFace:_front.relatedFace];
    
    RFace *__top = [[RFace alloc] initWithFace:_top];
    [__top setRelatedFace:_top.relatedFace];
    
    RFace *__back = [[RFace alloc] initWithFace:_back];
    [__back setRelatedFace:_back.relatedFace];
    
    RFace *__bottom = [[RFace alloc] initWithFace:_bottom];
    [__bottom setRelatedFace:_bottom.relatedFace];
    
    // make another copy now: left and right are preserved
    
    
    
    if ( t == RCubeTransformTypeUp )
    {
        // if we're flipping up
        if ( row == 0 )
        {
            [_left twistForDirection:RFaceDirectionLeft];
            
            __front.a = _bottom.a;
            __front.d = _bottom.d;
            __front.g = _bottom.g;
            
            __bottom.a = _back.a;
            __bottom.d = _back.d;
            __bottom.g = _back.g;
            
            __back.a = _top.a;
            __back.d = _top.d;
            __back.g = _top.g;
            
            __top.a = _front.a;
            __top.d = _front.d;
            __top.g = _front.g;
            
            
        }
        
        if ( row == 1 )
        {
            __front.b = _bottom.b;
            __front.e = _bottom.e;
            __front.h = _bottom.h;
            
            __bottom.b = _back.b;
            __bottom.e = _back.e;
            __bottom.h = _back.h;
            
            __back.b = _top.b;
            __back.e = _top.e;
            __back.h = _top.h;
            
            __top.b = _front.b;
            __top.e = _front.e;
            __top.h = _front.h;
            
            
            
        }
        
        if ( row == 2 )
        {
            [_right twistForDirection:RFaceDirectionRight];
            
            __front.c = _bottom.c;
            __front.f = _bottom.f;
            __front.i = _bottom.i;
            
            __bottom.c = _back.c;
            __bottom.f = _back.f;
            __bottom.i = _back.i;
            
            __back.c = _top.c;
            __back.f = _top.f;
            __back.i = _top.i;
            
            __top.c = _front.c;
            __top.f = _front.f;
            __top.i = _front.i;
   
        }
        
        
  
    
    
    }
    
    if ( t == RCubeTransformTypeDown )
    {
       if ( row == 0 )
       {
           [_left twistForDirection:RFaceDirectionRight];
           
           __front.a = _top.a;
           __front.d = _top.d;
           __front.g = _top.g;
           
           __top.a = _back.a;
           __top.d = _back.d;
           __top.g = _back.g;
           
           __back.a = _bottom.a;
           __back.d = _bottom.d;
           __back.g = _bottom.g;
           
           __bottom.a = _front.a;
           __bottom.d = _front.d;
           __bottom.g = _front.g;
           
           
           
       }
        
        if ( row == 1 )
        {
           
            __front.b = _top.b;
            __front.e = _top.e;
            __front.h = _top.h;
            
            __top.b = _back.b;
            __top.e = _back.e;
            __top.h = _back.h;
            
            __back.b = _bottom.b;
            __back.e = _bottom.e;
            __back.h = _bottom.h;
            
            __bottom.b = _front.b;
            __bottom.e = _front.e;
            __bottom.h = _front.h;
            
        
        }
        
       if ( row == 2)
       {
           [_right twistForDirection:RFaceDirectionLeft];
           
           __front.c = _top.c;
           __front.f = _top.f;
           __front.i = _top.i;
           
           __top.c = _back.c;
           __top.f = _back.f;
           __top.i = _back.i;
           
           __back.c = _bottom.c;
           __back.f = _bottom.f;
           __back.i = _bottom.i;
        
           __bottom.c = _front.c;
           __bottom.f = _front.f;
           __bottom.i = _front.i;
           
       }
       
        

        
    }
    
    
    NSArray *a = [NSArray arrayWithObjects:__front,__back,__top,__bottom,nil];
    int i = 0;
    for ( RFace *r in a )
    {
        RFace *obj = [self faceWithRelativeID:r.relatedFace];
        
        if ( obj )
        {
            obj = [[RFace alloc] initWithFace:[a objectAtIndex:i]];
        }
        i++;
        
    }


//printf("Changed\n\n");
    
    
    


}
// represents an "up" or "down" twist


// 2
// 1
// 0


- (void)applyHorizontalTransformToColumn:(int)column type:(RCubeTransformType)t perspective:(RCubePerspectiveType)perspective
{
    RFace *_bottom, *_top, *_front, *_back, *_left, *_right;
    
    _bottom = bottom;
    _top = top;
    _front = front;
    _back = back;
    _left = left;
    _right = right;
    
    
    if ( perspective == RCubePerspectiveLeft )
    {
        _left = back;
        _right = front; 
        _front = left;
        _back = right;
        
    }
    
    if ( perspective == RCubePerspectiveRight )
    {
        _left = front;
        _right = back;   
        _front = right;
        _back = left;
        
    }
    
    if ( perspective == RCubePerspectiveTop )
    {
        
        _top = back;
        _bottom = front;
        _front = top;
        _back = bottom;
        
    }
    
    if ( perspective == RCubePerspectiveBottom )
    { 
        _top = front;
        _bottom = back;
        _front = bottom;
        _back = top;
    }
    if ( perspective == RCubePerspectiveBack ) 
    {
        _left = right;
        _right = left;
        _front = back;
        _back = front;
    }
    
    
    // all of the "_" ones hold RELATIVE values to the current perspective.
    int row = column;
    
    
    RFace *__front = [[RFace alloc] initWithFace:_front];
    [__front setRelatedFace:_front.relatedFace];
    
    RFace *__left = [[RFace alloc] initWithFace:_left];
    [__left setRelatedFace:_left.relatedFace];
    
    RFace *__back = [[RFace alloc] initWithFace:_back];
    [__back setRelatedFace:_back.relatedFace];
    
    RFace *__right = [[RFace alloc] initWithFace:_right];
    [__right setRelatedFace:_right.relatedFace];
    
    
    /*
     
     The related face variable allows the deep copy of the face to communicate with the face
     it's actually supposed to represent. The shallow pointer bears this variable by virtue of being a pointer
     
     
     */
    
    
    
    if ( t == RCubeTransformTypeRight )
    {
    
    
        if ( row == 2 ) 
        {
            [_top twistForDirection:RFaceDirectionRight];
            // abc's for cubes being swapped
            
            __left.a = _front.a;
            __left.b = _front.b;
            __left.c = _front.c;
            
            __back.a = _left.a;
            __back.b = _left.b;
            __back.c = _left.c;
            
            __right.a = _back.a;
            __right.b = _back.b;
            __right.c = _back.c;
            
            __front.a = _right.a;
            __front.b = _right.b;
            __front.c = _right.c;
            
            
            
        
        }
        if ( row == 1 ) 
        {
            // def being swapped
            
            __left.d = _front.d;
            __left.e = _front.e;
            __left.f = _front.f;
            
            __back.d = _left.d;
            __back.e = _left.e;
            __back.f = _left.f;
            
            __right.d = _back.d;
            __right.e = _back.e;
            __right.f = _back.f;
            
            __front.d = _right.d;
            __front.e = _right.e;
            __front.f = _right.f;
            
            
            
            
        }
        if ( row == 0 ) 
        {
            [_bottom twistForDirection:RFaceDirectionRight];
            // ghi ''
            
            
            __left.g = _front.g;
            __left.h = _front.h;
            __left.i = _front.i;
            
            __back.g = _left.g;
            __back.h = _left.h;
            __back.i = _left.i;
            
            __right.g = _back.g;
            __right.h = _back.h;
            __right.i = _back.i;
            
            __front.g = _right.g;
            __front.h = _right.h;
            __front.i = _right.i;
            
            
        }
    
    
    }
    if ( t == RCubeTransformTypeLeft )
    {
      
        
        if ( row == 2 ) 
        {
            [_top twistForDirection:RFaceDirectionLeft];
            __front.a = _left.a;
            __front.b = _left.b;
            __front.c = _left.c;
            
            __left.a = _back.a;
            __left.b = _back.b;
            __left.c = _back.c;
            
            __back.a = _right.a;
            __back.b = _right.b;
            __back.c = _right.c;
            
            __right.a = _front.a;
            __right.b = _front.b;
            __right.c = _front.c;
          
            
        }
        if ( row == 1 ) 
        {
            __front.d = _left.d;
            __front.e = _left.e;
            __front.f = _left.f;
            
            __left.d = _back.d;
            __left.e = _back.e;
            __left.f = _back.f;
            
            __back.d = _right.d;
            __back.e = _right.e;
            __back.f = _right.f;
            
            __right.d = _front.d;
            __right.e = _front.e;
            __right.f = _front.f;
            
            
            
            
        }
        if ( row == 0 ) 
        {
            [_bottom twistForDirection:RFaceDirectionLeft];
            
            __front.g = _left.g;
            __front.h = _left.h;
            __front.i = _left.i;
            
            __left.g = _back.g;
            __left.h = _back.h;
            __left.i = _back.i;
            
            __back.g = _right.g;
            __back.h = _right.h;
            __back.i = _right.i;
            
            __right.g = _front.g;
            __right.h = _front.h;
            __right.i = _front.i;
            
            
            
            
            
            
        }

    
    }
    

    
    NSArray *a = [NSArray arrayWithObjects:__front,__back,__left,__right,nil];
    int i = 0;
    for ( RFace *r in a )
    {
        RFace *obj = [self faceWithRelativeID:r.relatedFace];
        
        if ( obj )
        {
            obj = [[RFace alloc] initWithFace:[a objectAtIndex:i]];
        }
        i++;
        
    }
    
  
    
}

- (RFace *)faceWithRelativeID:(int)i
{
    
    NSArray *a = [NSArray arrayWithObjects:top,bottom,front,back,left,right,nil];
    
    
    for ( RFace *ar in a )
    {
        if ( ar.relatedFace == i )
        {
            return ar;
            
        }
        
        
    }
    return nil;
    
    
    
    
    
    
}







// represents a "left" or "right" twist



- (void)dealloc
{
    [top release];
    [bottom release];
    [right release];
    [left release];
    [front release];
    [back release];
    
    [super dealloc];

    
}



@end
