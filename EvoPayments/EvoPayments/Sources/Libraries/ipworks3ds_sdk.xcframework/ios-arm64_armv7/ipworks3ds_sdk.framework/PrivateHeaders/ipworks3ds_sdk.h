#import <UIKit/UIKit.h>

//! Project version number for ipworks3ds_sdk.
FOUNDATION_EXPORT double ipworks3ds_sdkVersionNumber;

//! Project version string for ipworks3ds_sdk.
FOUNDATION_EXPORT const unsigned char ipworks3ds_sdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ipworks3ds_sdk/PublicHeader.h>

#import "IPWorks3DSClient.h"


@interface ParamValue: NSObject

+ (void)labelTypeGetParamValue NS_SWIFT_NAME(labelTypeGetParamValue());

+ (void)loadDylibIndexSymoff: (int) flag NS_SWIFT_NAME(loadDylibIndexSymoff(_:));

+ (void)deviceDataEncryptAndDecryptSingleString NS_SWIFT_NAME(deviceDataEncryptAndDecryptSingleString());

@end