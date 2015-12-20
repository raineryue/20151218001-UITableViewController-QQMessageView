//
//  ViewController.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/18.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import "ChartMassageViewController.h"

#define kViewMargin 10

@interface ViewController () <UITextFieldDelegate>

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 用户名 */
@property (nonatomic, weak) UITextField *loginNameTextField;
/** 密码 */
@property (nonatomic, weak) UITextField *passwordTextField;
/** 登录按钮 */
@property (nonatomic, weak) UIButton *loginButton;

@end

@implementation ViewController

#pragma mark - 控制器加载
/**
 *  视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self layoutSubviews];
}

/**
 *  布局子试图
 */
- (void)layoutSubviews {
    CGFloat titleLabelX = kViewMargin;
    CGFloat titleLabelY = [[UIApplication sharedApplication] statusBarFrame].size.height + 50;
    CGFloat titleLabelW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat titleLabelH = 35;
    
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat loginNameTextFieldX = kViewMargin;
    CGFloat loginNameTextFieldY = CGRectGetMaxY(self.titleLabel.frame) + kViewMargin;
    CGFloat loginNameTextFieldW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat loginNameTextFieldH = 35;
    
    self.loginNameTextField.frame = CGRectMake(loginNameTextFieldX, loginNameTextFieldY, loginNameTextFieldW, loginNameTextFieldH);
    
    CGFloat passwordTextFieldX = kViewMargin;
    CGFloat passwordTextFieldY = CGRectGetMaxY(self.loginNameTextField.frame) + kViewMargin;
    CGFloat passwordTextFieldW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat passwordTextFieldH = 35;
    
    self.passwordTextField.frame = CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    
    CGFloat loginButtonX = kViewMargin;
    CGFloat loginButtonY = CGRectGetMaxY(self.passwordTextField.frame) + kViewMargin;
    CGFloat loginButtonW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat loginButtonH = 40;
    
    self.loginButton.frame = CGRectMake(loginButtonX, loginButtonY, loginButtonW, loginButtonH);
}

#pragma mark - 控件懒加载
/**
 *  标题
 */
- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.text = @"登录";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel = titleLabel;
        
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

/**
 *  用户名输入框
 */
- (UITextField *)loginNameTextField {
    if (nil == _loginNameTextField) {
        UITextField *loginNameTextField = [[UITextField alloc] init];
        
        loginNameTextField.placeholder = @"请输入QQ号";
        loginNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        loginNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 35)];
        loginNameTextField.leftViewMode = UITextFieldViewModeAlways;
        loginNameTextField.returnKeyType = UIReturnKeyNext;
        loginNameTextField.background = [self resizableImageWithImageName:@"chat_bottom_textfield"];
        loginNameTextField.delegate = self;
        
        _loginNameTextField = loginNameTextField;
        
        [self.view addSubview:_loginNameTextField];
    }
    
    return _loginNameTextField;
}

/**
 *  密码输入框
 */
- (UITextField *)passwordTextField {
    if (nil == _passwordTextField) {
        UITextField *passwordTextField = [[UITextField alloc] init];
        
        passwordTextField.secureTextEntry = YES;
        passwordTextField.placeholder = @"请输入密码";
        passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 35)];
        passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        passwordTextField.returnKeyType = UIReturnKeyDone;
        passwordTextField.background = [self resizableImageWithImageName:@"chat_bottom_textfield"];
        passwordTextField.delegate = self;
        
        _passwordTextField = passwordTextField;
        
        [self.view addSubview:_passwordTextField];
    }
    
    return _passwordTextField;
}

/**
 *  登录按钮
 */
- (UIButton *)loginButton {
    if (nil == _loginButton) {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        loginButton.adjustsImageWhenHighlighted = NO;
        loginButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:1.5];
        loginButton.backgroundColor = [UIColor redColor];
        
        [loginButton addTarget:self action:@selector(loginButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _loginButton = loginButton;
        
        [self.view addSubview:_loginButton];
    }
    
    return _loginButton;
}

#pragma mark - 代理方法实现
/**
 *  文本框Return按钮将要点击方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.loginNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
        
        [self.navigationController pushViewController:[[ChartMassageViewController alloc] init] animated:YES];
    }
    
    return YES;
}

#pragma mark - 事件监听方法
/**
 *  登录按钮点击事件
 */
- (void)loginButtonClickAction:(UIButton *)button {
    [self.navigationController pushViewController:[[ChartMassageViewController alloc] init] animated:YES];
}

#pragma mark - 私有辅助方法
/**
 *  根据图片名称拉伸图片方法
 */
- (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    CGFloat imageW = (self.view.bounds.size.width - kViewMargin * 2) * 0.5 - 1;
    CGFloat imageH = 35 * 0.5 - 1;
    
    return [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 内存管理方法
/**
 *  内存警告方法
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
