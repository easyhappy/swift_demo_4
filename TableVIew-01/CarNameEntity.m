//
//  CarNameEntity.m
//  TableVIew-01
//
//  Created by Apple-JF on 14-12-9.
//  Copyright (c) 2014年 Apple-JF. All rights reserved.
//

#import "CarNameEntity.h"

@implementation CarNameEntity

- (id)initWithDictionary:(NSDictionary *) carDictionary
{
    if (self = [super init]) {
        //kvc的方法
        [self setValuesForKeysWithDictionary:carDictionary];
    }
    return self;
}

+ (id)carWithDictionary:(NSDictionary *) carDictionary
{
    return [[self alloc] initWithDictionary:carDictionary];
}

@end
