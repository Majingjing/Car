//
//  InformationManager.h
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationManager : NSObject

@property (nonatomic, strong)NSMutableArray *Modelarr;
+ (instancetype)shareInstance;


- (void)solve:(NSString *)urlStr
       finish:(void (^)(NSMutableArray *arr))finish;



// 拆车页解析
- (void)chaiCheSolve:(NSString *)urlStr
       finish:(void (^)(NSMutableArray *arr))finish;

//图片页解析
- (void)pictureSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish;

//图片详情解析
- (void)detailSolve:(NSString *)urlStr
              finish:(void(^)(NSMutableArray *arr))finish;
@end
