//
//  Comment.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (instancetype)initWithID:(NSString *)commentID text:(NSString *)text user:(NSString *)user {
    self = [super init];
    if (self) {
        _commentID = commentID;
        _text = text;
        _user = user;
    }
    return self;
}
+ (instancetype)commentWithDictionary:(NSDictionary *)dictionary {
    return [[Comment alloc] initWithID:dictionary[@"ID"] text:dictionary[@"text"] user:dictionary[@"user"]];
}
@end
