#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CXCocoa.h"
#import "_cx_objc.h"

FOUNDATION_EXPORT double CXCocoaVersionNumber;
FOUNDATION_EXPORT const unsigned char CXCocoaVersionString[];

