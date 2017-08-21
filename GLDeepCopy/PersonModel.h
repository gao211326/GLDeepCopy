//
//  PersonModel.h
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/18.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCopying,NSMutableCopying>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSUInteger age;

@property (nonatomic,strong) NSMutableArray *array;

@end
