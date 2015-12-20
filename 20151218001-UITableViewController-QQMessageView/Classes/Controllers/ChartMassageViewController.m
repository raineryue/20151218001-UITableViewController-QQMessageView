//
//  ChartMassageViewController.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/20.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ChartMassageViewController.h"
#import "MessagesModel.h"

@implementation ChartMassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [MessagesModel messageArray]);
}

@end
