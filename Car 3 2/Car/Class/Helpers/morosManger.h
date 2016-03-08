//
//  morosManger.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>


@class morosModel;

@interface morosManger : NSObject


@property (nonatomic,strong)NSMutableArray *msArr;


+(instancetype)shareInstanceMsclecy;

-(void)requestMscycleWithUrl:(NSString *)url didFinsn:(void(^)())finish;

-(NSInteger)countMsOfArray;


-(morosModel *)modelMsWithIndex:(NSInteger)index;


@end
