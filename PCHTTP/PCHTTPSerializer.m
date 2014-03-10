//
//  PCHTTPSerializer.m
//
//  Created by Patrick Perini on 4/30/12.
//  Licensing information available in README.md
//

#import "PCHTTPSerializer.h"

@implementation PCHTTPSerializer

+ (NSString *)keyValueEvaluateDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *dictionaryArray = [NSMutableArray array];
    for (NSString *keyElement in dictionary)
    {
        id valueElement = [dictionary objectForKey: keyElement];

        BOOL validClass = NO;
        validClass |= [valueElement isKindOfClass: [NSString class]];
        validClass |= [valueElement isKindOfClass: [NSNumber class]];
        validClass |= [valueElement isKindOfClass: [NSArray class]];
        validClass |= [valueElement isKindOfClass: [NSDate class]];
        validClass |= [valueElement isKindOfClass: [NSNull class]];

        if (!validClass)
            continue;

        NSString *key = [[NSString stringWithFormat: @"%@", keyElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *value;

        if ([valueElement isKindOfClass: [NSString class]] || [valueElement isKindOfClass: [NSNumber class]] || [valueElement isKindOfClass: [NSNull class]])
        {
            value = [[NSString stringWithFormat: @"%@", valueElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        }
        else if ([valueElement isKindOfClass: [NSDate class]])
        {
            value = [NSString stringWithFormat: @"%f", [valueElement timeIntervalSince1970]];
        }
        else if ([valueElement isKindOfClass: [NSArray class]])
        {
            value = [valueElement componentsJoinedByString: @","];
        }

        [dictionaryArray addObject: [NSString stringWithFormat: @"%@=%@", key, value]];
    }

    NSString *dictionaryString = [dictionaryArray componentsJoinedByString: @"&"];
    return dictionaryString;
}

+ (NSString *)jsonEvaluateDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutableDictionary = [dictionary mutableCopy];
    for (NSString *key in dictionary)
    {
        id value = [mutableDictionary valueForKey: key];

        // Coerce values
        if ([value isKindOfClass: [NSDate class]])
        {
            [mutableDictionary setValue: @([value timeIntervalSince1970])
                                 forKey: key];
        }
    }

    return [[NSString alloc] initWithData: [NSJSONSerialization dataWithJSONObject: mutableDictionary
                                                                           options: 0
                                                                             error: nil]
                                 encoding: NSUTF8StringEncoding];
}

@end
