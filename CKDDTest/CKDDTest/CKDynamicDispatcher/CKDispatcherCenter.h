//
//  CKDispatcherCenter.h
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class CKDispatcherMethod,CKDispatcherProperty;

@interface CKDispatcherCenter : NSObject
/**
 *  属性赋值，执行方法，并返回return值
 *
 *  @param action       需要执行的方法
 *  @param target       目标
 *  @param propertyList 属性列表
 *
 *  @return 返回值
 */
+ (id)performInstanceAction:( CKDispatcherMethod * _Nullable )action
                 withTarget:( NSString * )target
           withPropertyList:( NSArray <CKDispatcherProperty *>* _Nullable )propertyList;
@end

/**
 *  方法Model
 */
@interface CKDispatcherMethod : NSObject
/**
 *  方法名
 */
@property (nonatomic, copy) NSString *methodName;

/**
 *  参数列表
 */
@property (nonatomic, copy) NSArray * _Nullable argumentList;
@end

/**
 *  属性Model
 */
@interface CKDispatcherProperty : NSObject
/**
 *  属性名
 */
@property (nonatomic, copy) NSString *propertyName;

/**
 *  属性值
 */
@property (nonatomic, copy) id propertyValue;

/**
 *  自定义属性的类名
 */
@property (nonatomic, copy) NSString * _Nullable propertyClassName;

/**
 *  自定义属性自身的属性列表
 */
@property (nonatomic, copy) NSArray <CKDispatcherProperty *> * _Nullable propertyList;
@end
NS_ASSUME_NONNULL_END