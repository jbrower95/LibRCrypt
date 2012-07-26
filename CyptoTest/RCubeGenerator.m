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
    printf("Smallerstrings: %d\n\n",smallerStrings.count);
    
    [smallerStrings replaceObjectAtIndex:smallerStrings.count-1 withObject:last];
    
    
    // now we have a legitimate stringy type thing:
    
    // lets form these into Cubes
    
    printf("Generating %d Cubes...\n",[smallerStrings count]);
    
    // generate the cubes.. seperate the strings into managable data
    
    for ( NSString *portion in smallerStrings )
    {
        NSArray *components = [self chopString:portion intoStringsOfSize:9];
        
        // LOL THIS IS SO ARTSY. DIDNT EVEN REALIZE ID BE ABLE TO USE THE CHOP METHOD TWICE
        
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
                if ( index % 9 == 0 && index != 0 )
                {
                    [str appendString:SEPERATOR];
                    flopper = 0;
                    
                    
                }
                if ( flopper == 0 )
                {
                    // draw a char from a
                    [str appendString:[a substringWithRange:NSMakeRange(index, 1)]];
                    flopper = 1;
                    index++;
                }
                else {
                    // we insert a ","
                    [str appendString:@","];
                    flopper = 0;
                    
                }
                
          
                
                
            }
            NSLog(@"Str: %@",str);
        
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
        printf("Added chunk\n");
        
        [ret addObject:chunk];
      
        
        
    }
    
    
    
    return ret;
    
    
    
    
}











@end
