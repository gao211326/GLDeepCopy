//
//  PersonModel.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/18.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "PersonModel.h"
#import "NSArray+GLDeepCopy.h"
#import <objc/runtime.h>

@interface PersonModel()


@end

@implementation PersonModel


/**
 描述信息
 
 @return 返回描述信息  利于我们在debug 的时候方便查看
 */
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self getObjectData:self]];
}


#pragma mark == Copying协议
- (id)copyWithZone:(NSZone *)zone{
    PersonModel *copy = [[PersonModel alloc] init];
    
    if (copy) {
        
        copy.name = [self.name copyWithZone:zone];
        copy.age = self.age;
        copy.array = [self.array copyWithZone:zone];
    }
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    PersonModel *copy = [[PersonModel alloc] init];
    
    if (copy) {
        
        copy.name = [self.name mutableCopyWithZone:zone];
        copy.age = self.age;
        copy.array = [self.array mutableCopyWithZone:zone];
    }
    return copy;
}


#pragma mark == 深拷贝 
//（如果没有集合类型，可以不用执行）
- (id)GLDeepCopy
{
    PersonModel *personModel = [[PersonModel alloc] init];
    personModel.age = self.age;
    personModel.name = [self.name copy];
    personModel.array = [self.array GLDeepCopy];
    
    return personModel;
}

#pragma mark == 转换

/**
 将对象转为NSDictionary
 
 @param obj 对象
 @return 返回的NSDictionary
 */
- (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        
        [dic setObject:value forKey:propName];
    }
    return dic;
}


/**
 针对对象里面属性的不同属性 进行转换
 
 @param obj 对象
 @return 返回
 */
- (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
