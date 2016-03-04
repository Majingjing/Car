//
//  moroManger.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>

@class moroModel;

@interface moroManger : NSObject

@property (nonatomic,strong)NSMutableArray *morocleArr;


#pragma mark ---  此单例用来对车型页面进行处理

+(instancetype)shareInstanceMotorcycle;

-(void)requestMotocleWithUrl:(NSString *)url didFinsn:(void(^)())finish;

-(NSInteger)countOfArray;

-(moroModel *)modelWithIndex:(NSInteger)index;



@end
