//
//  APUtils.m
//  APExtensions
//
//  Created by mac-246 on 11/3/17.
//

#import "APUtils.h"

@implementation APUtils

+ (NSException *)perform:(__attribute__((noescape)) void (^)(void))block {
    @try {
        block();
    } @catch (NSException *exception) {
        return exception;
    }
    
    return nil;
}

@end
