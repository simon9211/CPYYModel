//
//  CPYYClassMethodInfo.m
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import "CPYYClassMethodInfo.h"

@implementation CPYYClassMethodInfo

- (instancetype)initWithMethod:(Method)method {
    if (!method) {
        return nil;
    }
    self = [super init];
    if (self) {
        _method = method;
        _sel = method_getName(method);
        _imp = method_getImplementation(method);
        
        const char *name = sel_getName(_sel);
        if (name) {
            _name = [NSString stringWithUTF8String:name];
        }
        
        const char *typeEncoding = method_getTypeEncoding(method);
        if (typeEncoding) {
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        }
        
        const char *returnTypeEncoding = method_copyReturnType(method);
        if (returnTypeEncoding) {
            _returnTypeEncoding = [NSString stringWithUTF8String:returnTypeEncoding];
        }
        
        unsigned int count = method_getNumberOfArguments(method);
        if (count > 0) {
            NSMutableArray *types = [NSMutableArray array];
            for (int i = 0; i < count; i++) {
                char *argumentsType = method_copyArgumentType(method, i);
                NSString *type = argumentsType?[NSString stringWithUTF8String:argumentsType]:nil;
                [types addObject:type?type:@""];
                if (argumentsType) {
                    free(argumentsType);
                }
            }
            _argumentTypeEncodings = types;
        }
    }
    return self;
}

@end
