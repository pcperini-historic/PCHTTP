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
        
        if ([valueElement conformsToProtocol: @protocol(NSFastEnumeration)])
        {
            id values = [valueElement copy];
            for (id valueObject in values)
            {
                NSString *key = [[NSString stringWithFormat: @"%@", keyElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                NSString *value = [[NSString stringWithFormat: @"%@", valueObject] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                [dictionaryArray addObject: [NSString stringWithFormat: @"%@=%@", key, value]];
            }
        }
        else
        {
            NSString *key = [[NSString stringWithFormat: @"%@", keyElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSString *value = [[NSString stringWithFormat: @"%@", valueElement] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            [dictionaryArray addObject: [NSString stringWithFormat: @"%@=%@", key, value]];
        }
    }
    
    NSString *dictionaryString = [dictionaryArray componentsJoinedByString: @"&"];
    return dictionaryString;
}

@end
