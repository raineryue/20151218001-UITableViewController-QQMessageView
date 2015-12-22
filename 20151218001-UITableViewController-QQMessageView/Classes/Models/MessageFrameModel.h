//
//  MessageFrameModel.h
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/22.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MessagesModel;

#define kTextFontSize [UIFont systemFontOfSize:14.0]
#define kTimeFontSize [UIFont systemFontOfSize:12.0]
// 定义一个按钮内容的间距
#define kTextButtonContentPadding 20

@interface MessageFrameModel : NSObject

@property (nonatomic, assign) CGRect textFrame;

@property (nonatomic, assign) CGRect timeFrame;

@property (nonatomic, assign) CGRect userIconFrame;

@property (nonatomic, assign) CGFloat cellRowHeight;

@property (nonatomic, strong) MessagesModel *message;

@end
