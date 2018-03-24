//
//  searchResultView.h
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@class SearchResultView;

@protocol searchResultViewDelegate<NSObject>

- (void)searchResultView:(SearchResultView *)view didSelectModel:(SignleSearchModel *)model;

@end

@interface SearchResultView : UIView

@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic, weak) id<searchResultViewDelegate> delegate;

@end
