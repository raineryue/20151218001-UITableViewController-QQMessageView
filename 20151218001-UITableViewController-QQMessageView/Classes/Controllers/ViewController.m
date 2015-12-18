//
//  ViewController.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/18.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ViewController.h"

#define kViewMargin 10

@interface ViewController ()

@property (nonatomic, weak) UITextField *loginNameTextField;
@property (nonatomic, weak) UITextField *passwordTextField;
@property (nonatomic, weak) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    CGFloat loginNameTextFieldX = kViewMargin;
    CGFloat loginNameTextFieldY = [[UIApplication sharedApplication] statusBarFrame].size.height + 50;
    CGFloat loginNameTextFieldW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat loginNameTextFieldH = 40;
    
    self.loginNameTextField.frame = CGRectMake(loginNameTextFieldX, loginNameTextFieldY, loginNameTextFieldW, loginNameTextFieldH);
    
    CGFloat passwordTextFieldX = kViewMargin;
    CGFloat passwordTextFieldY = CGRectGetMaxY(self.loginNameTextField.frame) + kViewMargin;
    CGFloat passwordTextFieldW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat passwordTextFieldH = 40;
    
    self.passwordTextField.frame = CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    
    CGFloat loginButtonX = kViewMargin;
    CGFloat loginButtonY = CGRectGetMaxY(self.passwordTextField.frame) + kViewMargin;
    CGFloat loginButtonW = self.view.bounds.size.width - kViewMargin * 2;
    CGFloat loginButtonH = 40;
    
    self.loginButton.frame = CGRectMake(loginButtonX, loginButtonY, loginButtonW, loginButtonH);
}

- (UITextField *)loginNameTextField {
    if (nil == _loginNameTextField) {
        UITextField *loginNameTextField = [[UITextField alloc] init];
        
        _loginNameTextField = loginNameTextField;
        
        [self.view addSubview:_loginNameTextField];
    }
    
    return _loginNameTextField;
}

- (UITextField *)passwordTextField {
    if (nil == _passwordTextField) {
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bottom_textfield"]];
        
        _passwordTextField = passwordTextField;
        
        [self.view addSubview:_passwordTextField];
    }
    
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (nil == _loginButton) {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        loginButton.adjustsImageWhenHighlighted = NO;
        loginButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:1.5];
        loginButton.backgroundColor = [UIColor redColor];
        
        _loginButton = loginButton;
        
        [self.view addSubview:_loginButton];
    }
    
    return _loginButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
