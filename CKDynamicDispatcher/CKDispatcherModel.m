//
//  CKDispatcherModel.m
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "CKDispatcherModel.h"

@implementation CKDispatcherMethod

- (instancetype)initWithParams:(NSDictionary*)params{
    if (self = [super init]) {
        self.methodName = [params valueForKey:@"methodName"];
        self.methodType = [[params valueForKey:@"methodType"] integerValue];
        self.argumentList = [params valueForKey:@"argumentList"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    CKDispatcherMethod *methodModel = [[[self class] allocWithZone:zone] init];
    methodModel.methodName = self.methodName;
    methodModel.methodType = self.methodType;
    methodModel.argumentList = self.argumentList;
    return methodModel;
}

@end

@implementation CKDispatcherProperty

- (instancetype)initWithParams:(NSDictionary*)params{
    if (self = [super init]) {
        self.propertyName = [params valueForKey:@"propertyName"];
        self.propertyValue = [params valueForKey:@"propertyValue"];
        self.propertyClassName = [params valueForKey:@"propertyClassName"];
        
        NSArray *propertyList = [params valueForKey:@"propertyList"];
        if (propertyList.count>0) {
            NSMutableArray *propertyModelList = [NSMutableArray arrayWithCapacity:propertyList.count];
            
            for (NSDictionary *dic in propertyList) {
                CKDispatcherProperty *propertyModel = [[CKDispatcherProperty alloc] initWithParams:dic];
                [propertyModelList addObject:propertyModel];
            }
            self.propertyList = propertyModelList;
            
        }
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    CKDispatcherProperty *propertyModel = [[[self class] allocWithZone:zone] init];
    propertyModel.propertyName = self.propertyName;
    propertyModel.propertyValue = self.propertyValue;
    propertyModel.propertyList = self.propertyList;
    propertyModel.propertyClassName = self.propertyClassName;
    return propertyModel;
}

@end