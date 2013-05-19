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
    // Informational
    PCHTTPResponseStatusContinue                        = 100,
    PCHTTPResponseStatusSwitchingProtocols              = 101,
    
    // Successful
    PCHTTPResponseStatusOK                              = 200,
    PCHTTPResponseStatusCreated                         = 201,
    PCHTTPResponseStatusAccepted                        = 202,
    PCHTTPResponseStatusNonAuthoritativeInformation     = 203,
    PCHTTPResponseStatusNoContent                       = 204,
    PCHTTPResponseStatusResetContent                    = 205,
    PCHTTPResponseStatusPartialContent                  = 206,
    
    // Redirection
    PCHTTPResponseStatusMutltipleChoices                = 300,
    PCHTTPResponseStatusMovedPermanently                = 301,
    PCHTTPResponseStatusFound                           = 302,
    PCHTTPResponseStatusSeeOther                        = 303,
    PCHTTPResponseStatusNotModified                     = 304,
    PCHTTPResponseStatusUseProxy                        = 305,
    PCHTTPResponseStatusSwitchProxy                     = 306,
    PCHTTPResponseStatusTemporaryRedirect               = 307,
    
    // Client Errors
    PCHTTPResponseStatusBadRequest                      = 400,
    PCHTTPResponseStatusUnauthorized                    = 401,
    PCHTTPResponseStatusPaymentRequired                 = 402,
    PCHTTPResponseStatusForbidden                       = 403,
    PCHTTPResponseStatusNotFound                        = 404,
    PCHTTPResponseStatusMethodNotAllowed                = 405,
    PCHTTPResponseStatusNotAcceptable                   = 406,
    PCHTTPResponseStatusProxyAuthenticationRequired     = 407,
    PCHTTPResponseStatusRequestTimeout                  = 408,
    PCHTTPResponseStatusConflict                        = 409,
    PCHTTPResponseStatusGone                            = 410,
    PCHTTPResponseStatusLengthRequired                  = 411,
    PCHTTPResponseStatusPreconditionFailed              = 412,
    PCHTTPResponseStatusRequestEntityTooLarge           = 413,
    PCHTTPResponseStatusRequestURITooLong               = 414,
    PCHTTPResponseStatusUnsupportedMediaType            = 415,
    PCHTTPResponseStatusRequestedRangeNotSatisfiable    = 416,
    PCHTTPResponseStatusExpectationFailed               = 417,
    
    // Server Errors
    PCHTTPResponseStatusInternalServerError             = 500,
    PCHTTPResponseStatusNotImpemented                   = 501,
    PCHTTPResponseStatusBadGateway                      = 502,
    PCHTTPResponseStatusServiceUnavailable              = 503,
    PCHTTPResponseStatusGatewayTimeout                  = 504,
    PCHTTPResponseStatusHTTPVersionNotSupported         = 505
    
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

/*!
    The body of the request for which this is the response.
 */
@property NSData *requestBody;

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
