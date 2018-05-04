//
//  CPYYClassIvarInfo.m
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import "CPYYClassIvarInfo.h"

@implementation CPYYClassIvarInfo

- (instancetype)initWithIvar:(Ivar)ivar {
    
    if (!ivar) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _ivar = ivar;
        
        const char *name = ivar_getName(ivar);
        if (name) {
            _name = [NSString stringWithUTF8String:name];
        }
        
        const char *typeEncoding = ivar_getTypeEncoding(ivar);
        if (typeEncoding) {
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
            _type = CPEncodingGetType(typeEncoding);
        }
        
    }
    return self;
}

@end
