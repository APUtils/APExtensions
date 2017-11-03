//
//  APUtils.h
//  APExtensions
//
//  Created by mac-246 on 11/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APUtils : NSObject
+ (NSException * _Nullable)perform:(__attribute__((noescape)) void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
