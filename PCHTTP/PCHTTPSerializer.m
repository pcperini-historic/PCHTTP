//
//  PCHTTPSerializer.m
//
//  Created by Patrick Perini on 4/30/12.
//  Copyright (c) 2012 Patrick Perini. All rights reserved.
//

#import "PCHTTPSerializer.h"
#import "PCContainerComprehension.h"

@implementation PCHTTPSerializer

+ (NSString *)keyValueEvaluateDictionary:(NSDictionary *)dictionary
{
    NSArray *dictionaryArray = [[dictionary allKeys] arrayByComprehendingWithBlock: ^id (id element)
    {
        NSString *key = [element stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *value = [[dictionary objectForKey: element] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        return [NSString stringWithFormat: @"%@=%@", key, value];
    }];
    
    NSString *dictionaryString = [dictionaryArray componentsJoinedByString: @"&"];
    return dictionaryString;
}

@end
