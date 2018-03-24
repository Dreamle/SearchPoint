//
//  SearchModel.h
//  SearchPoint
//
//  Created by admin on 2018/3/24.
//  Copyright © 2018年 dreamLee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SignleSearchModel;

@interface SearchModel : NSObject

@property (nonatomic, strong) NSArray<SignleSearchModel *> *ybList;
@property (nonatomic, strong) NSArray<SignleSearchModel *> *cyList;

@end


@interface SignleSearchModel : NSObject

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) BOOL disctrictrl;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *phonetype;
@end
