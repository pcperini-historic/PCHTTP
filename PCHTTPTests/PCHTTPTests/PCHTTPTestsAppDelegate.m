//
//  PCHTTPTestsAppDelegate.m
//  PCHTTP
//
//  Created by Patrick Perini on 4/30/12.
//  Licensing information available in README.md
//

#import "PCHTTPTestsAppDelegate.h"
#import "PCHTTP.h"

@implementation PCHTTPTestsAppDelegate

@synthesize window = _window;

static NSString *mainURL = @"http://localhost:5000";
static NSDictionary *stuff;

void logResponse(NSString *header, PCHTTPResponse *response)
{
    NSLog(@"%@: %@\n\t%@", header, response, [[NSString alloc] initWithData: [response data]
                                                                   encoding: NSUTF8StringEncoding]);
}

- (void)testClient
{
    stuff = @{
        @"hello": @"world"
    };
    PCHTTPResponse *response;
    
    // TEST GET
    response = [PCHTTPClient get: mainURL parameters: stuff];
    logResponse(@"sync GET", response);
    
    [PCHTTPClient get: mainURL
           parameters: stuff
            responseHandler: ^(PCHTTPResponse *aResponse) {
                logResponse(@"async GET", aResponse);
            }];
    
    // TEST POST
    response = [PCHTTPClient post: mainURL payload: stuff];
    logResponse(@"sync POST", response);
    
    [PCHTTPClient post: mainURL
               payload: stuff
             responseHandler: ^(PCHTTPResponse *aResponse) {
                 logResponse(@"async POST", aResponse);
             }];
    
    // TEST PUT
    response = [PCHTTPClient put: mainURL payload: stuff];
    logResponse(@"sync PUT", response);
    
    [PCHTTPClient put: mainURL
              payload: stuff
            responseHandler: ^(PCHTTPResponse *aResponse) {
                logResponse(@"async PUT", aResponse);
            }];
    
    // TEST DELETE
    response = [PCHTTPClient delete: mainURL parameters: stuff];
    logResponse(@"sync DELETE", response);
    
    [PCHTTPClient delete: mainURL
              parameters: stuff
               responseHandler: ^(PCHTTPResponse *aResponse) {
                   logResponse(@"async DELETE", aResponse);
               }];
}

- (void)testBatchClient
{
    stuff = @{
        @"hello": @"world"
    };
    
    PCHTTPBatchClient *batchClient = [[PCHTTPBatchClient alloc] init];
    
    // TEST GET
    [batchClient addGetRequest: mainURL];
    [batchClient addGetRequest: mainURL parameters: stuff];
    
    // TEST POST
    [batchClient addPostRequest: mainURL];
    [batchClient addPostRequest: mainURL parameters: stuff];
    [batchClient addPostRequest: mainURL payload: stuff];
    [batchClient addPostRequest: mainURL parameters: stuff payload: stuff];
    
    // TEST PUT
    [batchClient addPutRequest: mainURL];
    [batchClient addPutRequest: mainURL parameters: stuff];
    [batchClient addPutRequest: mainURL payload: stuff];
    [batchClient addPutRequest: mainURL parameters: stuff payload: stuff];
    
    // TEST DELETE
    [batchClient addDeleteRequest: mainURL];
    [batchClient addDeleteRequest: mainURL parameters: stuff];
    
    [batchClient performRequestsWithResponseHandler: ^(NSArray *responses) {
        for (PCHTTPResponse *response in responses)
        {
            logResponse(@"batch", response);
        }
    }];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //[self testClient];
    [self testBatchClient];
}

@end
