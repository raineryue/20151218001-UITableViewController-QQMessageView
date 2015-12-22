//
//  MessageFrameModel.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/22.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "MessageFrameModel.h"
#import "MessagesModel.h"

#define kSubviewMargin 10
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kUserIconWidth 40
#define kUserIconHeight 40

@implementation MessageFrameModel

- (void)setMessage:(MessagesModel *)message {
    _message = message;
    
    // 时间
    if (![message.hiddenTime boolValue]) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = [UIScreen mainScreen].bounds.size.width;
        CGFloat timeH = 30;
        
        self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 头像
    CGFloat userIconW = kUserIconWidth;
    CGFloat userIconH = kUserIconHeight;
    
    CGFloat userIconX;
    
    if (MessageFromMe == message.type) {
        userIconX = kScreenWidth - kUserIconWidth - kSubviewMargin;
    } else {
        userIconX = kSubviewMargin;
    }
    
    CGFloat userIconY = CGRectGetMaxY(self.timeFrame) + kSubviewMargin;
    
    self.userIconFrame = CGRectMake(userIconX, userIconY, userIconW, userIconH);
    
    // 消息
    NSDictionary *fontDictionary = @{NSFontAttributeName:kTextFontSize};
    
    CGSize textSize = [message.text boundingRectWithSize:CGSizeMake((kScreenWidth - kUserIconWidth * 2 - kSubviewMargin * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDictionary context:nil].size;
    
    // 这里要考虑按钮的内边距所以要将上下左右的边距宽度留出来
    CGFloat textW = textSize.width + kTextButtonContentPadding * 2;
    CGFloat textH = textSize.height + kTextButtonContentPadding * 2;
    
    CGFloat textX;
    
    if (MessageFromMe == message.type) {
        textX = kScreenWidth - kUserIconWidth - kSubviewMargin - textW;
    } else {
        textX = kSubviewMargin + kUserIconWidth;
    }
    
    CGFloat textY = self.userIconFrame.origin.y;
    
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 表格行高
    self.cellRowHeight = MAX(CGRectGetMaxY(self.textFrame), CGRectGetMaxY(self.userIconFrame)) + kSubviewMargin;
}

@end
