//
//  FakeHomepageTableViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FakeHomepageTableViewController.h"
#import "DetailsTabBarController.h"


@interface FakeHomepageTableViewController ()

@end

@implementation FakeHomepageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return 1; // magic number, just want to be able to select a cell
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"The Power of Print";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld", indexPath.row);
    
    // make the tab bar controller
    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];
    
    
    tabBarController.navigationItem.title = @"The Power of Print";
    // move to it (all the child VCs are setup in viewDidLoad of DetailsTabBarController)
    [self.navigationController showViewController: tabBarController sender:nil];
    
//    [self.navigationController pushViewController:tabBarController animated:YES];
    
}


@end
