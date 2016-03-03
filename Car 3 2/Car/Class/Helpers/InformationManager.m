//
//  InformationManager.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "InformationManager.h"
#import "InformationModel.h"
static InformationManager *manager;
@implementation InformationManager


+(instancetype)shareInstance  {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [InformationManager new];
    });
    return manager;
}

-(NSMutableArray *)Modelarr {
    if (_Modelarr == nil) {
        _Modelarr = [NSMutableArray array];
    }
    return _Modelarr;
}






-(void)solve:(NSString *)urlStr finish:(void (^)(NSMutableArray *arr))finish {
    [self.Modelarr removeAllObjects];
    NSLog(@"%@", urlStr);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            InformationModel *model = [[InformationModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.Modelarr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(self.Modelarr);
        });
        
 
    });
   }


@end
