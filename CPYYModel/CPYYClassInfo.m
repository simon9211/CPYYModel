//
//  CPYYClassInfo.m
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import "CPYYClassInfo.h"
#import "CPYYClassIvarInfo.h"
#import "CPYYClassMethodInfo.h"
#import "CPYYClassPropertyInfo.h"
@implementation CPYYClassInfo {
    BOOL _needUpdate;
}

- (void)setNeedUpdate:(BOOL)needUpdate {
    _needUpdate = needUpdate;
}

- (BOOL)needUpdate {
    return _needUpdate;
}

- (instancetype)initWithClass:(Class)cls {
    if (!cls) {
        return nil;
    }
    self = [super init];
    if (self) {
        _cls = cls;
        _superClass = class_getSuperclass(cls);
        _isMeta = class_isMetaClass(cls);
        if (_isMeta) {
            _metaClass = objc_getMetaClass(class_getName(cls));
        }
        [self _update];
        _name = NSStringFromClass(cls);
        _superClassInfo = [self.class classInfoWithClass:cls];
    }
    return self;
}

+ (instancetype)classInfoWithClass:(Class)cls {
    if (!cls) {
        return nil;
    }
    
    static NSMutableDictionary *metaCache, *classCache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        metaCache = [NSMutableDictionary dictionary];
        classCache = [NSMutableDictionary dictionary];
        lock = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    CPYYClassInfo *info;
    if (class_isMetaClass(cls)) {
        info = [metaCache valueForKey:NSStringFromClass(cls)];
    } else {
        info = [classCache valueForKey:NSStringFromClass(cls)];
    }
    if (info && info->_needUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);
    
    if (!info) {
        info = [[CPYYClassInfo alloc] initWithClass:cls];
        if (info) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            if (info.isMeta) {
                [metaCache setValue:info forKey:NSStringFromClass(cls)];
            } else {
                [classCache setValue:info forKey:NSStringFromClass(cls)];
            }
            dispatch_semaphore_signal(lock);
        }
    }
    return info;
}

- (void)_update {
    _methodInfos = nil;
    _propertyInfos = nil;
    _ivarInfos = nil;
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(self.cls, &ivarCount);
    if (ivars) {
        _ivarInfos = [NSMutableDictionary dictionary];
        for (unsigned int i = 0; i < ivarCount; i++) {
            CPYYClassIvarInfo *ivarInfo = [[CPYYClassIvarInfo alloc] initWithIvar:ivars[i]];
            if (ivarInfo.name) {
                [_ivarInfos setValue:ivarInfo forKey:ivarInfo.name];
            }
        }
        free(ivars);
    }
    
    unsigned int propertyCount= 0;
    objc_property_t *propertys = class_copyPropertyList(self.cls, &propertyCount);
    if (propertys) {
        _propertyInfos = [NSMutableDictionary dictionary];
        for (unsigned int i = 0; i < propertyCount; i++) {
            CPYYClassPropertyInfo *propertyInfo = [[CPYYClassPropertyInfo alloc] initProperty:propertys[i]];
            if (propertyInfo.name) {
                [_propertyInfos setValue:propertyInfo forKey:propertyInfo.name];
            }
        }
        free(propertys);
    }
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(self.cls, &methodCount);
    if (methods) {
        _methodInfos = [NSMutableDictionary dictionary];
        for (unsigned int i = 0; i < methodCount; i++) {
            CPYYClassMethodInfo *methodInfo = [[CPYYClassMethodInfo alloc] initWithMethod:methods[i]];
            if (methodInfo.name) {
                [_methodInfos setValue:methodInfo forKey:methodInfo.name];
            }
        }
        free(methods);
    }
    
    if (!_ivarInfos) {
        _ivarInfos = @{};
    }
    if (!_propertyInfos) {
        _propertyInfos = @{};
    }
    if (!_methodInfos) {
        _methodInfos = @{};
    }
    
    _needUpdate = NO;
}



























@end
