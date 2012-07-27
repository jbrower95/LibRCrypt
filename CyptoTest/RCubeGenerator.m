//
//  RCubeGenerator.m
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCubeGenerator.h"

@implementation RCubeGenerator

@synthesize generatedCubes;


- (NSString *)outputAsString
{
    
    NSMutableString *i = [NSMutableString string];
    
    for ( RCube *r in generatedCubes)
    {
      
        [i appendString:[r spillData]];
    }
    
    [i stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return i;
}


- (void)generateCubesForString:(NSString *)input
{
    if ( !generatedCubes )
    {
        generatedCubes = [[NSMutableArray alloc] init];
    }
    
    
    // we need to change it into strings of equal size
    
    NSMutableArray *smallerStrings = [self chopString:input intoStringsOfSize:54];
    
    NSString *last = [smallerStrings objectAtIndex:smallerStrings.count-1];
    
    if ( last.length < 54 )
    {
        NSMutableString *str = [NSMutableString stringWithString:last];
        
        while ( str.length < 54 )
        {
            [str appendString:@" "];
          
        }
        
        last = (NSString*)str;
    }
    //printf("Smallerstrings: %d\n\n",smallerStrings.count);
    
    [smallerStrings replaceObjectAtIndex:smallerStrings.count-1 withObject:last];
    
    
    // now we have a legitimate stringy type thing:
    
    // lets form these into Cubes
    
    //printf("Generating %d Cubes...\n",[smallerStrings count]);
    
    // generate the cubes.. seperate the strings into managable data
    
    for ( NSString *portion in smallerStrings )
    {
        // portion is a 54 character portion in smallerStrings
        
        
        NSArray *components = [self chopString:portion intoStringsOfSize:9];
        
        // anyways, chop it into FACE sized strings
        NSMutableArray *faces = [NSMutableArray array];
        
        for ( NSString *a in components )
        {
            // now we need to seperate each char by a ","
            NSMutableString *str = [NSMutableString string];
            
            int index = 0;
            int flopper = 0;
            
            while ( index < a.length )
            {
                                      
                
                if ( flopper == 0 )
                {
                    // draw a char from a
                    [str appendString:[a substringWithRange:NSMakeRange(index, 1)]];
                    flopper = 1;
                    index++;
                    
                }
                else {
                    // we insert a ","
                    [str appendString:SEPERATOR];
                    flopper = 0;
                    
                }
                
          
                
                
            }
            
            
            RFace *face = [[RFace alloc] initWithStream:str];
            [faces addObject:face];
            
            

            
            if ( [faces count] == 6 )
            {
            RCube *r = [[RCube alloc] initWithFaces:faces];
            [generatedCubes addObject:r];
            [faces removeAllObjects];
            }
            
        }
   
        
        
    }
    
    
    
    
    
    
    
    
}

- (NSMutableArray *)chopString:(NSString*)str intoStringsOfSize:(int)size
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    int index = 0;
    
    while ( index < str.length )
    {
        NSMutableString *chunk = [NSMutableString string];
        
        
        int RV = 0;
        
        while ( RV < size )
        {
            NSString *a;
            int done = 0;
            @try 
            {
                a = [str substringWithRange:NSMakeRange(index, 1)];
                
            }
            @catch ( NSException *e )
            {
                // this means we're outside of the range
                done = 1;
            }
            if ( done == 1 ) 
            {
               break; 
            }
            
            [chunk appendString:a];
            RV++;
            index++;
        }
        //printf("Added chunk\n");
        
        [ret addObject:chunk];
      
        
        
    }
    
    
    
    return ret;
    
    
    
    
}



- (void)encryptCubes
{
    
    if ( generatedKeys == nil )
    {
        generatedKeys = [[NSMutableArray alloc] init];        
    }
    
    for ( int i = 0; i < [generatedCubes count]; i++)
    {
        if ( i > 0 )
        {
            if ( [generatedCubes objectAtIndex:i] != nil)
            {
                NSString *t = [(RCube*)[generatedCubes objectAtIndex:i] applyRandomTransforms];
                [generatedKeys addObject:t];
            }
            
        }
    }
  
}




// method for outputting a transformstring XOR'd to a password


- (NSString *)transformKeyWithPassword:(NSString *)password
{
    NSMutableString *tf = [NSMutableString string];
    
    for ( int i = 0; i < [generatedKeys count]; i++)
    {
        [tf appendString:[generatedKeys objectAtIndex:i]];
    }
    
    NSString *output = [(NSString *)tf stringByEncodingWithCipher:password];
    
    return output;
    
}

- (NSString *)cubeDataWithPassword:(NSString *)password
{
    NSString *data = [self outputAsString];
    
    data = [data stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [data stringByEncodingWithCipher:password];
    
}







@end
