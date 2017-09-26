//
//  ChaoJiCaiTuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/11/8.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ChaoJiCaiTuVC.h"
#import "HMQuestion.h"

#define kButtonWidth    35
#define kButtonHeight   35
#define kButtonMargin   10
#define kTotolCol       7

@interface ChaoJiCaiTuVC ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionButton;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;


@property (nonatomic, strong) UIButton *cover;

@property (nonatomic, strong) NSArray *questions;

/** 题目索引 */
@property (nonatomic, assign) int index;
@end

@implementation ChaoJiCaiTuVC

- (NSArray *)questions
{
    if (_questions == nil) {
        _questions = [HMQuestion questions];
    }
    return _questions;
}

- (UIButton *)cover
{
    if (_cover == nil) {
        _cover = [[UIButton alloc] initWithFrame:self.view.bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.view addSubview:_cover];
        _cover.alpha = 0.0;
        
        [_cover addTarget:self action:@selector(bigImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index = -1;
    [self nextQuestion];
}

/** 调整状态栏颜色 */
/**
 UIStatusBarStyleDefault      黑色状态栏
 UIStatusBarStyleLightContent 亮色状态栏
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 大图小图切换
/**
 *  大图小图显示切换
 */
- (IBAction)bigImage
{
    // 如果没有放大，就放大，否则就缩小
    // 通过蒙板的alpha来判断按钮是否已经被放大
    if (self.cover.alpha == 0.0) { // 放大
        // 2. 将图像按钮弄到最前面
        // bringSubviewToFront将子视图前置
        [self.view bringSubviewToFront:self.iconButton];
        
        // 3. 动画放大图像按钮
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = w;
        CGFloat y = (self.view.bounds.size.height - h) * 0.5;
        
        [UIView animateWithDuration:1.0f animations:^{
            self.iconButton.frame = CGRectMake(0, y, w, h);
            self.cover.alpha = 1.0;
        }];
    } else { // 缩小
        [UIView animateWithDuration:1.0 animations:^{
            // 将图像恢复初始位置
            self.iconButton.frame = CGRectMake(85, 85, 150, 150);
            self.cover.alpha = 0.0;
        }];
    }
}

#pragma mark - 下一题
/**
 *  下一题目
 *
 *  主要的方法，尽量保留简洁的代码，主要体现思路和流程即可
 */
- (IBAction)nextQuestion
{
    // 1. 当前答题的索引，索引递增
    self.index++;
    
    // 如果index已经到最后一题，提示用户，播放动画，音乐.....
    if (self.index == self.questions.count) {
        NSLog(@"通关了");
        return;
    }
    
    // 2. 从数组中按照索引取出题目模型数据
    HMQuestion *question = self.questions[self.index];
    
    // 3. 设置基本信息
    [self setupBasicInfo:question];
    
    // 4. 设置答案按钮
    [self createAnswerButtons:question];
    
    // 5. 设置备选按钮
    [self createOptionButtons:question];
}

/** 设置基本信息 */
- (void)setupBasicInfo:(HMQuestion *)question
{
    self.noLabel.text = [NSString stringWithFormat:@"%d/%d", self.index + 1, self.questions.count];
    self.titleLabel.text = question.title;
    //    [self.iconButton setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    [self.iconButton setImage:question.image forState:UIControlStateNormal];
    
    // 如果到达最后一题，禁用下一题按钮
    self.nextQuestionButton.enabled = (self.index < self.questions.count - 1);
}

/** 创建答案区按钮 */
- (void)createAnswerButtons:(HMQuestion *)question
{
    // 首先清除掉答题区内的所有按钮
    // 所有的控件都继承自UIView，多态的应用
    for (UIView *btn in self.answerView.subviews) {
        [btn removeFromSuperview];
    }
    
    CGFloat answerW = self.answerView.bounds.size.width;
    int length = question.answer.length;
    CGFloat answerX = (answerW - kButtonWidth * length - kButtonMargin * (length - 1)) * 0.5;
    
    // 创建所有答案的按钮
    for (int i = 0; i < length; i++) {
        CGFloat x = answerX + i * (kButtonMargin + kButtonWidth);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, kButtonWidth, kButtonHeight)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置标题颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.answerView addSubview:btn];
        
        [btn addTarget:self action:@selector(answerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/** 创建备选区按钮 */
- (void)createOptionButtons:(HMQuestion *)question
{
    // 问题：每次调用下一题方法时，都会重新创建21个按钮
    // 解决：如果按钮已经存在，并且是21个，只需要更改按钮标题即可
    if (self.optionsView.subviews.count != question.options.count) {
        // 重新创建所有按钮
        for (UIView *view in self.optionsView.subviews) {
            [view removeFromSuperview];
        }
        
        CGFloat optionW = self.optionsView.bounds.size.width;
        CGFloat optionX = (optionW - kTotolCol * kButtonWidth - (kTotolCol - 1) * kButtonMargin) * 0.5;
        
        for (int i = 0; i < question.options.count; i++) {
            int row = i / kTotolCol;
            int col = i % kTotolCol;
            
            CGFloat x = optionX + col * (kButtonMargin + kButtonWidth);
            CGFloat y = row * (kButtonMargin + kButtonHeight);
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, kButtonWidth, kButtonHeight)];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [self.optionsView addSubview:btn];
            
            // 添加按钮监听方法
            [btn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSLog(@"创建候选按钮");
    }
    
    // 如果按钮已经存在，在点击下一题的时候，只需要设置标题即可
    int i = 0;
    //    // 让模型打乱数据，每次点击下一题的时候，都会乱序
    //    [question randamOptions];
    
    for (UIButton *btn in self.optionsView.subviews) {
        // 设置备选答案
        [btn setTitle:question.options[i++] forState:UIControlStateNormal];
        
        // 回复所有按钮的隐藏状态
        btn.hidden = NO;
        
        //        // 添加按钮监听方法
        // 提示，如果再次添加监听方法，意味着每次调用下一题的时候都会添加监听方法
        //        [btn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 候选按钮点击方法
/** 候选按钮点击 */
- (void)optionClick:(UIButton *)button
{
    // 1. 在答案区找到第一个文字为空的按钮
    UIButton *btn = [self firstAnswerButton];
    
    // 如果没有找到按钮=>所有的"答题按钮都有字"，直接返回
    if (btn == nil) {
        // 都有字判断胜负
    } else {
        // 2. 将button的标题设置给答案区的按钮
        [btn setTitle:button.currentTitle forState:UIControlStateNormal];
        
        // 3. 将button隐藏
        button.hidden = YES;
    }
    // 4. 判断结果
    [self judge];
}

/** 判断结果 */
- (void)judge
{
    // 如果四个按钮都有文字，才需要判断结果
    // 遍历所有答题区的按钮
    BOOL isFull = YES;
    NSMutableString *strM = [NSMutableString string];
    
    for (UIButton *btn in self.answerView.subviews) {
        if (btn.currentTitle.length == 0) {
            // 只要有一个按钮没有字
            isFull = NO;
            break;
        } else {
            // 有字，拼接临时字符串
            [strM appendString:btn.currentTitle];
        }
    }
    
    if (isFull) {
        NSLog(@"都有字");
        // 判断是否和答案一致
        // 根据self.index获得当前的question
        HMQuestion *question = self.questions[self.index];
        
        // 如果一致，进入下一题
        if ([strM isEqualToString:question.answer]) {
            NSLog(@"答对了");
            [self setAnswerButtonsColor:[UIColor blueColor]];
            
            // 增加分数
            [self changeScore:800];
            
            // 等待0.5秒，进入下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        } else {
            // 如果不一致，修改按钮文字颜色，提示用户
            NSLog(@"答错了");
            [self setAnswerButtonsColor:[UIColor redColor]];
        }
    }
}

/** 修改答题区按钮的颜色 */
- (void)setAnswerButtonsColor:(UIColor *)color
{
    for (UIButton *btn in self.answerView.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

// 在答案区找到第一个文字为空的按钮
- (UIButton *)firstAnswerButton
{
    // 取按钮的标题
    // 遍历答题区所有按钮
    for (UIButton *btn in self.answerView.subviews) {
        if (btn.currentTitle.length == 0) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 答题区按钮点击方法
- (void)answerClick:(UIButton *)button
{
    // 1. 如果按钮没有字，直接返回
    if (button.currentTitle.length == 0) return;
    
    // 2. 如果有字，清除文字，候选区按钮显示
    // 1> 使用button的title去查找候选区中对应的按钮
    UIButton *btn = [self optionButtonWithTilte:button.currentTitle isHidden:YES];
    
    // 2> 显示对应按钮
    btn.hidden = NO;
    
    // 3> 清除button的文字
    [button setTitle:@"" forState:UIControlStateNormal];
    
    // 4> 只要点击了按钮上的文字，意味着答题区的内容不完整
    [self setAnswerButtonsColor:[UIColor blackColor]];
}

- (UIButton *)optionButtonWithTilte:(NSString *)title isHidden:(BOOL)isHidden
{
    // 遍历候选区中的所有按钮
    for (UIButton *btn in self.optionsView.subviews) {
        if ([btn.currentTitle isEqualToString:title] && btn.isHidden == isHidden) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 提示功能
- (IBAction)tipClick
{
    // 1. 把答题区中所有的按钮清空
    for (UIButton *btn in self.answerView.subviews) {
        // 用代码执行点击答题按钮的操作
        [self answerClick:btn];
    }
    
    // 2. 把正确答案的第一个字，设置到答题区中
    // 1> 知道答案的第一个字
    HMQuestion *question = self.questions[self.index];
    // 月光宝盒
    NSString *first = [question.answer substringToIndex:1];
    // 取出文字对应的候选按钮
    //    for (UIButton *btn in self.optionsView.subviews) {
    //        if ([btn.currentTitle isEqualToString:first] && !btn.isHidden) {
    //            [self optionClick:btn];
    //
    //            break;
    //        }
    //    }
    UIButton *btn = [self optionButtonWithTilte:first isHidden:NO];
    [self optionClick:btn];
    
    // 扣分
    [self changeScore:-1000];
}

#pragma mark - 分数处理
- (void)changeScore:(int)score
{
    // 取出当前的分数
    int currentScore = self.scoreButton.currentTitle.intValue;
    
    // 使用score调整分数
    currentScore += score;
    
    // 重新设置分数
    [self.scoreButton setTitle:[NSString stringWithFormat:@"%d", currentScore] forState:UIControlStateNormal];
}

@end
