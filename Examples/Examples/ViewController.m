//
//  ViewController.m
//  KVODemo
//
//  Created by Maximiliano Casal on 4/1/15.
//  Copyright (c) 2015 Maximiliano Casal. All rights reserved.
//

#import "ViewController.h"
#import "Children.h"

@interface ViewController ()

@property (nonatomic, strong) Children *child1;
@property (nonatomic, strong) Children *child2;
@property (nonatomic, strong) Children *child3;



@end

@implementation ViewController
static void *child1Context = &child1Context;
static void *child2Context = &child2Context;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.child1 = [Children new];
    self.child2 = [Children new];
    self.child3 = [Children new];
    
    [self.child1 setValue:@"Mike" forKey:@"name"];
    [self.child1 setValue:[NSNumber numberWithInteger:23] forKey:@"age"];
    
    NSLog(@"%@, %lu", self.child1.name, (unsigned long)self.child1.age);
    
    [self.child2 setValue:@"Harvey" forKey:@"name"];
    [self.child2 setValue:[NSNumber numberWithInteger:35] forKey:@"age"];
    self.child2.child = [Children new];
    [self.child2 setValue:@"Jessica" forKeyPath:@"child.name"];
    [self.child2 setValue:[NSNumber numberWithInteger:45] forKeyPath:@"child.age"];
    NSLog(@"%@, %lu", self.child2.child.name, (unsigned long)self.child2.child.age);
    
    self.child3.child = [Children new];
    self.child3.child.child = [Children new];
    
    [self.child3 setValue:@"Louis" forKeyPath:@"child.child.name"];
    [self.child3 setValue:[NSNumber numberWithInteger:42] forKeyPath:@"child.child.age"];
    
    NSLog(@"%@, %lu", self.child3.child.child.name, (unsigned long)self.child3.child.child.age);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.child1 addObserver:self forKeyPath:@"name"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:child1Context];
    [self.child1 addObserver:self forKeyPath:@"age"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:child1Context];
    
    [self.child1 willChangeValueForKey:@"name"];
    self.child1.name = @"Michael";
    [self.child1 didChangeValueForKey:@"name"];
    
    [self.child1 setValue:[NSNumber numberWithInteger:20]
                   forKey:@"age"];
    
    [self.child2 addObserver:self forKeyPath:@"age"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:child2Context];
    
    [self.child2 setValue:[NSNumber numberWithInteger:45] forKey:@"age"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    if (context == child1Context) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"The name of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
        
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
    }
    else if (context == child2Context){
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the SECOND child was changed.");
            NSLog(@"%@", change);
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.child1 removeObserver:self forKeyPath:@"name"];
    [self.child1 removeObserver:self forKeyPath:@"age"];
    [self.child2 removeObserver:self forKeyPath:@"age"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
