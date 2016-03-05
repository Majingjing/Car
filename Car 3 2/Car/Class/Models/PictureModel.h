//
//  PictureModel.h
//  Car
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject
@property (nonatomic, copy)NSString *albumName;
@property (nonatomic, copy)NSString *imagePath;
@property (nonatomic, assign)NSInteger picNumber;
@property (nonatomic, copy)NSString *wapURL;
@property (nonatomic, assign)NSInteger albumId;
@end
