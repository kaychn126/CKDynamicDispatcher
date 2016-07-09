//
//  CKDispatcherModel.h
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 方法类型
 */
typedef NS_ENUM(NSInteger, CKMethodType) {
    /**
     实例方法
     */
    CKMethodTypeInstance = 1,
    /**
     类方法
     */
    CKMethodTypeClass
};

NS_ASSUME_NONNULL_BEGIN
/**
 *  方法Model
 */
@interface CKDispatcherMethod : NSObject<NSCopying>

/**
 *  通过字典生成实例
 *
 *  @param params 字典
 *
 *  @return 实例
 */
- (instancetype)initWithParams:(NSDictionary*)params;

/**
 *  方法名
 */
@property (nonatomic, copy) NSString *methodName;

/**
 *  参数列表
 */
@property (nonatomic, strong) NSArray * _Nullable argumentList;

@property (nonatomic, assign) CKMethodType methodType;
@end

/**
 *  属性Model
 */
@interface CKDispatcherProperty : NSObject<NSCopying>

/**
 *  通过字典生成实例
 *
 *  @param params 字典
 *
 *  @return 实例
 */
- (instancetype)initWithParams:(NSDictionary*)params;
/**
 *  属性名
 */
@property (nonatomic, copy) NSString *propertyName;

/**
 *  属性值
 */
@property (nonatomic, copy) id _Nullable propertyValue;

/**
 *  自定义属性的类名
 */
@property (nonatomic, copy) NSString * _Nullable propertyClassName;

/**
 *  自定义属性自身的属性列表
 */
@property (nonatomic, strong) NSArray <CKDispatcherProperty *> * _Nullable propertyList;
@end

NS_ASSUME_NONNULL_END