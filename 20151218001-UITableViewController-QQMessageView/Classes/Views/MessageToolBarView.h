//
//  MessageToolBarView.h
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/21.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageToolBarView;

@protocol MessageToolBarViewDelegate <NSObject>

@required
- (void)messageToolBarView:(MessageToolBarView *)messageToolBarView returnDidClickWithTextField:(UITextField *)textField;

@end

@interface MessageToolBarView : UIImageView

@property (nonatomic, weak) id<MessageToolBarViewDelegate> delegate;

- (instancetype)initMessageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image;

+ (instancetype)messageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
