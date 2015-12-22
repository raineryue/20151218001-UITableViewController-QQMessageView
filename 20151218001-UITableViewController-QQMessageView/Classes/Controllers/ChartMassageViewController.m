//
//  ChartMassageViewController.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/20.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ChartMassageViewController.h"
#import "MessagesModel.h"
#import "MessageFrameModel.h"
#import "MessageToolBarView.h"
#import "MessageTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kMessageToolBarViewHeight 49

@interface ChartMassageViewController () <UITableViewDataSource, UITableViewDelegate, MessageToolBarViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) MessageToolBarView *messageToolBarView;

@property (nonatomic, strong) NSMutableArray *messageFrameArray;

@end

@implementation ChartMassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子视图
    [self setupSubviews];

    // 注册通知
    [self registerNotification];
}

/**
 *  布局子视图
 */
- (void)setupSubviews {
    // 添加表格视图
    [self tableView];
    
    // 添加消息工具条
    [self messageToolBarView];
}

/**
 *  注册通知
 */
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrameAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 控件懒加载
/**
 *  tableView懒加载
 */
- (UITableView *)tableView {
    if (nil == _tableView) {
        UITableView *tableView = [[UITableView alloc] init];

        tableView.frame = self.view.bounds;
        tableView.contentInset = UIEdgeInsetsMake(kStatusBarHeight, 0, kMessageToolBarViewHeight, 0);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1.0];
        tableView.allowsSelection = NO;
        
        _tableView = tableView;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

/**
 *  消息发送窗口懒加载
 */
- (MessageToolBarView *)messageToolBarView {
    if (nil == _messageToolBarView) {
        // 消息发送视图
        CGFloat messageToolBarViewW = kScreenWidth;
        CGFloat messageToolBarViewH = kMessageToolBarViewHeight;
        CGFloat messageToolBarViewX = 0;
        CGFloat messageToolBarViewY = kScreenHeight - messageToolBarViewH;
        
        CGRect frame = CGRectMake(messageToolBarViewX, messageToolBarViewY , messageToolBarViewW, messageToolBarViewH);
        
        MessageToolBarView *messageToolBarView = [[MessageToolBarView alloc] initMessageToolBarViewWithFrame:frame andImage:[UIImage imageNamed:@"chat_bottom_bg"]];
        messageToolBarView.delegate = self;
    
        _messageToolBarView = messageToolBarView;
        
        [self.view addSubview:_messageToolBarView];
    }
    
    return _messageToolBarView;
}

#pragma mark - 属性懒加载
/**
 *  获取数据源
 */
- (NSArray *)messageFrameArray {
    if (nil == _messageFrameArray) {
        _messageFrameArray = [NSMutableArray array];
        
        NSArray *messageArray = [MessagesModel messageArray];
        
        [messageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MessageFrameModel *messageFrame = [[MessageFrameModel alloc] init];
            
            messageFrame.message = obj;
            
            [_messageFrameArray addObject:messageFrame];
        }];
    }
    
    return _messageFrameArray;
}

#pragma mark - TableView数据源代理方法
/**
 *  返回每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrameArray.count;
}

/**
 *  返回每行的单元格
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *tableViewCell = [MessageTableViewCell messageTableViewCellWithTableView:tableView];
    
    tableViewCell.messageFrame = self.messageFrameArray[indexPath.row];
    
    return tableViewCell;
}

/**
 *  返回单元格行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageFrameModel *messageFrame = self.messageFrameArray[indexPath.row];
    
    return messageFrame.cellRowHeight;
}

#pragma mark - TableView代理方法
/**
 *  开始拽动tableView时调用方法
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - 消息发送工具栏的代理方法
/**
 *  消息发送工具栏的代理方法
 */
- (void)messageToolBarView:(MessageToolBarView *)messageToolBarView returnDidClickWithTextField:(UITextField *)textField {
    // 1.创建一个消息模型
    MessagesModel *message = [[MessagesModel alloc] init];
    
    message.time = @"刚刚";
    message.text = textField.text;
    message.type = MessageFromMe;
    
    // 2.发送该消息
    [self sendMessageWithMessage:message];
    
    // 3.清空文本框
    textField.text = nil;
    
    // 4.自动回复一条消息
    [self autoAnswerMessageWithMessage:message];
}

#pragma mark - 事件监听方法
/**
 *  键盘的frame改变事件监听
 */
- (void)keyboardDidChangeFrameAction:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    
    // 1.获取当前键盘的Frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.获取当前键盘的Y值
    CGFloat keyboardY = keyboardFrame.origin.y;
    
    // 3.获取屏幕的高度
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // 4.获取键盘值改变的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 5.调整当前View的Y位置
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - screenHeight);
    }];
}

#pragma mark - 私有辅助方法
/**
 *  发送一条消息
 */
- (void)sendMessageWithMessage:(MessagesModel *)message {
    // 1.创建一个消息Frame模型
    MessageFrameModel *messageFrame = [[MessageFrameModel alloc] init];
    messageFrame.message = message;
    
    // 2.将消息添加到当前消息Frame模型数组中
    [self.messageFrameArray addObject:messageFrame];
    
    // 3.刷新表格
    [self.tableView reloadData];
    
    // 4.将表格滚动到最后一个数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.messageFrameArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/**
 *  自动回复一条消息
 */
- (void)autoAnswerMessageWithMessage:(MessagesModel *)message {
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay" ofType:@"plist"]];
    
    NSString *replayText = dictionary[message.text];
    
    if (replayText.length > 0) {
        // 1.创建一个消息模型
        MessagesModel *message = [[MessagesModel alloc] init];
        
        message.time = @"刚刚";
        message.text = replayText;
        message.type = MessageFromOther;
        
        [self sendMessageWithMessage:message];
    }

}

@end
