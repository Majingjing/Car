//
//  morosManger.m
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "morosManger.h"

#import "morosModel.h"

#import "SYHNetTools.h"


static morosManger *manger = nil;

@implementation morosManger

+(instancetype)shareInstanceMsclecy{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manger = [morosManger new];
    });
    
    return manger;
}

-(NSMutableArray *)msArr{
    
    if (!_msArr) {
        
        _msArr = [NSMutableArray array];
    }
    
    return _msArr;
    
}


-(void)requestMscycleWithUrl:(NSString *)url didFinsn:(void(^)())finish{
    
       [self.msArr removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [SYHNetTools   SolveDataWithUrl:url HTTpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
            
            NSArray *mArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *dict in mArr) {
                
                morosModel *modle = [[morosModel alloc] init];
                
                [modle setValuesForKeysWithDictionary:dict];
                
                [self.msArr addObject:modle];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               
                finish();
            });
            
        }];
    });
}

-(NSInteger)countMsOfArray{
    
    return self.msArr.count;
    
}


-(morosModel *)modelMsWithIndex:(NSInteger)index{
    
    morosModel *model = self.msArr[index];
    
    return model;
    
}



@end
