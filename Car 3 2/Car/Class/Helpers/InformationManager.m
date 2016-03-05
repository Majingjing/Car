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

-(NSMutableArray *)pictureArr {
    if (_pictureArr == nil) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr;
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
    [self.pictureArr removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.pictureArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(self.pictureArr);
        });
    });
}

//返回图片页model的albumID
- (NSInteger)modelIDbyIndex:(NSInteger)index {
    PictureModel *model = self.Modelarr[index];
    return model.albumId;
}





@end
