//
//  HeaderView.h
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *theHeaderView = @"HeaderView";

@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end
