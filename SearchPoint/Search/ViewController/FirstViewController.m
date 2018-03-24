//
//  FirstViewController.m
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import "FirstViewController.h"
#import "ContentTableViewCell.h"
#import "HeaderView.h"
#import "SearchModel.h"
#import "MJExtension.h"
#import "searchResultView.h"
// 颜色
static inline UIColor *RGBA(int R, int G, int B, double A) {
    return [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A];
}

static inline UIColor *HexColor(int v) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), 1.0f);
}




@interface FirstViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,searchResultViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet SearchResultView *searchResultView;

//不常用
@property (nonatomic, strong) NSArray *indexTitles;
@property (nonatomic, strong) NSArray *sectionContentsArray;
//常用
@property (nonatomic, strong) NSArray *changYongArr;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"选择";
    self.searchResultView.hidden = YES;
    self.searchResultView.delegate = self;
    
    [self setupTabBar];
    [self setupTableView];
    
}

- (void)setupTabBar {
    
    self.searchBar.barTintColor = HexColor(0xE5E5E5);
    self.searchBar.backgroundColor = HexColor(0xE5E5E5);
    self.searchBar.backgroundImage = [UIImage new]; //去掉上下线条
    self.searchBar.returnKeyType  = UIReturnKeySearch;
    self.searchBar.delegate = self;
    //关闭系统自动联想和首字母大写功能
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //    _searchBar.layer.borderWidth = 1;
    //    _searchBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    for (UIView *view in self.searchBar.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *textField = (UITextField *)view;
            //设置输入框的背景颜色
            textField.clipsToBounds = YES;
            textField.backgroundColor = [UIColor whiteColor];
            //设置输入框边框的圆角以及颜色
            textField.layer.cornerRadius = 5.0f;
            textField.layer.borderColor = HexColor(0xFFFFFF).CGColor;
            textField.layer.borderWidth = 1;
        }
    }
}

//点击完成出发搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    if (searchBar.text.length <= 0) {
        self.searchResultView.hidden = YES;
        return;
    }
    NSMutableArray *resultArr = [NSMutableArray array];
   
    for (NSArray *array in self.sectionContentsArray) {
        for (SignleSearchModel *model in array) {
            if ([model.name containsString:searchBar.text]) {
                [resultArr addObject:model];
            }
        }
    }
    self.searchResultView.hidden = NO;
    self.searchResultView.resultArr = resultArr;
}

//搜索框文字改变出发的代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchBar.text.length <= 0) {
         self.searchResultView.hidden = YES;
    } else {
         self.searchResultView.hidden = NO;
        
        NSMutableArray *resultArr = [NSMutableArray array];
        for (NSArray *array in self.sectionContentsArray) {
            for (SignleSearchModel *model in array) {
                if ([model.name containsString:searchBar.text]) {
                    [resultArr addObject:model];
                }
            }
        }
        self.searchResultView.resultArr = resultArr;
        
        
    }
}

- (void)setupTableView {
    
    [self.tableView registerNib:[UINib nibWithNibName:theContentTableViewCell bundle:nil] forCellReuseIdentifier:theContentTableViewCell];
    [self.tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:theHeaderView];
    self.tableView.rowHeight = 44.0;
    
    self.tableView.sectionIndexColor = HexColor(0xA2A2A2);//设置默认时索引值颜色
    //    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor grayColor];//设置选中时，索引背景颜色
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor]; //设置默认时，索引的背景颜色
    
  
    
    NSDictionary *dic1 = @{@"createTime":@"2018-03-04",@"disctrictrl":@(0),@"name":@"新加坡",@"phonetype":@"+78",@"notes":@"123",@"id":@"123"};
     NSDictionary *dic2 = @{@"createTime":@"2018-03-04",@"disctrictrl":@(0),@"name":@"中国",@"phonetype":@"+86",@"notes":@"123",@"id":@"123"};
     NSDictionary *dic3 = @{@"createTime":@"2018-03-04",@"disctrictrl":@(0),@"name":@"美国",@"phonetype":@"+71",@"notes":@"123",@"id":@"123"};
    NSDictionary *dic4 = @{@"createTime":@"2018-03-04",@"disctrictrl":@(0),@"name":@"新西兰",@"phonetype":@"+80",@"notes":@"123",@"id":@"123"};
    
    NSDictionary *Dic = @{@"cyList":@[dic1,dic2,dic3,dic4],@"ybList":@[dic3]};
    SearchModel *model = [SearchModel mj_objectWithKeyValues:Dic];
    self.changYongArr = model.ybList;
    self.sectionContentsArray = [self arrayForSections:model.cyList];
    
}


