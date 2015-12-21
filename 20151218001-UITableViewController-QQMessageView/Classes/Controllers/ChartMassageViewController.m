//
//  ChartMassageViewController.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/20.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ChartMassageViewController.h"
#import "MessagesModel.h"
#import "MessageToolBarView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kMessageToolBarViewHeight 49

@interface ChartMassageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) MessageToolBarView *messageToolBarView;

@property (nonatomic, strong) NSArray *messageArray;

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
        tableView.rowHeight = 80;
        
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
    
        _messageToolBarView = messageToolBarView;
        
        [self.view addSubview:_messageToolBarView];
    }
    
    return _messageToolBarView;
}

#pragma mark - 属性懒加载
/**
 *  获取数据源
 */
- (NSArray *)messageArray {
    if (nil == _messageArray) {
        _messageArray = [MessagesModel messageArray];
    }
    
    return _messageArray;
}

#pragma mark - TableView数据源代理方法
/**
 *  返回每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

/**
 *  返回每行的单元格
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCellIdentifier = @"messageTableViewCellIdentifier";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    if (nil == tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellIdentifier];
    }
    
    MessagesModel *message = self.messageArray[indexPath.row];
    
    tableViewCell.textLabel.text = message.text;
    
    return tableViewCell;
}

#pragma mark - TableView代理方法

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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

@end
