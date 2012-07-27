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








+ (NSString *)decodeData:(NSString *)data withTransformKey:(NSString *)key password:(NSString *)password{
    

    // this is the cornerstone method of the class for decoding data. Returns an NSString with the resulting data
    
    key = [key stringByDecodingFromCipher:password];
   
    if ( key.length % 3 != 0 )
    {
        @throw [NSException exceptionWithName:@"RCubeDecoderInvalidTransformSequence" reason:@"Transform Key.length % 3 should ALWAYS = 0" userInfo:nil];
    }
    
    // now that we've finished this key, lets find out the number of cubes that are encoded.
    
    data = [data stringByDecodingFromCipher:password];
    RCubeGenerator *jenny = [[RCubeGenerator alloc] init];
    [jenny generateCubesForString:data];
    
    // our individual length is represented by      key.length  /   (3 * cubes.count)
    
    
    int tLength = key.length / (3 * [[jenny generatedCubes] count]);
    printf("Key length: %d\n",tLength);
    NSArray *keys = [jenny chopString:key intoStringsOfSize:tLength];
    // now we've gotten our individual keys into an array called "keys". SUPER AWESOME.
    
    // now lets undo our cubes' transformations
    int i = 0;
    // i is our counter
    for ( RCube *a in [jenny generatedCubes])
    {
        NSString *opposite = [RCubeDecoder negatingTransformStringForString:[keys objectAtIndex:i]];
        [a applyTransformsFromString:opposite];
        i++;
    }
    
    
    // now that we've applied our opposite transforms, we should be able to rescue the data.
    
    NSString *decodedData = [jenny outputAsString];
    
    [jenny release];
    
    return decodedData;
    
    
}








@end
