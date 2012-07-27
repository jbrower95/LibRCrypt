//
//  RCubeDecoder.h
//  CyptoTest
//
//  Created by Justin Brower on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+XOR.h"
#import "RCubeGenerator.h"

@interface RCubeDecoder : NSObject



+ (NSString *)negatingTransformStringForString:(NSString *)input;
// this method allows a transform string's opposite transforms to be generated

+ (NSString *)decodeData:(NSString *)data withTransformKey:(NSString *)key password:(NSString *)password;
// this is the cornerstone method of the class for decoding data. Returns an NSString with the resulting data
@end
