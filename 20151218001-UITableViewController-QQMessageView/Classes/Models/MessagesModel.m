//
//  MessagesModel.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/20.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "MessagesModel.h"

@implementation MessagesModel

- (instancetype)initMessageWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary {
    return [[MessagesModel alloc] initMessageWithDictionary:dictionary];
}

- (NSArray *)messageArray {
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    
    __block NSMutableArray *messageArray = [NSMutableArray array];
    
    [plistArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        
        MessagesModel *message = messageArray.lastObject;
        
        NSString *hiddenTime = [NSString stringWithFormat:@"%d", [dictionary[@"time"] isEqualToString:message.time]];
        [mutableDictionary setObject:hiddenTime forKey:@"hiddenTime"];
        
        [messageArray addObject:[MessagesModel messageWithDictionary:mutableDictionary]];
    }];
    
    return messageArray;
}

+ (NSArray *)messageArray {
    return [[[MessagesModel alloc] init] messageArray];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> [text:%@, time:%@, type:%d]", self.class, self, self.text, self.time, self.type];
}

@end
