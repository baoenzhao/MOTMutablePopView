//
//  MOTPopConfig.h
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger) {
    MOTPopVertical,//竖向
    MOTPopHorizontal,//横向
}MOTPopDirection;//弹出框的走向

typedef NS_ENUM (NSInteger) {
    MOTArrowLeft,//箭头朝左，仅在横向时候有效
    MOTArrowRight,//箭头朝右，仅在横向时候有效
    MOTArrowUp,//箭头朝上，仅在竖向时候有效
    MOTArrowDown,//箭头朝下，仅在竖向时候有效
}MOTArrowDirection;//箭头的方向，如果与对应的走向不相符，则失效

@interface MOTPopConfig : NSObject

//选项卡颜色，默认颜色，灰色
@property (strong, nonatomic) UIColor *tabColor;
//背景图片
@property (strong, nonatomic) UIImage *backgroundImage;
//选项卡大小
@property (assign, nonatomic) CGSize size;
//弹出框的走向，默认为竖向
@property (assign, nonatomic) MOTPopDirection popDirection;

//保证在屏幕内，自动计算弹出框frame，默认YES
//如果为NO，弹出框可能会离屏
//当arrowDirection对应的popDirection不相符，则这个参数失效
@property (assign, nonatomic) BOOL inScreenAuto;
//inScreenAuto为NO时有效，确认箭头的方向，默认朝上
@property (assign, nonatomic) MOTArrowDirection arrowDirection;

//圆角，默认5
@property (assign, nonatomic) CGFloat cornerRadius;
//阴影
@property (assign, nonatomic) CGFloat shadowRadius;
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) float shadowOpacity;
@property (assign, nonatomic) CGSize shadowOffset;

//目标view，即是哪个view弹出菜单的
@property (weak, nonatomic) UIView *targetView;
//箭头宽高，默认宽20，高10
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowheight;

//箭头与目标之间的距离，默认为0
@property (assign, nonatomic) CGFloat inset;
//popView在超出屏幕时的极限间隔，默认为10
@property (assign, nonatomic) CGFloat screenInset;

//箭头自动选择位置，默认NO（POP_VERTICAL时有效）
@property (assign, nonatomic) BOOL isAuto;
//在POP_VERTICAL状态下，isAuto为NO时可以手动修改箭头的x指向坐标，但弹出框不变
//此属性主要用于在某些情况下自动计算箭头位置时，箭头未能指向目标控件所用
@property (assign, nonatomic) CGFloat vX;

//选项卡中以下标形式存在的选项数组
@property (strong, nonatomic, readonly) NSArray <UIView*>*views;

//添加选项
-(void)addView:(UIView*) view;

//删除特定下标的选项
-(void)removeTabWithIndex:(NSUInteger) index;

//删除所有选项
-(void)removeAllTab;

@end