#pragma mark - 数组排序
- (NSArray *)arrayForSections:(NSArray *)objects {
    
    // sectionTitlesCount 27 , A - Z + #
    SEL selector = @selector(name); //对应模型中的名字
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    // section number
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    // Create 27 sections' data
    NSMutableArray *mutableSections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        [mutableSections addObject:[NSMutableArray array]];
    }
    
    // Insert records
    for (id object in objects) {
        NSInteger sectionNumber = [collation sectionForObject:object collationStringSelector:selector];
        [[mutableSections objectAtIndex:sectionNumber] addObject:object];
    }
    
    // sort in section
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        NSArray *objectsForSection = [mutableSections objectAtIndex:idx];
        [mutableSections replaceObjectAtIndex:idx withObject:[[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsForSection collationStringSelector:selector]];
    }
    
    // Remove empty sections && insert table data
    NSMutableArray *existTitleSections = [NSMutableArray array];
    for (NSArray *section in mutableSections) {
        if ([section count] > 0) {
            [existTitleSections addObject:section];
        }
    }
    
    // Remove empty sections Index in indexList
    NSMutableArray *existTitles = [NSMutableArray array];
    NSArray *allSections = [collation sectionIndexTitles];
    
    for (NSUInteger i = 0; i < [allSections count]; i++) {
        if ([mutableSections[ i ] count] > 0) {
            [existTitles addObject:allSections[ i ]];
        }
    }
    
    //create indexlist data array
    self.indexTitles = existTitles;
    return existTitleSections;
}

#pragma mark - resultView代理
- (void)searchResultView:(SearchResultView *)view didSelectModel:(SignleSearchModel *)model {
    NSLog(@"++++++++ 选中了 %@",model.name);
}

#pragma mark - tableView代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SignleSearchModel *singleModel = nil;
    if (indexPath.section == 0) {
        singleModel = self.changYongArr[indexPath.row];
        
    } else {
        NSArray *contentArr = self.sectionContentsArray[indexPath.section-1];
        singleModel = contentArr[indexPath.row];
    }
    
    if (singleModel) {
        [self searchResultView:nil didSelectModel:singleModel];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    for (UIView *view in [tableView subviews]) {
        if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
            // 设置字体大小
            [view setValue:[UIFont systemFontOfSize:12.0] forKey:@"_font"];
            [view setBackgroundColor:[UIColor clearColor]];
        }
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexTitles.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.changYongArr.count;
    } else {
         NSArray *contentArr = self.sectionContentsArray[section-1];
         return contentArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theContentTableViewCell forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        SignleSearchModel *singleModel = self.changYongArr[indexPath.row];
        cell.leftLab.text = singleModel.name;
        cell.rightLab.text = singleModel.phonetype;
    } else {
        NSArray *contentArr = self.sectionContentsArray[indexPath.section-1];
        SignleSearchModel *singleModel = contentArr[indexPath.row];
        cell.leftLab.text = singleModel.name;
        cell.rightLab.text = singleModel.phonetype;
    }
   
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:theHeaderView];
    if (section == 0) {
        headerView.titleLab.text = @"常用国家和地区";
        headerView.titleLab.textColor = HexColor(0x505050);
    } else {
        
        headerView.titleLab.text = self.indexTitles[section - 1];
        headerView.titleLab.font = [UIFont systemFontOfSize:14];
        headerView.titleLab.textColor = HexColor(0x62A5FF);

    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *indexArr = [self.indexTitles mutableCopy];
    [indexArr insertObject:@"*" atIndex:0];
    return indexArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index
{
    return index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
