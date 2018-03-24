//
//  ContentTableViewCell.h
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *theContentTableViewCell = @"ContentTableViewCell";
@interface ContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@end
