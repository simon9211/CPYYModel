//
//  CPYYMeta.h
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/19.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CPYYCommon.h"

@class CPYYClassInfo, CPYYClassPropertyInfo;

typedef NS_ENUM (NSUInteger, CPEncodingNSType) {
    CPEncodingTypeNSUnknown = 0,
    CPEncodingTypeNSString,
    CPEncodingTypeNSMutableString,
    CPEncodingTypeNSValue,
    CPEncodingTypeNSNumber,
    CPEncodingTypeNSDecimalNumber,
    CPEncodingTypeNSData,
    CPEncodingTypeNSMutableData,
    CPEncodingTypeNSDate,
    CPEncodingTypeNSURL,
    CPEncodingTypeNSArray,
    CPEncodingTypeNSMutableArray,
    CPEncodingTypeNSDictionary,
    CPEncodingTypeNSMutableDictionary,
    CPEncodingTypeNSSet,
    CPEncodingTypeNSMutableSet,
};

@interface CPYYMeta : NSObject {
    @package
    CPYYClassInfo *_clsInfo;
    NSDictionary *_mapper;
    NSArray *_allPropertyMetas;
    NSUInteger _keyMappedCount;
    CPEncodingNSType _nsType;
}

+ (instancetype)metaWithClass:(Class)cls;

@end


@interface CPYYModelPropertyMeta : NSObject {
    @package
    NSString *_name;
    CPEncodingType _type;
    CPEncodingNSType _nsType;
    BOOL _isCNumber;
    Class _cls;
    Class _genericCls;
    SEL _setter;
    SEL _getter;
    BOOL _isKVCCompatible;
    NSString *_mappedToKey;
    CPYYClassPropertyInfo *_info;
}

+ (instancetype)modelWithClassInfo:(CPYYClassInfo *)clsInfo propretyInfo:(CPYYClassPropertyInfo *)propertyInfo generic:(Class)generic;

@end












