//
//  NSObject+CKDispatcher.m
//  CKDDTest
//
//  Created by 陈凯 on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "NSObject+CKDispatcher.h"
#import "CKDispatcherCenter.h"
#import <objc/runtime.h>

static char *kAssociatedDispatcherProperty;

@implementation NSObject (CKDispatcher)
@dynamic ck_property;

- (void)setCk_property:(CKDispatcherProperty *)ck_property{
    if (!ck_property.propertyClassName) {
        //非自定义类型
        if ([self respondsToSelector:NSSelectorFromString(ck_property.propertyName)]) {
            [self setValue:ck_property.propertyValue forKey:ck_property.propertyName];
        }
    } else {
        //自定义类型
        if ([self respondsToSelector:NSSelectorFromString(ck_property.propertyName)]){
            
            Class propertyClazz = NSClassFromString(ck_property.propertyClassName);
            
            if (propertyClazz) {
                
                id propertyInstance = [[propertyClazz alloc] init];
                
                if ([propertyInstance isKindOfClass:NSObject.class]) {
                    
                    NSObject *instance = propertyInstance;
                    
                    //set property`s property
                    if (ck_property.propertyList.count > 0) {
                        [ck_property.propertyList enumerateObjectsUsingBlock:^(CKDispatcherProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            instance.ck_property = obj;
                        }];
                    }
                    
                    [self setValue:instance forKey:ck_property.propertyName];
                }
            }
        }
    }
    objc_setAssociatedObject(self, &kAssociatedDispatcherProperty, ck_property, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CKDispatcherProperty *)ck_property{
    return objc_getAssociatedObject(self, &kAssociatedDispatcherProperty);
}
@end
