//
//  morosModel.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface morosModel : NSObject

// 车的标志

@property (nonatomic,copy)NSString *imagePath;

// 车的名字

@property (nonatomic,copy)NSString *seriesName;

// 车的标价

@property (nonatomic,copy)NSString *guidePrice;

// 利用webView 进行加载
@property (nonatomic,copy)NSString *wapURL;

@end
