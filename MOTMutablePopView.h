//
//  MOTMutablePopView.h
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOTPopConfig.h"

typedef void(^clickBlock)(NSUInteger index);

@interface MOTMutablePopView : UIView

+(void)popWithConfig:(nonnull MOTPopConfig*) config ClickIndexBlock:(nullable clickBlock) clickBlock;

@end
