//
//  MOTPopConfig.m
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import "MOTPopConfig.h"

@interface MOTPopConfig ()

@property (strong, nonatomic) NSMutableArray *mutableArray;

@end

@implementation MOTPopConfig

#pragma mark -懒加载
-(NSMutableArray *)mutableArray {
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    
    return _mutableArray;
}

#pragma mark -系统
-(instancetype)init {
    if (self = [super init]) {
        [self setDefault];
    }
    
    return self;
}

#pragma mark -set方法

#pragma mark -get方法
-(NSArray<UIView *> *)views {
    return self.mutableArray;
}

#pragma mark -初始化
-(void)setDefault {
    self.tabColor = [UIColor lightGrayColor];
    self.popDirection = MOTPopVertical;
    self.arrowDirection = MOTArrowUp;
    self.inScreenAuto = YES;
    self.cornerRadius = 5.0f;
    self.arrowWidth = 20.0f;
    self.arrowheight = 10.0f;
    self.inset = 0;
    self.screenInset = 10;
}

#pragma mark -公共
-(void)addView:(UIView *)view {
    [self.mutableArray addObject:view];
}
-(void)removeTabWithIndex:(NSUInteger)index {
    if (index < self.mutableArray.count) {
        [self.mutableArray removeObjectAtIndex:index];
    }
}
-(void)removeAllTab {
    [self.mutableArray removeAllObjects];
}

#pragma mark -销毁
-(void)dealloc {
    NSLog(@"MOTPopConfig销毁了");
}

@end
