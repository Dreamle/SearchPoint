//
//  searchResultView.m
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import "SearchResultView.h"
#import "ContentTableViewCell.h"

@interface SearchResultView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *aView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
    aView.frame = self.bounds;
    [self addSubview:aView];
    
    [self.tableView registerNib:[UINib nibWithNibName:theContentTableViewCell bundle:nil] forCellReuseIdentifier:theContentTableViewCell];
    
    self.tableView.rowHeight = 44;
}

- (void)setResultArr:(NSArray *)resultArr {
    _resultArr = resultArr;
    if (resultArr) {
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theContentTableViewCell forIndexPath:indexPath];
    SignleSearchModel *model = self.resultArr[indexPath.row];
    cell.leftLab.text = model.name;
    cell.rightLab.text = model.phonetype;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SignleSearchModel *model = self.resultArr[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchResultView:didSelectModel:)]) {
        [self.delegate searchResultView:self didSelectModel:model];
    }
}

@end
