//
//  InformationManager.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "InformationManager.h"
#import "InformationModel.h"
#import "ChaiCheModel.h"
#import "PictureModel.h"
#import "DetailModel.h"
#import "ChaiCheVideoModel.h"
#import "ChaiDetailModel.h"

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


//拆车解析
-(void)chaiCheSolve:(NSString *)urlStr finish:(void (^)(NSMutableArray *arr))finish{
    NSMutableArray *array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:urlStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            ChaiCheModel *model = [[ChaiCheModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(array);
        });
    });
}

// 拆车页视频解析
-(void)chaiCheVideoSolve:(NSString *)urlStr
                  finish:(void (^)(NSMutableArray *arr))finish{
    NSMutableArray *array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:urlStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            ChaiCheVideoModel *model = [[ChaiCheVideoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(array);
        });
    });
    
}
// 拆车视频详情
-(void)chaiCheVideoDetailSolve:(NSString *)urlStr
                        finish:(void (^)(ChaiDetailModel *model))finish{
    ChaiDetailModel *model = [[ChaiDetailModel alloc] init];
    NSURL *url = [NSURL URLWithString:urlStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            [model setValuesForKeysWithDictionary:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(model);
        });
    });
}

//图片页解析
- (void)pictureSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish {
    [self.Modelarr removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            PictureModel *model = [[PictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.Modelarr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(self.Modelarr);
        });
    });
}

//图片详情解析
- (void)detailSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish {
    [self.Modelarr removeAllObjects];
    NSLog(@"urlstr = %@", urlStr);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@", model.bigImagePath);
            [self.Modelarr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(self.Modelarr);
        });
    });
}

@end
