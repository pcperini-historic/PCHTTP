//
//  PCHTTPSerializer.m
//
//  Created by Patrick Perini on 4/30/12.
//  Licensing information available in README.md
//

#import "PCHTTPSerializer.h"
#import "PCContainerComprehension.h"

@implementation PCHTTPSerializer

+ (NSString *)keyValueEvaluateDictionary:(NSDictionary *)dictionary
{
    NSArray *dictionaryArray = [[dictionary allKeys] arrayByComprehendingWithBlock: ^id (id element)
    {
        NSString *key = [[NSString stringWithFormat: @"%@", element] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *value = [[NSString stringWithFormat: @"%@", [dictionary objectForKey: element]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        return [NSString stringWithFormat: @"%@=%@", key, value];
    }];
    
    NSString *dictionaryString = [dictionaryArray componentsJoinedByString: @"&"];
    return dictionaryString;
}

@end
