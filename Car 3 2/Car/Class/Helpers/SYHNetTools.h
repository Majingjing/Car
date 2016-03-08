//
//  SYHNetTools.h
//  SYHSingPerson
//
//  Created by 史燕红 on 16/1/25.
//  Copyright © 2016年 shiyanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  <UIKit/UIKit.h>

typedef void(^DataBlock)(NSData *data);
typedef void(^ImageSolveBlock)(UIImage *image);
typedef void(^JsonBlock)(NSData *data);


@interface SYHNetTools : NSObject

// 封装的旧方法  轮播图的操作
+ (void)solveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block;


// 封装的新方法
// 如果是解析
+ (void)SolveDataWithUrl:(NSString *)stringUrl HTTpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(JsonBlock)block;


// 如果是下载图片
+ (void)SessionDownLoadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block;





@end
