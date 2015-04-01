//
//  Children.h
//  KVODemo
//
//  Created by Maximiliano Casal on 4/1/15.
//  Copyright (c) 2015 Maximiliano Casal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Children : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger age;
@property (nonatomic, strong) Children *child;

@end
