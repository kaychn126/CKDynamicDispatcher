//
//  NSObject+DynamicInvoker.m
//  DDTest
//
//  Created by 陈凯 on 16/7/1.
//  Copyght © 2016年 EasyBenefit. All ghts reserved.
//

#import "NSObject+DynamicInvoker.h"
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CKArgumentType){
    CKArgumentTypeUnknown,
    CKArgumentTypeChar,
    CKArgumentTypeUnsignedChar,
    CKArgumentTypeInt,
    CKArgumentTypeUnsignedInt,
    CKArgumentTypeShort,
    CKArgumentTypeUnsignedShort,
    CKArgumentTypeLong,
    CKArgumentTypeUnsignedLong,
    CKArgumentTypeLongLong,
    CKArgumentTypeUnsignedLongLong,
    CKArgumentTypeFloat,
    CKArgumentTypeDouble,
    CKArgumentTypeBool,
    CKArgumentTypeVoid,
    CKArgumentTypeCharacterString,
    CKArgumentTypeCGPoint,
    CKArgumentTypeCGSize,
    CKArgumentTypeCGRect,
    CKArgumentTypeUIEdgeInsets,
    CKArgumentTypeObject,
    CKArgumentTypeClass
};

@implementation NSMethodSignature (DynamicInvoker)

+ (CKArgumentType)ck_getArgumentTypeWithEncode:(const char *)encode{
    if (strcmp(encode, @encode(char)) == 0) {
        return CKArgumentTypeChar;
    } else if (strcmp(encode, @encode(int)) == 0) {
        return CKArgumentTypeInt;
    } else if (strcmp(encode, @encode(short)) == 0) {
        return CKArgumentTypeShort;
    } else if (strcmp(encode, @encode(long)) == 0) {
        return CKArgumentTypeLong;
    } else if (strcmp(encode, @encode(long long)) == 0) {
        return CKArgumentTypeLongLong;
    } else if (strcmp(encode, @encode(unsigned char)) == 0) {
        return CKArgumentTypeUnsignedChar;
    } else if (strcmp(encode, @encode(unsigned int)) == 0) {
        return CKArgumentTypeUnsignedInt;
    } else if (strcmp(encode, @encode(unsigned short)) == 0) {
        return CKArgumentTypeUnsignedShort;
    } else if (strcmp(encode, @encode(unsigned long)) == 0) {
        return CKArgumentTypeUnsignedLong;
    } else if (strcmp(encode, @encode(unsigned long long)) == 0) {
        return CKArgumentTypeUnsignedLongLong;
    } else if (strcmp(encode, @encode(float)) == 0) {
        return CKArgumentTypeFloat;
    } else if (strcmp(encode, @encode(double)) == 0) {
        return CKArgumentTypeDouble;
    } else if (strcmp(encode, @encode(BOOL)) == 0) {
        return CKArgumentTypeBool;
    } else if (strcmp(encode, @encode(void)) == 0) {
        return CKArgumentTypeVoid;
    } else if (strcmp(encode, @encode(char *)) == 0) {
        return CKArgumentTypeCharacterString;
    } else if (strcmp(encode, @encode(id)) == 0) {
        return CKArgumentTypeObject;
    } else if (strcmp(encode, @encode(Class)) == 0) {
        return CKArgumentTypeClass;
    } else if (strcmp(encode, @encode(CGPoint)) == 0) {
        return CKArgumentTypeCGPoint;
    } else if (strcmp(encode, @encode(CGSize)) == 0) {
        return CKArgumentTypeCGSize;
    } else if (strcmp(encode, @encode(CGRect)) == 0) {
        return CKArgumentTypeCGRect;
    } else if (strcmp(encode, @encode(UIEdgeInsets)) == 0) {
        return CKArgumentTypeUIEdgeInsets;
    } else {
        return CKArgumentTypeUnknown;
    }
}

