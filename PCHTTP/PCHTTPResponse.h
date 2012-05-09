//
//  PCHTTPResponse.h
//
//  Created by Patrick Perini on 4/29/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>

/*!
 Response codes that correspond to HTTP response codes.
 */
typedef enum
{
    PCHTTPSuccessfulResponse        = 200,
    PCHTTPBadRequestResponse        = 400,
    PCHTTPForbiddenResponse         = 403,
    PCHTTPNotFoundResponse          = 404,
    PCHTTPMethodNotAllowedResponse  = 405,
    PCHTTPServerError               = 500
} PCHTTPResponseStatus;

/*!
 Represents a response for a single request.
 */
@interface PCHTTPResponse : NSObject

#pragma mark - Request Information
/// -------------------------------------
/// @name Request Information
/// -------------------------------------

/*!
 The URL of the request for which this is the response. 
 */
@property NSString *requestURL;

#pragma mark - Response Information
/// -------------------------------------
/// @name Response Information
/// -------------------------------------

/*!
 The HTTP status code.
 */
@property NSInteger status;

/*!
 The raw response data.
 */
@property NSData *data;

/*!
 The response data in string form.
 */
@property (readonly) NSString *string;

/*!
 The response data in JSON object form.
 */
@property (readonly) id object;

@end

typedef void(^PCHTTPResponseBlock)(PCHTTPResponse *response);
