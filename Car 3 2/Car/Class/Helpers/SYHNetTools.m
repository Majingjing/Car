//
//  SYHNetTools.m
//  SYHSingPerson
//
//  Created by 史燕红 on 16/1/25.
//  Copyright © 2016年 shiyanhong. All rights reserved.
//

#import "SYHNetTools.h"

@implementation SYHNetTools

+ (void)solveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block {
    NSURL *url = [NSURL URLWithString:StringUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 将所有的字母转换成大写
    NSString *SMethod = [method uppercaseString];
    
    if ([@"POST" isEqualToString:SMethod]) {
        [request setHTTPMethod:SMethod];
        NSData *bodyData = [StringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
        
    } else if ([@"GET" isEqualToString:SMethod]) {
        
    } else {
        @throw [NSException exceptionWithName:@"DAG Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    // 发送请求  拿到Data
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
        
    }];
    
}

#pragma mark -- 分装的新方法 解析数据
+ (void)SolveDataWithUrl:(NSString *)stringUrl HTTpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(JsonBlock)block {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *Smethod = method;
    if ([@"POST" isEqualToString:Smethod]) {
        [request setHTTPMethod:@"POST"];
        NSData *data1 = [StringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data1];
        
    } else if ([@"GET" isEqualToString:Smethod]) {
        
    } else {
        @throw [NSException exceptionWithName:@"DAG Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data);
    }];
    [task resume];
    
}


#pragma mark -- 分装方法  单纯的请求图片
+ (void)SessionDownLoadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block {
    // 创建URL
    NSURL *url = [NSURL URLWithString:stringUrl];
    // 创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    // 创建任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *ImageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:ImageData];
        // 从子线程回到主线程进行界面更新
        // iOS界面的更新只能在主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image);
        });
        
    }];
    [task resume];
    
    
    
}




@end
