//
//  NSSet+GLDeepCopy.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/21.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "NSSet+GLDeepCopy.h"

@implementation NSSet (GLDeepCopy)

- (instancetype)GLDeepCopy
{
    NSMutableSet *resultMutableSet = [[NSMutableSet alloc] initWithCapacity:self.count];
    
    for (id object in self) {
        id copyObject = nil;
        if ([object respondsToSelector:@selector(GLDeepCopy)]) {
            copyObject = [object GLDeepCopy];
        } else if ([object conformsToProtocol:@protocol(NSCopying)]) {
            copyObject = [object copy];
        } else {
            copyObject = object;
        }
        
        [resultMutableSet addObject:copyObject];
    }
    
    if ([self isKindOfClass:[NSMutableSet class]]) {
        return resultMutableSet;
    } else {
        return [NSSet setWithSet:resultMutableSet];
    }
}

@end
