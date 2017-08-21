//
//  NSArray+GLDeepCopy.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/18.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "NSArray+GLDeepCopy.h"

@implementation NSArray (GLDeepCopy)

- (instancetype)GLDeepCopy
{
    NSMutableArray *resultMutableArray = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id object in self) {
        
        //定义一个id类型来接收拷贝后的
        id copyObject = nil;
        
        //如果该对象有该方法 
        if ([object respondsToSelector:@selector(GLDeepCopy)]) {
            copyObject = [object GLDeepCopy];
        //判断该对象是否实现了NSCopying 协议的方法  如果是 则进行copy
        }else if ([object conformsToProtocol:@protocol(NSCopying)]){
            copyObject = [object copy];
        }else if ([object conformsToProtocol:@protocol(NSMutableCopying)]){
            copyObject = [object mutableCopy];
        }else{
            copyObject = object;
        }
        
        [resultMutableArray addObject:copyObject];
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [NSArray arrayWithArray:resultMutableArray];
    }else{
        return resultMutableArray;
    }
}

@end
