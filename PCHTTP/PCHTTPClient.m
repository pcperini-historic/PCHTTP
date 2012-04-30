//
//  PCHTTPClient.m
//
//  Created by Patrick Perini on 4/29/12.
//  Copyright (c) 2012 Patrick Perini. All rights reserved.
//

#import "PCHTTPClient.h"
#import "PCHTTPSerializer.h"

@interface PCHTTPClient ()

+ (void)asynchronouslyRequestURL: (NSString *)url method: (NSString *)method parameters: (NSDictionary *)parameters payload: (id)payload withBlock: (PCHTTPResponseBlock)responseBlock;
+ (PCHTTPResponse *)synchronouslyRequestURL: (NSString *)url method: (NSString *)method parameters: (NSDictionary *)parameters payload: (id)payload;

@end

@implementation PCHTTPClient

#pragma mark - Internal Methods
+ (void)asynchronouslyRequestURL:(NSString *)url method:(NSString *)method parameters:(NSDictionary *)parameters payload:(id)payload withBlock:(PCHTTPResponseBlock)responseBlock
{
    dispatch_queue_t current_queue = dispatch_get_current_queue();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^()
    {
        PCHTTPResponse *response = [PCHTTPClient synchronouslyRequestURL: url
                                                                  method: method
                                                              parameters: parameters
                                                                 payload: payload];
        
        dispatch_async(current_queue, ^()
        {
            responseBlock(response);
        });
    });
}

+ (PCHTTPResponse *)synchronouslyRequestURL:(NSString *)url method:(NSString *)method parameters:(NSDictionary *)parameters payload:(id)payload
{
    PCHTTPResponse *response = [[PCHTTPResponse alloc] init];
    NSString *urlString = [url copy];
    NSData *requestBody = nil;
    
    if ([method isEqualToString: @"GET"] || [method isEqualToString: @"DELETE"])
    {
        if (parameters)
        {
            NSString *parameterString = [PCHTTPSerializer keyValueEvaluateDictionary: parameters];
            urlString = [urlString stringByAppendingFormat: @"?%@", parameterString];
        }
    }
    else if ([method isEqualToString: @"POST"] || [method isEqualToString: @"PUT"])
    {        
        if ([payload isKindOfClass: [NSData class]])
        {
            requestBody = payload;
        }
        else if ([payload respondsToSelector: @selector(dataUsingEncoding:)])
        {
            requestBody = [payload dataUsingEncoding: NSUTF8StringEncoding];
        }
        else if ([payload conformsToProtocol: @protocol(PCHTTPSerializableObject)])
        {
            requestBody = [payload serializedData];
        }
        else if ([payload isKindOfClass: [NSDictionary class]])
        {
            NSString *payloadString = [PCHTTPSerializer keyValueEvaluateDictionary: payload];
            requestBody = [payloadString dataUsingEncoding: NSUTF8StringEncoding];
        }
        else if (payload)
        {
            @throw @"Invalid payload object. Please pass one of [NSData, NSString, NSDictionary, id<PCHTTPSerializableObject>].";
        }
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod: method];
    [request setHTTPBody: requestBody];
    
    NSHTTPURLResponse *httpResponse;
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request
                                                 returningResponse: &httpResponse
                                                             error: nil];
    [response setRequestURL: urlString];
    [response setData: responseData];
    [response setStatus: [httpResponse statusCode]];
    return response;
}

#pragma mark - Synchronous Methods
+ (PCHTTPResponse *)get:(NSString *)url parameters:(NSDictionary *)parameters
{
    return [PCHTTPClient synchronouslyRequestURL: url
                                          method: @"GET"
                                      parameters: parameters
                                         payload: nil];
}

+ (PCHTTPResponse *)post:(NSString *)url payload:(id)payload
{
    return [PCHTTPClient synchronouslyRequestURL: url
                                          method: @"POST"
                                      parameters: nil
                                         payload: payload];
}

+ (PCHTTPResponse *)put:(NSString *)url payload:(id)payload
{
    return [PCHTTPClient synchronouslyRequestURL: url
                                          method: @"PUT"
                                      parameters: nil
                                         payload: payload];
}

+ (PCHTTPResponse *)delete:(NSString *)url parameters:(NSDictionary *)parameters
{
    return [PCHTTPClient synchronouslyRequestURL: url
                                          method: @"DELETE"
                                      parameters: parameters
                                         payload: nil];
}

#pragma mark - Asynchronous Methods
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters withBlock:(PCHTTPResponseBlock)responseBlock
{
    [PCHTTPClient asynchronouslyRequestURL: url
                                    method: @"GET"
                                parameters: parameters
                                   payload: nil
                                 withBlock: responseBlock];
}

+ (void)post:(NSString *)url payload:(id)payload withBlock:(PCHTTPResponseBlock)responseBlock
{
    [PCHTTPClient asynchronouslyRequestURL: url
                                    method: @"POST"
                                parameters: nil
                                   payload: payload
                                 withBlock: responseBlock];
}

+ (void)put:(NSString *)url payload:(id)payload withBlock:(PCHTTPResponseBlock)responseBlock
{
    [PCHTTPClient asynchronouslyRequestURL: url
                                    method: @"PUT"
                                parameters: nil
                                   payload: payload
                                 withBlock: responseBlock];
}

+ (void)delete:(NSString *)url parameters:(NSDictionary *)parameters withBlock:(PCHTTPResponseBlock)responseBlock
{
    [PCHTTPClient asynchronouslyRequestURL: url
                                    method: @"DELETE"
                                parameters: parameters
                                   payload: nil
                                 withBlock: responseBlock];
}

@end