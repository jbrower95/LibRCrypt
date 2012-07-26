//
//  RCubeDecoder.m
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCubeDecoder.h"

@implementation RCubeDecoder

+ (NSString *)negatingTransformStringForString:(NSString *)input
{
    
    NSMutableString *output = [NSMutableString string];

    // a reverse for loop
    
    int ticker = 0;
    // ticker variable tells us which property we're on
    
    int c; int b; int a;
    
    for ( int i = input.length-1; i>-1; i--)
    {
        
        
        
        
        if ( ticker == 0 )
        {
            // this is what we reverse
            
           // we're technically on property 2 because it's backwards
            
            c = [[input substringWithRange:NSMakeRange(i, 1)] intValue];
            ticker++;
            
        }
        else if ( ticker == 1 )
        {
            // now we're on 1, another property that doesn't change
            
            
           b  = [[input substringWithRange:NSMakeRange(i, 1)] intValue];
            ticker++;
            
        }
        else if ( ticker == 2 )
        {
            // now we're on a, the property that DOES change.
            
            a = ([[input substringWithRange:NSMakeRange(i, 1)] intValue] == 1  ? 0 : 1);
            // negate the property. this is the actual decoding! :)
            
            // now we append the string
            
            [output appendFormat:@"%d%d%d",a,b,c];
            
            ticker = 0;
        }
        
        
        
        
        
        
        
    }
    
    
    return output;
}


@end
