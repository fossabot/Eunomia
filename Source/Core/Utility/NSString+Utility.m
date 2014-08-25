//
//  NSString+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 4/17/14.
//
//

#import "NSString+Utility.h"

#import "Utility.h"

@implementation NSString (Eunomia_Utility)

+ (NSString *)randomStringOfLength:(NSUInteger)length withAllowedCharacters:(NSString *)allowedCharacters
{
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    
    NSRange range;
    range.length = 1;
    for (range.location = 0; range.location < length; range.location ++)
    {
        unichar randomCharacter = [allowedCharacters characterAtIndex:randomi() % allowedCharacters.length];
        [result appendFormat:@"%c", randomCharacter];
    }
    
    return result;
}

// from http://stackoverflow.com/a/1149894
- (BOOL)validEmail
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end