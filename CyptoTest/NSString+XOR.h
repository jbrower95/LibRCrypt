//
//  NSString+NSString_XOR.h
//  LibXOR
//
//  Created by Justin on 7/25/12.
//  Copyright (c) 2012 Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    
    Category of NSString (XOR)
 
    Implements a modulating XOR Cipher on the NSString:
 
    "a b c d e f g h"
 
    when encoded with "a b c"
 
    will be encoded as:
 
    a^a
    b^b
    c^c
    d^a
    e^b
    f^c
 
    etc.
 
    the cipher is repeatedly applied to the string

 
*/

@interface NSString (XOR)



- (NSString *)stringByEncodingWithCipher:(NSString *)cipher;
// encodes an NSString by modulating against an NSString cipher

- (NSString *)stringByDecodingFromCipher:(NSString *)cipher;
// decodes an NSString by demodulating against an NSString cipher;

@end
