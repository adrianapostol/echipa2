//
//  Category.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "PostCategory.h"

@implementation PostCategory

- (instancetype)initWithID:(NSNumber *)categoryId name:(NSString *)name {
    self = [self init];
    if (self) {
        _categoryID = categoryId;
        _categoryName = name;
    }
    return self;
}

+ (instancetype)categoryWithDictionary:(NSDictionary *)dictionary {
    return [[PostCategory alloc] initWithID:dictionary[@"id"] name:dictionary[@"categoryName"]];
}

@end
