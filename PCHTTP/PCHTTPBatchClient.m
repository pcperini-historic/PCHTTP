//
//  PCHTTPBatchClient.m
//  PCHTTPTests
//
//  Created by Patrick Perini on 2/13/13.
//
//

#import "PCHTTPBatchClient.h"
#import "PCHTTPClient.h"

#pragma mark - Internal Constants
typedef enum
{
    PCHTTPBatchClientGETMethod,
    PCHTTPBatchClientPOSTMethod,
    PCHTTPBatchClientPUTMethod,
    PCHTTPBatchClientDELETEMethod
} PCHTTPBatchClientMethod;

NSString *const PCHTTPBatchClientMethodKey = @"PCHTTPBatchClientMethod";
NSString *const PCHTTPBatchClientURLKey = @"PCHTTPBatchClientURL";
NSString *const PCHTTPBatchClientParametersKey = @"PCHTTPBatchClientParameters";
NSString *const PCHTTPBatchClientPayloadKey = @"PCHTTPBatchClientPayload";

@interface PCHTTPBatchClient ()

#pragma mark - Properties
@property NSMutableArray *requests;

#pragma mark - Mutators
- (void)addRequest:(NSString *)url method:(PCHTTPBatchClientMethod)method parameters:(NSDictionary *)parameters payload:(id)payload;

@end

@implementation PCHTTPBatchClient

#pragma mark - Internal Properties
@synthesize requests;

#pragma mark - Initializers
- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    requests = [NSMutableArray array];
    
    return self;
}

#pragma mark - Appending Methods
#pragma mark - - GET
- (void)addGetRequest:(NSString *)url
{
    [self addGetRequest: url
             parameters: nil];
}

- (void)addGetRequest:(NSString *)url parameters:(NSDictionary *)parameters
{
    [self addRequest: url
              method: PCHTTPBatchClientGETMethod
          parameters: parameters
             payload: nil];
}

#pragma mark - - POST
- (void)addPostRequest:(NSString *)url
{
    [self addPostRequest: url
              parameters: nil
                 payload: nil];
}

- (void)addPostRequest:(NSString *)url parameters:(NSDictionary *)parameters
{
    [self addPostRequest: url
              parameters: parameters
                 payload: nil];
}

- (void)addPostRequest:(NSString *)url payload:(id)payload
{
    [self addPostRequest: url
              parameters: nil
                 payload: payload];
}

- (void)addPostRequest:(NSString *)url parameters:(NSDictionary *)parameters payload:(id)payload
{
    [self addRequest: url
              method: PCHTTPBatchClientPOSTMethod
          parameters: parameters
             payload: payload];
}

#pragma mark - - PUT
- (void)addPutRequest:(NSString *)url
{
    [self addPutRequest: url
             parameters: nil
                payload: nil];
}

- (void)addPutRequest:(NSString *)url parameters:(NSDictionary *)parameters
{
    [self addPutRequest: url
             parameters: parameters
                payload: nil];
}

- (void)addPutRequest:(NSString *)url payload:(id)payload
{
    [self addPutRequest: url
             parameters: nil
                payload: payload];
}

- (void)addPutRequest:(NSString *)url parameters:(NSDictionary *)parameters payload:(id)payload
{
    [self addRequest: url
              method: PCHTTPBatchClientPUTMethod
          parameters: parameters
             payload: payload];
}

#pragma mark - - DELETE
- (void)addDeleteRequest:(NSString *)url
{
    [self addDeleteRequest: url
                parameters: nil];
}

- (void)addDeleteRequest:(NSString *)url parameters:(NSDictionary *)parameters
{
    [self addRequest: url
              method: PCHTTPBatchClientDELETEMethod
          parameters: parameters
             payload: nil];
}

#pragma mark - Internal Mutators
- (void)addRequest:(NSString *)url method:(PCHTTPBatchClientMethod)method parameters:(NSDictionary *)parameters payload:(id)payload
{
    NSMutableDictionary *request = [@{
        PCHTTPBatchClientMethodKey: @(method),
        PCHTTPBatchClientURLKey: url,
    } mutableCopy];
    
    if (parameters)
    {
        [request setObject: parameters
                    forKey: PCHTTPBatchClientParametersKey];
    }
    
    if (payload)
    {
        [request setObject: payload
                    forKey: PCHTTPBatchClientPayloadKey];
    }
    
    [requests addObject: request];
}

#pragma mark - Batch Request Performers
- (void)performRequestsWithResponseHandler:(PCHTTPBatchResponseBlock)responseBlock
{
    dispatch_queue_t current_queue = dispatch_get_current_queue();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^()
    {
        NSMutableArray *responses = [NSMutableArray array];
        for (NSDictionary *request in requests)
        {
            PCHTTPResponse *response;
            switch ([[request objectForKey: PCHTTPBatchClientMethodKey] integerValue])
            {
                case PCHTTPBatchClientGETMethod:
                {
                    response = [PCHTTPClient get: [request objectForKey: PCHTTPBatchClientURLKey]
                                      parameters: [request objectForKey: PCHTTPBatchClientParametersKey]];
                    break;
                }
                    
                case PCHTTPBatchClientPOSTMethod:
                {
                    response = [PCHTTPClient post: [request objectForKey: PCHTTPBatchClientURLKey]
                                       parameters: [request objectForKey: PCHTTPBatchClientParametersKey]
                                          payload: [request objectForKey: PCHTTPBatchClientPayloadKey]];
                    break;
                }
                    
                case PCHTTPBatchClientPUTMethod:
                {
                    response = [PCHTTPClient put: [request objectForKey: PCHTTPBatchClientURLKey]
                                      parameters: [request objectForKey: PCHTTPBatchClientParametersKey]
                                         payload: [request objectForKey: PCHTTPBatchClientPayloadKey]];
                    break;
                }
                    
                case PCHTTPBatchClientDELETEMethod:
                {
                    response = [PCHTTPClient delete: [request objectForKey: PCHTTPBatchClientURLKey]
                                         parameters: [request objectForKey: PCHTTPBatchClientParametersKey]];
                    break;
                }
            }
            
            [responses addObject: response];
        }
        
        dispatch_async(current_queue, ^()
        {
            if (responseBlock)
            {
                responseBlock(responses);
            }
        });
    });
}

@end
