//
//  TSZHomeViewController.m
//  NewsDemo
//
//  Created by Tsz on 15/11/22.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZHomeViewController.h"

static NSString * const ID = @"cell";

@interface TSZHomeViewController ()

@end

@implementation TSZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID     forIndexPath:indexPath];
    
    cell.textLabel.text = @"我是测试";
    
    
    return cell;
}


@end
