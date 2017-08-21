//
//  Anima.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/18.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "Anima.h"

@interface Anima ()



@end

@implementation Anima

- (id)copyWithZone:(NSZone *)zone{
    Anima *copy = [[Anima alloc] init];
    
    if (copy) {
        copy.address = [self.address copyWithZone:zone];
    }
    return copy;
}


@end
