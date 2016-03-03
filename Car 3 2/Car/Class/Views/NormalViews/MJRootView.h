//
//  MJRootView.h
//  Car
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol jumpDelegate <NSObject>

- (void)jumpAction:(NSInteger)tag;

@end

@interface MJRootView : UIView

@property (nonatomic, assign) id<jumpDelegate>delegate;


+ (instancetype)shareInstance;
@end
