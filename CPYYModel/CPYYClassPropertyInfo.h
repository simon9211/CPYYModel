//
//  CPYYClassPropertyInfo.h
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CPYYCommon.h"

NS_ASSUME_NONNULL_BEGIN
@interface CPYYClassPropertyInfo : NSObject

@property(nonatomic, assign, readonly) objc_property_t property;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, assign, readonly) CPEncodingType type;
@property(nonatomic, strong, readonly) NSString *typeEncoding;
@property(nonatomic, strong, readonly) NSString *ivarName;
@property(nullable, nonatomic, assign, readonly) Class cls;
@property(nonatomic, assign, readonly) SEL setter;
@property(nonatomic, assign, readonly) SEL getter;

- (instancetype)initProperty:(objc_property_t)property;

NS_ASSUME_NONNULL_END
@end
