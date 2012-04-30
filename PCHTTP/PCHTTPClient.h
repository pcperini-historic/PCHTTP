//
//  PCHTTPClient.h
//
//  Created by Patrick Perini on 4/29/12.
//  Copyright (c) 2012 Patrick Perini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCHTTPResponse.h"

/*!
 Allows users to make HTTP requests using a simple API.
 
 Requests can return response data inline and synchronously, or provide a callback block for asynchronous returns.
 */
@interface PCHTTPClient : NSObject

#pragma mark - Synchronous Methods
/// -------------------------------------
/// @name Making Synchronous Requests
/// -------------------------------------

/*!
 Performs a synchronous GET request on the given URL.
 @param  url         The URL to request.
 @param  parameters  A dictionary of query string parameters.
 @return The response for the request.
 */
+ (PCHTTPResponse *)get: (NSString *)url parameters: (NSDictionary *)parameters;

/*!
 Performs a synchronous POST request on the given URL.
 @param  url      The URL to request.
 @param  payload  The object for the POST body.
 @return The response for the request.
 */
+ (PCHTTPResponse *)post: (NSString *)url payload: (id)payload;

/*!
 Performs a synchronous PUT request on the given URL.
 @param  url      The URL to request.
 @param  payload  The object for the PUT body.
 @return The response for the request.
 */
+ (PCHTTPResponse *)put: (NSString *)url payload: (id)payload;

/*!
 Performs a synchronous DELETE request on the given URL.
 @param  url         The URL to request.
 @param  parameters  A dictionary of query string parameters.
 @return The response for the request.
 */
+ (PCHTTPResponse *)delete: (NSString *)url parameters: (NSDictionary *)parameters;

#pragma mark - Asynchronous Methods
/// -------------------------------------
/// @name Making Synchronous Requests
/// -------------------------------------

/*!
 Performs an asynchronous GET request on the given URL.
 @param   url           The URL to request.
 @param   parameters    A dictionary of query string parameters.
 @param   responseBlock The response handler.
 */
+ (void)get: (NSString *)url parameters: (NSDictionary *)parameters withBlock: (PCHTTPResponseBlock) responseBlock;

/*!
 Performs an asynchronous POST request on the given URL.
 @param   url           The URL to request.
 @param   payload       The object for the POST body.
 @param   responseBlock The response handler.
 */
+ (void)post: (NSString *)url payload: (id)payload withBlock: (PCHTTPResponseBlock) responseBlock;

/*!
 Performs an asynchronous PUT request on the given URL.
 @param   url           The URL to request.
 @param   payload       The object for the PUT body.
 @param   responseBlock The response handler.
 */
+ (void)put: (NSString *)url payload: (id)payload withBlock: (PCHTTPResponseBlock) responseBlock;

/*!
 Performs an asynchronous DELETE request on the given URL.
 @param   url           The URL to request.
 @param   parameters    A dictionary of query string parameters.
 @param   responseBlock The response handler.
 */
+ (void)delete: (NSString *)url parameters: (NSDictionary *)parameters withBlock: (PCHTTPResponseBlock) responseBlock;

@end
