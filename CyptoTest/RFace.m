//
//  RFace.m
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RFace.h"

@implementation RFace

@synthesize a, b, c, d, e, f, g, h, i;
@synthesize relatedFace;

- (id)initWithArray:(int *)chars
{
    self = [super init];
    if ( self )
    {
    self.a = chars[0];
    self.b = chars[1];
    self.c = chars[2];
    self.d = chars[3];
    self.e = chars[4];
    self.f = chars[5];
    self.g = chars[6];
    self.h = chars[7];
    self.i = chars[8];
    }
    return self;
}


- (id)initWithFace:(RFace *)another
{
    self = [super init];
    
    if ( self )
    {
        self.a = another.a;
        self.b = another.b;
        self.c = another.c;
        self.d = another.d;
        self.e = another.e;
        self.f = another.f;
        self.g = another.g;
        self.h = another.h;
        self.i = another.i;
        
         
    }
    return self;
    
    
}

- (NSString *)generateStream
{
    
    // this method allows an RFace object to be serealized.
  
    
    NSString *output = [NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d,%d,%d,%d%@",a,b,c,d,e,f,g,h,i,SEPERATOR];
    return output;
  
    
}

- (id)initWithStream:(NSString *)str
{
    
    self = [super init];
    
    // stream must have length 9
    
    NSArray *stream = [str componentsSeparatedByString:@","];
    
    if ( !([stream count] == 9) )
    {
        
        NSException *exception = [NSException exceptionWithName:@"RFaceInvalidStreamException" reason:[NSString stringWithFormat:@"Stream of invalid length: %d",[stream count]]userInfo:nil];
            @throw exception;
            // this faces stream was invalid
            return nil;
            
            
     }
    
    // precondition: stream.length == 9
    
    self.a = [[stream objectAtIndex:0] intValue];
     self.b = [[stream objectAtIndex:1] intValue];
    self.c = [[stream objectAtIndex:2] intValue];;
     self.d = [[stream objectAtIndex:3] intValue];
     self.e = [[stream objectAtIndex:4] intValue];
     self.f = [[stream objectAtIndex:5] intValue];
     self.g = [[stream objectAtIndex:6] intValue];
     self.h = [[stream objectAtIndex:7] intValue];
     self.i = [[stream objectAtIndex:8] intValue];
    
   // printf("Initialized Face: %d%d%d%d%d%d%d%d%d\n",a,b,c,d,e,f,g,h,i);
    
    // the 10th character is always SEPERATOR
    
    return self;
    
    
    
}

- (void)twistForDirection:(RFaceDirection)direction
{
    
    
    int _a, _b, _c, _d, _e, _f, _g, _h, _i = 0;
    
     
    _a = a;
    _b = b;
    _c = c;
    _d = d;
    _e = e;
    _f = f;
    _g = g;
    _h = h;
    _i = i;
    
    // dump a copy of the face as it was

    
    switch (direction)
    {
        case RFaceDirectionRight:
            
            // we're twisting left
            
            
            a = _g;
            b = _d;
            c = _a;
            d = _h;
            f = _b;
            g = _i;
            i = _c;
            h = _f;
            
            break;
            
        case RFaceDirectionLeft:
            
            
            // we're twisting right
            
            a = _c;
            b = _f;
            c = _i;
            d = _b;
            e = _e;
            f = _h;
            g = _a;
            h = _d;
            i = _g;
       
            
            break;
 
            
    }
    
    
    
    
}


@end
