//
//  HeaderView.m
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import "HeaderView.h"


@interface HeaderView()


@property (nonatomic, strong) UIView *aView;
@end


@implementation HeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView *aView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        [self addSubview:aView];
        self.aView = aView;
        
        self.titleLab.font = [UIFont boldSystemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews {
    
    self.aView.frame = self.bounds;
}



@end
