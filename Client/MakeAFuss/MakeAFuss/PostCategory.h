//
//  Category.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostCategory : NSObject

@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSString *categoryName;

- (instancetype)initWithID:(NSNumber *)categoryId name:(NSString *)name;

+ (instancetype)categoryWithDictionary:(NSDictionary *)dictionary;

@end
