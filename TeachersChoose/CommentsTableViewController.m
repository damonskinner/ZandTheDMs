//
//  CommentsTableViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CommentCell.h"
#import "CommentsTableView.h"
#import "Comments.h"


@interface CommentsTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *commentsArray;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
[self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil ] forCellReuseIdentifier:@"basicCell"];

    self.commentsArray = [[NSMutableArray alloc]init];
    

//    Comments *newComment = [[Comments alloc]initWithCommentNameFromLocationCopy:<#(NSString *)#> commentDonationGivenDate:<#(NSString *)#> commentDonorMessageCopy:<#(NSString *)#>];

}


-(void)viewDidAppear:(BOOL)animated
{
    // set the title (DOESNT WORK)
    self.navigationController.navigationItem.title = @"Comments";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.commentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    cell.comments = [self.commentsArray objectAtIndex:indexPath.row];
    
//        if (cell == nil)
//            {
//                cell = [CommentCell alloc] init];
//    //    }
    //
    //    FISDonation *thisDonation = self.comments[indexPath.row];
    //
    //    cell.commenterName.text = thisDonation.donor;
    //    cell.messageBody.text = thisDonation.donorMessage;
    
    return cell;
}



@end
