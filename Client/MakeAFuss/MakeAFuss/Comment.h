//
//  Comment.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *user;

- (instancetype)initWithID:(NSString *)commentID text:(NSString *)text user:(NSString *)user;
+ (instancetype)commentWithDictionary:(NSDictionary *)dictionary;

@end
