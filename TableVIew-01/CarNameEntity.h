//
//  CarNameEntity.h
//  TableVIew-01
//
//  Created by Apple-JF on 14-12-9.
//  Copyright (c) 2014年 Apple-JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarNameEntity : NSObject

@property(nonatomic , copy) NSString *title;
@property(nonatomic , copy) NSString *desc;
@property(nonatomic , strong) NSArray  *cars;

- (id)initWithDictionary:(NSDictionary *) carDictionary;
+ (id)carWithDictionary:(NSDictionary *) carDictionary;

@end