- (NSInvocation *)ck_getInvocationWithArguments:(NSArray *)arguments {
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self];
    
    NSAssert(arguments == nil || [arguments isKindOfClass:[NSArray class]], @"# RuntimeInvoker # arguments is not an array");
    
    [arguments enumerateObjectsUsingBlock:^(id  _Nonnull argument, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger index = idx + 2; // start with 2
        CKArgumentType type = [self ck_getArgumentTypeAtIndex:index];
        
        switch (type) {
            case CKArgumentTypeChar: {
                char value = [argument charValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeInt: {
                int value = [argument intValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeShort: {
                short value = [argument shortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeLong: {
                long value = [argument longValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeLongLong: {
                long long value = [argument longLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeUnsignedChar: {
                unsigned char value = [argument unsignedCharValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeUnsignedInt: {
                unsigned int value = [argument unsignedIntValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeUnsignedShort: {
                unsigned short value = [argument unsignedShortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeUnsignedLong: {
                unsigned long value = [argument unsignedLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeUnsignedLongLong: {
                unsigned long long value = [argument unsignedLongLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeFloat: {
                float value = [argument floatValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeDouble: {
                double value = [argument doubleValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeBool: {
                BOOL value = [argument boolValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeVoid: {
                
            } break;
            case CKArgumentTypeCharacterString: {
                const char *value = [argument UTF8String];
                [invocation setArgument:&value atIndex:index];
            } break;
            case CKArgumentTypeObject: {
                [invocation setArgument:&argument atIndex:index];
            } break;
            case CKArgumentTypeClass: {
                Class value = [argument class];
                [invocation setArgument:&value atIndex:index];
            } break;
                
            default: break;
        }
    }];
    
    return invocation;
}

- (CKArgumentType)ck_getArgumentTypeAtIndex:(NSInteger)index {
    const char *encode = [self getArgumentTypeAtIndex:index];
    return [NSMethodSignature ck_getArgumentTypeWithEncode:encode];
}

- (CKArgumentType)ck_returnType {
    return [NSMethodSignature ck_getArgumentTypeWithEncode:[self methodReturnType]];
}
@end

#pragma mark- NSInvocation category

@implementation NSInvocation (DynamicInvoker)

- (id)invoke:(id)target selector:(SEL)selector returnType:(CKArgumentType)type {
    self.target = target;
    self.selector = selector;
    [self invoke];
    return [self returnValueForType:type];
}

- (id)returnValueForType:(CKArgumentType)type {
    
    __unsafe_unretained id returnValue;
    
    switch (type) {
        case CKArgumentTypeChar: {
            char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeInt:  {
            int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeShort:  {
            short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeLong:  {
            long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeLongLong:  {
            long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeUnsignedChar:  {
            unsigned char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeUnsignedInt:  {
            unsigned int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeUnsignedShort:  {
            unsigned short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeUnsignedLong:  {
            unsigned long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeUnsignedLongLong:  {
            unsigned long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeFloat:  {
            float value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeDouble:  {
            double value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeBool: {
            BOOL value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case CKArgumentTypeCharacterString: {
            const char *value;
            [self getReturnValue:&value];
            returnValue = [NSString stringWithUTF8String:value];
        } break;
        case CKArgumentTypeCGPoint: {
            CGPoint value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGPoint:value];
        } break;
        case CKArgumentTypeCGSize: {
            CGSize value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGSize:value];
        } break;
        case CKArgumentTypeCGRect: {
            CGRect value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGRect:value];
        } break;
        case CKArgumentTypeUIEdgeInsets: {
            UIEdgeInsets value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithUIEdgeInsets:value];
        } break;
        case CKArgumentTypeObject:
        case CKArgumentTypeClass:
            [self getReturnValue:&returnValue];
            break;
        default: break;
    }
    return returnValue;
}

@end

@implementation NSObject (DynamicInvoker)

+ (id)invokeTarget:(id)target selector:(NSString*)selector argumentList:(NSArray *)argumentList{
    SEL sel = NSSelectorFromString(selector);
    NSMethodSignature *signature = [target methodSignatureForSelector:sel];
    if (signature) {
        NSInvocation *invocation = [signature ck_getInvocationWithArguments:argumentList];
        id rtValue = [invocation invoke:target selector:sel returnType:[signature ck_returnType]];
        return rtValue;
    } else {
        return nil;
    }
}

- (id)ck_invoke:(NSString *)selector argumentList:(NSArray *)argumentList{
    return [NSObject invokeTarget:self selector:selector argumentList:argumentList];
}

+ (id)ck_invoke:(NSString *)selector argumentList:(NSArray * _Nullable)argumentList{
    return [NSObject invokeTarget:self.class selector:selector argumentList:argumentList];
}
@end
