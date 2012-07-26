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
    self.a = (int)chars[0];
    self.b = (int)chars[1];
    self.c = (int)chars[2];
    self.d = (int)chars[3];
    self.e = (int)chars[4];
    self.f = (int)chars[5];
    self.g = (int)chars[6];
    self.h = (int)chars[7];
    self.i = (int)chars[8];
    }
    return self;
}

// different output methods

- (NSString *)formattedOutput
{
    NSString *ret = [NSString stringWithFormat:@"%c-%c-%c\n%c-%c-%c\n%c-%c-%c",(char)a,(char)b,(char)c,(char)d,(char)e,(char)f,(char)g,(char)h,(char)i];
    
    return ret;
}
- (NSString *)cumulativeOutput
{
    NSString *ret = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c%c",(char)a,(char)b,(char)c,(char)d,(char)e,(char)f,(char)g,(char)h,(char)i];
    
    return ret;
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
    
    
    // we can't just use intValue for this..
    self.a = (int)[[stream objectAtIndex:0] characterAtIndex:0];
    self.b = (int)[[stream objectAtIndex:1] characterAtIndex:0];
    self.c = (int)[[stream objectAtIndex:2] characterAtIndex:0];
     self.d = (int)[[stream objectAtIndex:3] characterAtIndex:0];
     self.e = (int)[[stream objectAtIndex:4] characterAtIndex:0];
     self.f = (int)[[stream objectAtIndex:5] characterAtIndex:0];
     self.g = (int)[[stream objectAtIndex:6] characterAtIndex:0];
     self.h = (int)[[stream objectAtIndex:7] characterAtIndex:0];
     self.i = (int)[[stream objectAtIndex:8] characterAtIndex:0];
    
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
