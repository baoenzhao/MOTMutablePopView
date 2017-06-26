//
//  MOTMutablePopView.m
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import "MOTMutablePopView.h"

@interface MOTMutablePopView () {
    CGFloat _h_mid_y;//横向的中间坐标
    CGFloat _h_pop_x;//横向的popx坐标
    
    CGRect _screenFrame;//目标控件的屏幕位置
}

@property (copy, nonatomic) clickBlock clickBlock;
@property (strong, nonatomic) MOTPopConfig *config;
@property (assign, nonatomic) CGRect viewFrame;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *line;//用来遮盖boder的多出来的边

@end

@implementation MOTMutablePopView

#pragma mark -宏
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark -懒加载

#pragma mark -系统
-(instancetype)init {
    if (self = [super init]) {
        [self setDefault];
    }
    
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isEqual:self]) {
        [self hidAlert];
    }
}
-(void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (self.config.popDirection == MOTPopVertical) {
        if (self.config.arrowDirection == MOTArrowUp) {
            if (self.config.isAuto) {
                [path moveToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                [path addLineToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f, self.viewFrame.origin.y - self.config.arrowheight)];
                [path addLineToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                [self.config.tabColor setFill];
                [path fill];
            }
            else {
                if (self.config.vX) {
                    [path moveToPoint:CGPointMake(self.config.vX - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                    [path addLineToPoint:CGPointMake(self.config.vX, self.viewFrame.origin.y - self.config.arrowheight)];
                    [path addLineToPoint:CGPointMake(self.config.vX + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                    [self.config.tabColor setFill];
                    [path fill];
                }
                else {
                    [path moveToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                    [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f, self.viewFrame.origin.y - self.config.arrowheight)];
                    [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
                    [self.config.tabColor setFill];
                    [path fill];
                }
            }
            
        }
        else if (self.config.arrowDirection == MOTArrowDown) {
            if (self.config.isAuto) {
                [path moveToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                [path addLineToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height + self.config.arrowheight)];
                [path addLineToPoint:CGPointMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                [self.config.tabColor setFill];
                [path fill];
            }
            else {
                if (self.config.vX) {
                    [path moveToPoint:CGPointMake(self.config.vX - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                    [path addLineToPoint:CGPointMake(self.config.vX, self.viewFrame.origin.y + self.viewFrame.size.height + self.config.arrowheight)];
                    [path addLineToPoint:CGPointMake(self.config.vX + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                    [self.config.tabColor setFill];
                    [path fill];
                }
                else {
                    [path moveToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                    [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height + self.config.arrowheight)];
                    [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
                    [self.config.tabColor setFill];
                    [path fill];
                }
            }
        }
    }
    else if (self.config.popDirection == MOTPopHorizontal) {
        if (self.config.arrowDirection == MOTArrowLeft) {
            [path moveToPoint:CGPointMake(_h_pop_x, _h_mid_y - self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x - self.config.arrowheight, _h_mid_y)];
            [path addLineToPoint:CGPointMake(_h_pop_x, _h_mid_y + self.config.arrowWidth / 2.0f)];
            [self.config.tabColor setFill];
            [path fill];
            
        }
        else if (self.config.arrowDirection == MOTArrowRight) {
            [path moveToPoint:CGPointMake(_h_pop_x + self.config.size.width, _h_mid_y - self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x + self.config.size.width + self.config.arrowheight, _h_mid_y)];
            [path addLineToPoint:CGPointMake(_h_pop_x + self.config.size.width, _h_mid_y + self.config.arrowWidth / 2.0f)];
            [self.config.tabColor setFill];
            [path fill];
        }
    }
    
}


#pragma mark -set方法
-(void)setConfig:(MOTPopConfig *)config {
    _config = config;
    
    self.imageView = [UIImageView new];
    self.imageView.alpha = 0.0f;
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.frame = [self judgePopViewFrameWithView:config.targetView];
    self.viewFrame = self.imageView.frame;
    self.imageView.image = config.backgroundImage;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = config.cornerRadius;
    if (config.cornerRadius == 0.0f) {
        self.imageView.clipsToBounds = NO;
    }
    self.imageView.layer.shadowOffset = config.shadowOffset;
    self.imageView.layer.shadowOpacity = config.shadowOpacity;
    self.imageView.layer.shadowColor = config.shadowColor.CGColor;
    self.imageView.layer.shadowRadius = config.shadowRadius;
    
    self.imageView.backgroundColor = config.tabColor;
    
    [self addSubview:self.imageView];
    
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        mySelf.imageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
    
    
    for (int i = 0; i < config.views.count; i++) {
        UIView *tabView = config.views[i];
        tabView.frame = CGRectMake(0, i * (config.size.height / config.views.count), config.size.width, config.size.height / config.views.count);
        tabView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTabView:)];
        tabView.tag = i;
        [tabView addGestureRecognizer:tap];
        [self.imageView addSubview:tabView];
    }
}

#pragma mark -初始化
-(void)setDefault {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.userInteractionEnabled = YES;
}

#pragma mark -约束
-(void)addPopViewLayoutConstraint:(MOTMutablePopView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [[UIApplication sharedApplication].keyWindow addConstraints:@[left, right, top, bottom]];
}

#pragma mark -私有
//隐藏
-(void)hidAlert {
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        mySelf.imageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [mySelf removeFromSuperview];
    }];
    
}
//获取view的屏幕相对坐标
-(CGRect)getScreenFramWithView:(UIView*) view {
    CGRect rect = [view convertRect:view.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    return rect;
}
-(CGRect)judgePopViewFrameWithView:(UIView*) view{
    _screenFrame = [self getScreenFramWithView:view];
    CGFloat midHeight = self.config.size.height / (self.config.views.count == 0 || self.config.views.count == 1 ? 2.0f : 2.0f * self.config.views.count);
    CGRect rect;
    
    //不进行越界问题判断，不保证在屏幕内
    if (!self.config.inScreenAuto) {
        if (self.config.arrowDirection == MOTArrowUp && self.config.popDirection == MOTPopVertical) {
            _screenFrame = CGRectMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f - self.config.size.width / 2.0f, _screenFrame.origin.y, _screenFrame.size.width, _screenFrame.size.height);
            //屏幕左边
            if (_screenFrame.origin.x <= kScreenWidth / 2.0f) {
                rect = [self getVertical_LeftTopRectWtihRect:rect];
            }
            //屏幕右边
            else if (_screenFrame.origin.x > kScreenWidth / 2.0f) {
                rect = [self getVertical_RightTopRectWtihRect:rect];
            }
        }
        else if (self.config.arrowDirection == MOTArrowDown && self.config.popDirection == MOTPopVertical) {
            _screenFrame = CGRectMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f - self.config.size.width / 2.0f, _screenFrame.origin.y, _screenFrame.size.width, _screenFrame.size.height);
            //屏幕左边
            if (_screenFrame.origin.x <= kScreenWidth / 2.0f) {
                rect = [self getVertical_LeftDownRectWtihRect:rect];
            }
            //屏幕右边
            else if (_screenFrame.origin.x > kScreenWidth / 2.0f) {
                rect = [self getVertical_RightDownRectWtihRect:rect];
            }
        }
        else if (self.config.arrowDirection == MOTArrowLeft && self.config.popDirection == MOTPopHorizontal) {
            //屏幕上边
            if (_screenFrame.origin.y <= kScreenHeight / 2.0f) {
                rect = [self getHorizontal_LeftTopRectWtihRect:rect MidHeight:midHeight];
            }
            //屏幕下边
            else if (_screenFrame.origin.y > kScreenHeight / 2.0f) {
                rect = [self getHorizontal_LeftDownRectWtihRect:rect MidHeight:midHeight];
            }
        }
        else if (self.config.arrowDirection == MOTArrowRight && self.config.popDirection == MOTPopHorizontal) {
            //屏幕上边
            if (_screenFrame.origin.y <= kScreenHeight / 2.0f) {
                rect = [self getHorizontal_RightTopRectWtihRect:rect MidHeight:midHeight];
            }
            //屏幕下边
            else if (_screenFrame.origin.y > kScreenHeight / 2.0f) {
                rect = [self getHorizontal_RightDownRectWtihRect:rect MidHeight:midHeight];
            }
        }
        else {
            rect = [self getInScreenAutoFunctionWithRect:rect MidHeight:midHeight];
        }
    }
    //进行越界问题判断，永远在屏幕内
    else {
        rect = [self getInScreenAutoFunctionWithRect:rect MidHeight:midHeight];
    }

    _h_pop_x = rect.origin.x;
    
    return rect;
}
-(CGRect)judgeLefToRect:(CGRect) rect{
    //超过屏幕左侧
    if (rect.origin.x < 0) {
        rect = CGRectMake(self.config.screenInset, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeRightToRect:(CGRect) rect{
    //超过屏幕右侧
    if (rect.origin.x + rect.size.width > kScreenWidth) {
        rect = CGRectMake(kScreenWidth - rect.size.width - self.config.screenInset, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeTopToRect:(CGRect) rect{
    //超过屏幕上侧
    if (rect.origin.y < 0) {
        rect = CGRectMake(rect.origin.x, self.config.screenInset, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeBottomToRect:(CGRect) rect {
    //超过屏幕下侧
    if (rect.origin.y + rect.size.height > kScreenHeight) {
        rect = CGRectMake(rect.origin.x, kScreenHeight - rect.size.height - self.config.screenInset, rect.size.width, rect.size.height);
    }
    
    return rect;
}

//获取竖向左上角的frame
-(CGRect)getVertical_LeftTopRectWtihRect:(CGRect) rect {
    rect = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height + self.config.arrowheight + self.config.inset, self.config.size.width, self.config.size.height);
    rect = [self judgeLefToRect:rect];
    
    return rect;
}
//获取竖向右上角的frame
-(CGRect)getVertical_RightTopRectWtihRect:(CGRect) rect{
    rect = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height + self.config.arrowheight + self.config.inset, self.config.size.width, self.config.size.height);
    rect = [self judgeRightToRect:rect];
    
    return rect;
}

//获取竖向左下角的frame
-(CGRect)getVertical_LeftDownRectWtihRect:(CGRect) rect{
    rect = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y - self.config.size.height - self.config.arrowheight - self.config.inset, self.config.size.width, self.config.size.height);
    rect = [self judgeLefToRect:rect];
    
    return rect;
}

//获取竖向右下角的frame
-(CGRect)getVertical_RightDownRectWtihRect:(CGRect) rect{
    rect = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y - self.config.size.height - self.config.arrowheight - self.config.inset, self.config.size.width, self.config.size.height);
    rect = [self judgeRightToRect:rect];
    self.config.arrowDirection = MOTArrowDown;
    
    return rect;
}

//获取横向左上角的frame
-(CGRect)getHorizontal_LeftTopRectWtihRect:(CGRect) rect MidHeight:(CGFloat) midHeight {
    _screenFrame = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height / 2.0f - midHeight, _screenFrame.size.width, _screenFrame.size.height);
    rect = CGRectMake(_screenFrame.origin.x + _screenFrame.size.width + self.config.arrowheight + self.config.inset, _screenFrame.origin.y, self.config.size.width, self.config.size.height);
    rect = [self judgeTopToRect:rect];
    _h_mid_y = rect.origin.y + midHeight;
    
    return rect;
}
//获取横向右上角的frame
-(CGRect)getHorizontal_RightTopRectWtihRect:(CGRect) rect MidHeight:(CGFloat) midHeight {
    _screenFrame = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height / 2.0f - midHeight, _screenFrame.size.width, _screenFrame.size.height);
    rect = CGRectMake(_screenFrame.origin.x - self.config.size.width - self.config.arrowheight - self.config.inset, _screenFrame.origin.y, self.config.size.width, self.config.size.height);
    rect = [self judgeTopToRect:rect];
    _h_mid_y = rect.origin.y + midHeight;
    
    return rect;
}

//获取横向左下角的frame
-(CGRect)getHorizontal_LeftDownRectWtihRect:(CGRect) rect MidHeight:(CGFloat) midHeight {
    _screenFrame = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height / 2.0f - self.config.size.height + midHeight, _screenFrame.size.width, _screenFrame.size.height);
    rect = CGRectMake(_screenFrame.origin.x + _screenFrame.size.width + self.config.arrowheight + self.config.inset, _screenFrame.origin.y, self.config.size.width, self.config.size.height);
    rect = [self judgeBottomToRect:rect];
    _h_mid_y = rect.origin.y + rect.size.height - midHeight;
    
    return rect;
}

//获取横向右下角的frame
-(CGRect)getHorizontal_RightDownRectWtihRect:(CGRect) rect MidHeight:(CGFloat) midHeight {
    _screenFrame = CGRectMake(_screenFrame.origin.x, _screenFrame.origin.y + _screenFrame.size.height / 2.0f - self.config.size.height + midHeight, _screenFrame.size.width, _screenFrame.size.height);
    rect = CGRectMake(_screenFrame.origin.x - self.config.size.width - self.config.arrowheight - self.config.inset, _screenFrame.origin.y, self.config.size.width, self.config.size.height);
    rect = [self judgeBottomToRect:rect];
    _h_mid_y = rect.origin.y + rect.size.height - midHeight;
    
    return rect;
}

//进行越界判断的方法
-(CGRect)getInScreenAutoFunctionWithRect:(CGRect) rect MidHeight:(CGFloat) midHeight{
    if (self.config.popDirection == MOTPopVertical) {
        _screenFrame = CGRectMake(_screenFrame.origin.x + _screenFrame.size.width / 2.0f - self.config.size.width / 2.0f, _screenFrame.origin.y, _screenFrame.size.width, _screenFrame.size.height);
        //屏幕左上角
        if (_screenFrame.origin.x <= kScreenWidth / 2.0f && _screenFrame.origin.y <= kScreenHeight / 2.0f) {
            rect = [self getVertical_LeftTopRectWtihRect:rect];
            self.config.arrowDirection = MOTArrowUp;
        }
        //屏幕右上角
        else if (_screenFrame.origin.x > kScreenWidth / 2.0f && _screenFrame.origin.y <= kScreenHeight / 2.0f) {
            rect = [self getVertical_RightTopRectWtihRect:rect];
            self.config.arrowDirection = MOTArrowUp;
        }
        //屏幕左下角
        else if (_screenFrame.origin.x <= kScreenWidth / 2.0f && _screenFrame.origin.y > kScreenHeight / 2.0f) {
            rect = [self getVertical_LeftDownRectWtihRect:rect];
            self.config.arrowDirection = MOTArrowDown;
        }
        //屏幕右下角
        else {
            rect = [self getVertical_RightDownRectWtihRect:rect];
            self.config.arrowDirection = MOTArrowDown;
        }
    }
    else {
        //屏幕左上角
        if (_screenFrame.origin.x <= kScreenWidth / 2.0f && _screenFrame.origin.y <= kScreenHeight / 2.0f) {
            rect = [self getHorizontal_LeftTopRectWtihRect:rect MidHeight:midHeight];
            self.config.arrowDirection = MOTArrowLeft;
        }
        //屏幕右上角
        else if (_screenFrame.origin.x > kScreenWidth / 2.0f && _screenFrame.origin.y < kScreenHeight / 2.0f) {
            rect = [self getHorizontal_RightTopRectWtihRect:rect MidHeight:midHeight];
            self.config.arrowDirection = MOTArrowRight;
        }
        //屏幕左下角
        else if (_screenFrame.origin.x <= kScreenWidth / 2.0f && _screenFrame.origin.y >= kScreenHeight / 2.0f) {
            rect = [self getHorizontal_LeftDownRectWtihRect:rect MidHeight:midHeight];
            self.config.arrowDirection = MOTArrowLeft;
        }
        //屏幕右下角
        else if (_screenFrame.origin.x > kScreenWidth / 2.0f && _screenFrame.origin.y > kScreenHeight / 2.0f) {
            rect = [self getHorizontal_RightDownRectWtihRect:rect MidHeight:midHeight];
            self.config.arrowDirection = MOTArrowRight;
        }
    }

    return rect;
}


#pragma mark -公共
+(void)popWithConfig:(MOTPopConfig *)config ClickIndexBlock:(clickBlock)clickBlock {
    MOTMutablePopView *popView = [self new];
    popView.config = config;
    popView.clickBlock = clickBlock;
    
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    [popView addPopViewLayoutConstraint:popView];
}

#pragma mark -点击事件
-(void)tapTabView:(UITapGestureRecognizer*) gr {
    
    if (self.clickBlock) {
        self.clickBlock(gr.view.tag);
    }
    
    [self hidAlert];
}

#pragma mark -销毁
-(void)dealloc {
    NSLog(@"MOTMutablePopView销毁了");
}

@end
