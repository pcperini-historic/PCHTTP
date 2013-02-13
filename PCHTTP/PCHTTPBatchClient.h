//
//  PCHTTPBatchClient.h
//  PCHTTPTests
//
//  Created by Patrick Perini on 2/13/13.
//
//

#import <Foundation/Foundation.h>
#import "PCHTTPResponse.h"

#pragma mark - External Types
typedef void(^PCHTTPBatchResponseBlock)(NSArray *responses);

/*!
    Allows users to make batch HTTP requests using a simple API.
    Requests provide a callback block for asynchronous returns.
 */
@interface PCHTTPBatchClient : NSObject

#pragma mark - Appending Methods
/// -------------------------------------
/// @name Adding Requests
/// -------------------------------------

/// @name Performing GET Requests

/*!
    Appends a GET request on the given URL.
    @param url The URL to request.
 */
- (void)addGetRequest:(NSString *)url;

/*!
    Appends a GET request on the given URL.
    @param url The URL to request.
    @param parameters A dictionary of query string parameters.
 */
- (void)addGetRequest:(NSString *)url parameters:(NSDictionary *)parameters;

/// @name Performing POST Requests

/*!
    Append a POST request on the given URL.
    @param url The URL to request.
 */
- (void)addPostRequest:(NSString *)url;

/*!
    Appends a POST request on the given URL.
    @param url The URL to request.
    @param  parameters  A dictionary of query string parameters.
    @return The response for the request.
 */
- (void)addPostRequest:(NSString *)url parameters:(NSDictionary *)parameters;

/*!
    Appends a POST request on the given URL.
    @param url The URL to request.
    @param payload The object for the POST body.
 */
- (void)addPostRequest:(NSString *)url payload:(id)payload;

/*!
    Appends a POST request on the given URL.
    @param url The URL to request.
    @param parameters A dictionary of query string parameters.
    @param payload The object for the POST body.
    @return The response for the request.
 */
- (void)addPostRequest:(NSString *)url parameters:(NSDictionary *)parameters payload:(id)payload;

/// @name Performing PUT Requests

/*!
    Appends a PUT request on the given URL.
    @param url The URL to request.
    @return The response for the request.
 */
- (void)addPutRequest:(NSString *)url;

/*!
    Appends a PUT request on the given URL.
    @param url The URL to request.
    @param parameters A dictionary of query string parameters.
    @return The response for the request.
 */
- (void)addPutRequest:(NSString *)url parameters:(NSDictionary *)parameters;

/*!
    Appends a PUT request on the given URL.
    @param url The URL to request.
    @param payload The object for the PUT body.
    @return The response for the request.
 */
- (void)addPutRequest:(NSString *)url payload:(id)payload;

/*!
    Appends a synchronous POST request on the given URL.
    @param url The URL to request.
    @param parameters A dictionary of query string parameters.
    @param payload The object for the POST body.
    @return The response for the request.
 */
- (void)addPutRequest:(NSString *)url parameters:(NSDictionary *)parameters payload:(id)payload;

/// @name Performing DELETE Requests

/*!
    Appends a synchronous DELETE request on the given URL.
    @param  url         The URL to request.
    @return The response for the request.
 */
- (void)addDeleteRequest:(NSString *)url;

/*!
    Appends a synchronous DELETE request on the given URL.
    @param url The URL to request.
    @param parameters A dictionary of query string parameters.
    @return The response for the request.
 */
- (void)addDeleteRequest:(NSString *)url parameters:(NSDictionary *)parameters;

#pragma mark - Batch Request Performers
/// -------------------------------------
/// @name Performing Batch Requests
/// -------------------------------------

/*!
    Appends a GET request on the given URL.
    @param url The URL to request.
 */
- (void)performRequestsWithResponseHandler:(PCHTTPBatchResponseBlock)responseBlock;

@end
