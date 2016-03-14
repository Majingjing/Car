//
//  ChaiCheVideoModel.m
//  Car
//
//  Created by jiabin on 16/3/7.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ChaiCheVideoModel.h"

@implementation ChaiCheVideoModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _Nid = value;
    }
}



@end
