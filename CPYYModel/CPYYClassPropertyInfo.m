//
//  CPYYClassPropertyInfo.m
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import "CPYYClassPropertyInfo.h"

@implementation CPYYClassPropertyInfo

- (instancetype)initProperty:(objc_property_t)property {
    if (!property) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _property = property;
        
        const char *name = property_getName(property);
        if (name) {
            _name = [NSString stringWithUTF8String:name];
        }
        
        CPEncodingType type = 0;
        unsigned int outCount;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &outCount);
        for (unsigned int i = 0; i < outCount; i++) {
            switch (attrs[i].name[0]) {
                case 'T':
                    if (attrs[i].value) {
                        _typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                        _type = CPEncodingGetType(attrs[i].value);
                        
                        if ((type & CPEncodingTypeMask) == CPEncodingTypeObject && _typeEncoding.length) {
                            size_t len = strlen(attrs[i].value);
                            if (len > 3) {
                                char name[len - 2];
                                name[len - 3] = '\0';
                                memcpy(name, attrs[i].value + 2, len - 3);
                                _cls = objc_getClass(name);
                            }
                        }
                    }
                    break;
                    case 'V':
                        if (attrs[i].value) {
                            _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                        }
                    break;
                    case 'R':
                    type |= CPEncodingTypePropertyReadonly;
                    break;
                    case 'C':
                    type |= CPEncodingTypePropertyCopy;
                    break;
                case '&':
                    type |= CPEncodingTypePropertyRetain;
                    break;
                    
                case 'N':
                    type |= CPEncodingTypePropertyNonatomic;
                    break;
                    
                case 'D':
                    type |= CPEncodingTypePropertyDynamic;
                    break;
                    
                case 'W':
                    type |= CPEncodingTypePropertyWeak;
                    break;
                    
                case  'G':
                    type |= CPEncodingTypePropertyCustomGetter;
                    if (attrs[i].value) {
                        _getter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                    }
                    break;
                    
                case 'S':
                    type |= CPEncodingTypePropertyCustomSetter;
                    if (attrs[i].value) {
                        _setter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                    }
                    break;
                default:
                    break;
            }
        }
        if (attrs) {
            free(attrs);
            attrs = NULL;
        }
        
        _type = type;
        
        if (_name.length) {
            if (!_getter) {
                _getter = NSSelectorFromString(_name);
            }
            if (!_setter) {
                _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",[_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]]);
            }
        }
    }
    
    return self;
}

@end
