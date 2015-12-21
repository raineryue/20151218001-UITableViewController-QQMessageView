//
//  MessageToolBarView.h
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/21.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageToolBarView : UIImageView

- (instancetype)initMessageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image;

+ (instancetype)messageToolBarViewWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
