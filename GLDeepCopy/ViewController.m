//
//  ViewController.m
//  GLDeepCopy
//
//  Created by 高磊 on 2017/8/15.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "ViewController.h"

#import "PersonModel.h"
#import "Anima.h"

#import "NSArray+GLDeepCopy.h"
#import "NSDictionary+GLDeepCopy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
    //=============非集合类测试==================
    //非集合类测试copy 和 mutablecopy
    NSString *string = @"abc";
    NSString *copyString = [string copy];
    //mutableCopy 后位动态string
    NSString *mutableCopyString = [string mutableCopy];
    
    NSString *mutableCopy_copy_String = [mutableCopyString copy];
    NSMutableString *mutableCopy_mutable_copy_String = [mutableCopyString mutableCopy];
    
    NSLog(@" 打印信息:%p---%p---%p---%p---%p",string,copyString,mutableCopyString,mutableCopy_copy_String,mutableCopy_mutable_copy_String);
    
    */

    
    
    //===============字典测试===================
    Anima *anima = [[Anima alloc] init];
    anima.address = @"四川-成都";
    NSDictionary *dic = @{@"key1":@"abc",@"key2":@"cde",@"key3":anima};
    NSMutableDictionary *copyDic = [dic mutableCopy];
    
    NSMutableDictionary *copy_dic = [NSMutableDictionary dictionaryWithDictionary:copyDic];
    NSMutableDictionary *deepCopyDic = [NSMutableDictionary dictionaryWithDictionary:[dic GLDeepCopy]];
    
    NSLog(@" 打印信息dic:%p+%@ \n copyDic:%p+%@\n copy_dic:%p+%@\n deepCopyDic:%p+%@",dic,dic,copyDic,copyDic,copy_dic,copy_dic,deepCopyDic,deepCopyDic);
    
    
    
    //================数组测试==================
    /*
    //测试加入数组中  对数组进行拷贝
    PersonModel *new_PersonModel = [[PersonModel alloc] init];
    new_PersonModel.name = @"gaogaogao";
    new_PersonModel.age = 20;
    Anima *anima = [[Anima alloc] init];
    anima.address = @"成都";
    new_PersonModel.array = [NSMutableArray arrayWithObject:anima];
    [new_PersonModel.array addObject:@[@"1",@"2",@"3"]];
    
        
    NSArray *array = [NSArray arrayWithObject:new_PersonModel];
    NSArray *copyArray = [array copy];
    NSMutableArray *mutableCopyArray = [NSMutableArray arrayWithArray:[array GLDeepCopy]];//[[NSMutableArray alloc] initWithArray:array copyItems:YES];//[array mutableCopy];//
    
    NSLog(@" 打印信息array:%p+%@ + %p\ncopyArray:%p+%@ + %p\nmutableCopyArray:%p+%@ + %p",array,array,array[0],copyArray,copyArray,copyArray[0],mutableCopyArray,mutableCopyArray,mutableCopyArray[0]);
    
    
    
    //修改数组中的内容
    PersonModel *personModel_array = array[0];
    personModel_array.name = @"gao_修改";
    personModel_array.age = 24;
    
    Anima *anima_model = personModel_array.array[0];
    anima_model.address = @"阆中";
    
    //获取深拷贝数组中的model中数组中的model
    PersonModel *personModel_mutable_copy_array = mutableCopyArray[0];
    Anima *anima_model_mutable_copy = personModel_mutable_copy_array.array[0];
    
    NSLog(@" 打印信息获取深拷贝数组中的model中数组中的model地址:\n原数组中的PersonModel中Array中的Anima：%p \n 原数组中的PersonModel中Array中的非Anima对象%p\n++ 深拷贝数组中的PersonModel中Array中的Anima：%p \n 深拷贝数组中的PersonModel：%p \n+ 深拷贝数组中的PersonModel中Array中的非Anima对象%p",anima_model,personModel_array.array[1],anima_model_mutable_copy,personModel_mutable_copy_array,personModel_mutable_copy_array.array[1]);
    
    
    NSLog(@" 打印信息修改后array:%p+%@\ncopyArray:%p+%@\nmutableCopyArray:%p+%@",array,array,copyArray,copyArray,mutableCopyArray,mutableCopyArray);
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
