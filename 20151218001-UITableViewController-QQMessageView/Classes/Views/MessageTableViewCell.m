//
//  MessageTableViewCell.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/22.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessagesModel.h"
#import "MessageFrameModel.h"
#import "UIImage+Resize.h"

@interface MessageTableViewCell ()

/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *userIconImageView;
/** 消息 */
@property (nonatomic, weak) UIButton *textButton;

@end

@implementation MessageTableViewCell

#pragma mark - 表格视图初始化创建

/**
 *  根据表初始化表格视图
 */
- (instancetype)initMessageTableViewCellWithTableView:(UITableView *)tableView {
    static NSString *tableViewCellIdentifier = @"messageTableViewCellIdentifier";
    
    MessageTableViewCell *messageTableViewCell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    if (nil == messageTableViewCell) {
        messageTableViewCell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
        messageTableViewCell.backgroundColor = [UIColor clearColor];
    }
    
    return messageTableViewCell;
}

/**
 *  根据表初始化表格视图
 */
+ (instancetype)messageTableViewCellWithTableView:(UITableView *)tableView {
    return [[MessageTableViewCell alloc] initMessageTableViewCellWithTableView:tableView];
}

#pragma mark - 控件懒加载
/**
 *  时间
 */
- (UILabel *)timeLabel {
    if (nil == _timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        
        timeLabel.font = kTimeFontSize;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel = timeLabel;
        [self.contentView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

/**
 *  头像
 */
- (UIImageView *)userIconImageView {
    if (nil == _userIconImageView) {
        UIImageView *userIconImageView = [[UIImageView alloc] init];
        
        _userIconImageView = userIconImageView;
        [self.contentView addSubview:_userIconImageView];
    }
    
    return _userIconImageView;
}

/**
 *  消息
 */
- (UIButton *)textButton {
    if (nil == _textButton) {
        UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        textButton.titleLabel.font = kTextFontSize;
        textButton.titleLabel.numberOfLines = 0;
        [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        textButton.contentEdgeInsets = UIEdgeInsetsMake(kTextButtonContentPadding, kTextButtonContentPadding, kTextButtonContentPadding, kTextButtonContentPadding);
        
        _textButton = textButton;
        [self.contentView addSubview:_textButton];
    }
    
    return _textButton;
}

#pragma mark - 复写属性getter和setter
/**
 *  复写messageFrame的setter方法
 */
- (void)setMessageFrame:(MessageFrameModel *)messageFrame {
    _messageFrame = messageFrame;
    
    // 布局子视图的位置大小
    [self layoutSubviewsWithMessageFrame:messageFrame];
    
    // 设置子视图数据
    [self setupSubviewDatasWithMessage:messageFrame.message];
}

/**
 *  布局子视图的位置大小
 */
- (void)layoutSubviewsWithMessageFrame:(MessageFrameModel *)messageFrame {
    self.timeLabel.frame = messageFrame.timeFrame;
    self.userIconImageView.frame = messageFrame.userIconFrame;
    self.textButton.frame = messageFrame.textFrame;
}

/**
 *  设置子视图数据
 */
- (void)setupSubviewDatasWithMessage:(MessagesModel *)message {
    // 时间
    self.timeLabel.text = message.time;
    
    // 头像
    if (MessageFromMe == message.type) {
         self.userIconImageView.image = [UIImage imageNamed:@"Jobs"];
    } else {
         self.userIconImageView.image = [UIImage imageNamed:@"Gatsby"];
    }
    
    // 消息：气泡背景，内容
    if (MessageFromMe == message.type) {
        [self.textButton setBackgroundImage:[UIImage resizeImageWithNamed:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textButton setBackgroundImage:[UIImage resizeImageWithNamed:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    } else {
        [self.textButton setBackgroundImage:[UIImage resizeImageWithNamed:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.textButton setBackgroundImage:[UIImage resizeImageWithNamed:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }
    
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
}

@end
