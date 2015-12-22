//
//  UIImage+Resize.m
//  20151218001-UITableViewController-QQMessageView
//
//  Created by Rainer on 15/12/22.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage *)resizeImageWithNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    
    CGFloat imageW = image.size.width * 0.5 - 1;
    CGFloat imageH = image.size.height * 0.5 - 1;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
}

@end
