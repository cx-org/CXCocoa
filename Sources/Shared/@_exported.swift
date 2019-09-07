#if USE_COMBINE
// CXCompatible doesn't support cocoapods now.
@_exported import CXCompatible
#else
@_exported import CXFoundation
#endif
