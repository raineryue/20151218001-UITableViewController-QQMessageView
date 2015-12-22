//
//  MessageTableViewCell.h
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/22.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageFrameModel;

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) MessageFrameModel *messageFrame;

- (instancetype)initMessageTableViewCellWithTableView:(UITableView *)tableView;

+ (instancetype)messageTableViewCellWithTableView:(UITableView *)tableView;

@end
