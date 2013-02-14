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
        if (![valueElement isKindOfClass: [NSString class]])
            continue;
        
        NSString *key = [[NSString stringWithFormat: @"%@", keyElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *value = [[NSString stringWithFormat: @"%@", valueElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        [dictionaryArray addObject: [NSString stringWithFormat: @"%@=%@", key, value]];
    }
    
    NSString *dictionaryString = [dictionaryArray componentsJoinedByString: @"&"];
    return dictionaryString;
}

@end
