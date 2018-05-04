//
//  CPYYClassInfo.h
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@class CPYYClassIvarInfo,CPYYClassMethodInfo,CPYYClassPropertyInfo;

NS_ASSUME_NONNULL_BEGIN
@interface CPYYClassInfo : NSObject
@property(nonatomic, assign, readonly) Class cls;
@property(nonatomic, assign, readonly) Class superClass;
@property(nonatomic, assign, readonly) Class metaClass;
@property(nonatomic, assign, readonly) BOOL isMeta;
@property(nonatomic, strong, readonly) NSString *name;
@property(nullable, nonatomic, strong, readonly) CPYYClassInfo *superClassInfo;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CPYYClassIvarInfo *> *ivarInfos;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CPYYClassMethodInfo *> *methodInfos;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CPYYClassPropertyInfo *> *propertyInfos;

- (void)setNeedUpdate:(BOOL)needUpdate;
- (BOOL)needUpdate;

+ (nullable instancetype)classInfoWithClass:(Class)cls;

NS_ASSUME_NONNULL_END
@end
