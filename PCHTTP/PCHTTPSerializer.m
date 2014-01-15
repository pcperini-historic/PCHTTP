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
        
        if (!validClass)
            continue;
        
        NSString *key = [[NSString stringWithFormat: @"%@", keyElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *value;
        
        if ([valueElement isKindOfClass: [NSString class]] || [valueElement isKindOfClass: [NSNumber class]])
        {
            value = [[NSString stringWithFormat: @"%@", valueElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
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

@end
