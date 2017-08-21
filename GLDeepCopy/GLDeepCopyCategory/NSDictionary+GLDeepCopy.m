//
//  NSDictionary+GLDeepCopy.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/18.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "NSDictionary+GLDeepCopy.h"

@implementation NSDictionary (GLDeepCopy)

- (instancetype)GLDeepCopy{
    NSMutableDictionary *resultMutableDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    for (id key in self.allKeys) {
        id copyObject = nil;
        id object = [self objectForKey:key];
        if ([object respondsToSelector: @selector(GLDeepCopy)]) {

            copyObject = [object GLDeepCopy];
        } else if ([object conformsToProtocol:@protocol(NSCopying)]) {

            copyObject = [object copy];
        } else {
            copyObject = object;
        }
        
        [resultMutableDict setObject:copyObject forKey:key];
    }
    
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        return resultMutableDict;
    } else {
        return [NSDictionary dictionaryWithDictionary:resultMutableDict];
    }
}
@end
