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

void logResponse(NSString *header, PCHTTPResponse *response)
{
    NSLog(@"%@: %@\n\t%@", header, response, [[NSString alloc] initWithData: [response data]
                                                                   encoding: NSUTF8StringEncoding]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *mainURL = @"http://localhost:8080";
    NSDictionary *stuff = [NSDictionary dictionaryWithObjectsAndKeys:
        @"hello", @"world",
        nil
    ];
    PCHTTPResponse *response;
    
    // TEST GET
    response = [PCHTTPClient get: mainURL parameters: stuff];
    logResponse(@"sync GET", response);
    
    [PCHTTPClient get: mainURL
           parameters: stuff
            withBlock: ^(PCHTTPResponse *aResponse) {
                logResponse(@"async GET", aResponse);
            }];
    
    // TEST POST
    response = [PCHTTPClient post: mainURL payload: stuff];
    logResponse(@"sync POST", response);
    
    [PCHTTPClient post: mainURL
               payload: stuff
             withBlock: ^(PCHTTPResponse *aResponse) {
                 logResponse(@"async POST", aResponse);
             }];
    
    // TEST PUT
    response = [PCHTTPClient put: mainURL payload: stuff];
    logResponse(@"sync PUT", response);
    
    [PCHTTPClient put: mainURL
              payload: stuff
            withBlock: ^(PCHTTPResponse *aResponse) {
                logResponse(@"async PUT", aResponse);
            }];
    
    // TEST DELETE
    response = [PCHTTPClient delete: mainURL parameters: stuff];
    logResponse(@"sync DELETE", response);
    
    [PCHTTPClient delete: mainURL
              parameters: stuff
               withBlock: ^(PCHTTPResponse *aResponse) {
                   logResponse(@"async DELETE", aResponse);
               }];
}

@end
