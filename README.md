# MOTMutablePopView
这是一个可以自定义PopView各种属性的极简控件
### 第一步：创建一个config实例
```Object-C
@property (strong, nonatomic) MOTPopConfig *config;
self.config = [MOTPopConfig new];
```
### 第二步:设置config中你所需要自定义的属性
```Object-C
self.config.size = CGSizeMake(60, 100);
self.config.targetView = self.button;
self.config.isAuto = NO;
self.config.tabColor = [UIColor blackColor];
```
### 第三步：添加自定义的选项卡
```Object-C
UILabel *label1 = [UILabel new];
label1.textColor = [UIColor whiteColor];
label1.text = [NSString stringWithFormat:@"%d", _i];
label1.textAlignment = NSTextAlignmentCenter;   
[self.config addView:label1];    
```
### 最后一步：将你需要触发点击事件的地方进行显示
```Object-C
- (IBAction)click:(id)sender {
    __weak typeof(self) mySelf = self;
    [MOTMutablePopView popWithConfig:self.config ClickIndexBlock:^(NSUInteger index) {
        mySelf.showLabel.text = [NSString stringWithFormat:@"选择了第%lu个", (unsigned long)index];
    }];
}
```
![image](https://github.com/baoenzhao/MOTMutablePopView/blob/master/testPop.gif)
