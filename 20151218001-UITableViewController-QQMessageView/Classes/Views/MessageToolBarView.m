//
//  MessageToolBarView.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/21.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "MessageToolBarView.h"

#define kSubviewMargin 10
#define kToolBarButtonHW 32
#define kViewWidth self.bounds.size.width
#define kViewHeight self.bounds.size.height

@interface MessageToolBarView ()

/** 语音按钮 */
@property (nonatomic, weak) UIButton *voiceButton;

/** 消息文本框 */
@property (nonatomic, weak) UITextField *messageTextField;

/** 表情按钮 */
@property (nonatomic, weak) UIButton *emotionsButton;

/** 更多（加号）按钮 */
@property (nonatomic, weak) UIButton *moreButton;

@end

@implementation MessageToolBarView

- (instancetype)initMessageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

+ (instancetype)messageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image {
    return [[MessageToolBarView alloc] initMessageToolBarViewWithFrame:frame andImage:image];
}

#pragma mark - 控件懒加载
/**
 *  语音按钮
 */
- (UIButton *)voiceButton {
    if (nil == _voiceButton) {
        UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [voiceButton setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [voiceButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
        
        _voiceButton = voiceButton;
        [self addSubview:_voiceButton];
    }
    
    return _voiceButton;
}

/**
 *  消息文本框
 */
- (UITextField *)messageTextField {
    if (nil == _messageTextField) {
        UITextField *messageTextField = [[UITextField alloc] init];
        
        CGFloat messageTextFieldW = (kViewWidth - kSubviewMargin * 5 - kToolBarButtonHW * 3) * 0.5 - 1;
        CGFloat messageTextFieldH = kToolBarButtonHW * 0.5 - 1;
        
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(messageTextFieldH, messageTextFieldW, messageTextFieldH, messageTextFieldW);
        
        UIImage *messageBackgroundImage = [[UIImage imageNamed:@"chat_bottom_textfield"] resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
        
        messageTextField.background = messageBackgroundImage;
        messageTextField.returnKeyType = UIReturnKeySend;
        
        _messageTextField = messageTextField;
        [self addSubview:_messageTextField];
    }
    
    return _messageTextField;
}

/**
 *  表情按钮
 */
- (UIButton *)emotionsButton {
    if (nil == _emotionsButton) {
        UIButton *emotionsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [emotionsButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
        [emotionsButton setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
        
        _emotionsButton = emotionsButton;
        [self addSubview:_emotionsButton];
    }
    
    return _emotionsButton;
}

/**
 *  更多按钮
 */
- (UIButton *)moreButton {
    if (nil == _moreButton) {
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
        
        _moreButton = moreButton;
        [self addSubview:_moreButton];
    }
    
    return _moreButton;
}

#pragma mark - 布局子视图
/**
 *  布局子视图
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 语音按钮
    CGFloat voiceButtonX = kSubviewMargin;
    CGFloat voiceButtonY = (kViewHeight - kToolBarButtonHW) * 0.5;
    CGFloat voiceButtonW = kToolBarButtonHW;
    CGFloat voiceButtonH = kToolBarButtonHW;
    
    self.voiceButton.frame = CGRectMake(voiceButtonX, voiceButtonY, voiceButtonW, voiceButtonH);
    
    // 消息文本框
    CGFloat messageTextFieldW = kViewWidth - kSubviewMargin * 5 - kToolBarButtonHW * 3;
    CGFloat messageTextFieldH = kToolBarButtonHW;
    CGFloat messageTextFieldX = CGRectGetMaxX(self.voiceButton.frame) + kSubviewMargin;
    CGFloat messageTextFieldY = (kViewHeight - kToolBarButtonHW) * 0.5;
    
    self.messageTextField.frame = CGRectMake(messageTextFieldX, messageTextFieldY, messageTextFieldW, messageTextFieldH);
    
    // 表情按钮
    CGFloat emotionsButtonX = CGRectGetMaxX(self.messageTextField.frame) + kSubviewMargin;
    CGFloat emotionsButtonY = (kViewHeight - kToolBarButtonHW) * 0.5;
    CGFloat emotionsButtonW = kToolBarButtonHW;
    CGFloat emotionsButtonH = kToolBarButtonHW;
    
    self.emotionsButton.frame = CGRectMake(emotionsButtonX, emotionsButtonY, emotionsButtonW, emotionsButtonH);
    
    // 更多按钮
    CGFloat moreButtonX = CGRectGetMaxX(self.emotionsButton.frame) + kSubviewMargin;
    CGFloat moreButtonY = (kViewHeight - kToolBarButtonHW) * 0.5;
    CGFloat moreButtonW = kToolBarButtonHW;
    CGFloat moreButtonH = kToolBarButtonHW;
    
    self.moreButton.frame = CGRectMake(moreButtonX, moreButtonY, moreButtonW, moreButtonH);
}

@end
