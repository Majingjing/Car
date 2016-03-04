//
//  moroModel.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moroModel : NSObject

// 车的标志
@property (nonatomic,copy)NSString *logo;

// 车名
@property (nonatomic,copy)NSString *brandName;

// 属性传值
@property (nonatomic,assign)NSInteger  brandId;

@end
