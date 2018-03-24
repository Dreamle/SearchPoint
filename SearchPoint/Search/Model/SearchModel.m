//
//  SearchModel.m
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import "SearchModel.h"
#import "MJExtension.h"

@implementation SearchModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"ybList":[SignleSearchModel class],@"cyList":[SignleSearchModel class]};
}
@end


@implementation SignleSearchModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
@end

