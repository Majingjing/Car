//
//  moroManger.m
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "moroManger.h"

#import "SYHNetTools.h"

#import "moroModel.h"


static moroManger *manger = nil;

@implementation moroManger

+(instancetype)shareInstanceMotorcycle{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [moroManger new];
        
    });
    return manger;
    
}

// 对数组进行懒加载

-(NSMutableArray *)morocleArr{
    
    if (!_morocleArr) {
        
        _morocleArr = [NSMutableArray array];
    }
    
    return _morocleArr;
    
}

-(void)requestMotocleWithUrl:(NSString *)url didFinsn:(void (^)())finish{
    
    // 创建子线程用来请求数据
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [SYHNetTools SolveDataWithUrl:url HTTpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
            
            NSArray  *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (NSDictionary *dict in arr) {
                
                moroModel *model = [[moroModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.morocleArr addObject:model];
            }
            NSLog(@"%@", self.morocleArr);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                finish();
            });
            
        }];
        
    });
    
}

-(NSInteger)countOfArray{
    
    return self.morocleArr.count;
    
}

-(moroModel *)modelWithIndex:(NSInteger)index{
    
    moroModel *model = self.morocleArr[index];
    
    return model;
    
    
}


@end
