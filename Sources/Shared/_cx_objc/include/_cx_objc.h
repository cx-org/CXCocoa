#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

extern const IMP _cx_objc_msgForward;

void _cx_objc_setAssociatedObject(const void* object, const void* key, id _Nullable value, objc_AssociationPolicy policy);

NS_ASSUME_NONNULL_END
