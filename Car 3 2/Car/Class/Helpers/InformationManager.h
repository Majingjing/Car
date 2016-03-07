//
//  InformationManager.h
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChaiDetailModel;

@interface InformationManager : NSObject

@property (nonatomic, strong)NSMutableArray *Modelarr;
@property (nonatomic, strong)NSMutableArray *pictureArr;
+ (instancetype)shareInstance;


- (void)solve:(NSString *)urlStr
       finish:(void (^)(NSMutableArray *arr))finish;



// 拆车页解析
- (void)chaiCheSolve:(NSString *)urlStr
       finish:(void (^)(NSMutableArray *arr))finish;

// 拆车页视频解析
-(void)chaiCheVideoSolve:(NSString *)urlStr
                  finish:(void (^)(NSMutableArray *arr))finish;
// 拆车视频详情
-(void)chaiCheVideoDetailSolve:(NSString *)urlStr
                  finish:(void (^)(ChaiDetailModel *model))finish;

//图片页解析
- (void)pictureSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish;

//图片详情解析
- (void)detailSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish;


//返回图片页model的albumID
- (NSInteger)modelIDbyIndex:(NSInteger)index;



@end
