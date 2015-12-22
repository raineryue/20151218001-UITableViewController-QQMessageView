//
//  MessagesModel.h
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/20.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageFromMe = 0,
    MessageFromOther
} MessageFrom;

@interface MessagesModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) MessageFrom type;

@property (nonatomic, copy) NSString *hiddenTime;

- (instancetype)initMessageWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary;

- (NSArray *)messageArray;

+ (NSArray *)messageArray;

@end
