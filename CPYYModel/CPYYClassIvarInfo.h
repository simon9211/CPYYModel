//
//  CPYYClassIvarInfo.h
//  CPYYModel
//
//  Created by xiwang wang on 2017/7/18.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CPYYCommon.h"

@interface CPYYClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, assign, readonly) CPEncodingType type;

- (instancetype)initWithIvar:(Ivar)ivar;

@end
