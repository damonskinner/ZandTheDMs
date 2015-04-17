//
//  HomePageTableViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "veryFirstViewController.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseCompletedProposal.h"
#import "ProposalTableViewCell.h"
#import "DetailsTabBarController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
#import <Parse.h>
#import <FAKIonIcons.h>

@interface HomePageTableViewController () <UIScrollViewDelegate>

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];

    UIImageView *testView = [[UIImageView alloc] initWithImage:self.datastore.loggedInTeacher.image];
    
    [self.tableView deselectRowAtIndexPath:nil animated:YES];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = testView.bounds;
    gradientLayer.colors= @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.85f].CGColor];
    gradientLayer.locations=@[[NSNumber numberWithFloat:0.6],[NSNumber numberWithFloat:0.85]];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    [testView.layer addSublayer:gradientLayer];
    
    UIGraphicsBeginImageContextWithOptions(testView.frame.size, testView.opaque, 0.0);
    [testView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setHeaderImage:newImage];
//    [self setHeaderImage:self.datastore.loggedInTeacher.image];
    [self setTitleText:self.datastore.loggedInTeacher.name];
    [self setSubtitleText:self.datastore.loggedInTeacher.schoolName];
    [self setLabelBackgroundGradientColor:[UIColor blackColor]];


    
    //need to change alpha of navBar, but won't work?
    self.navigationController.navigationBar.barTintColor=[UIColor DonorsChooseOrange];
    [self.navigationController.navigationBar setTranslucent:NO];
    

    self.title=@"Home";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor DonorsChooseGreyVeryLight],NSFontAttributeName:[UIFont fontWithName:DonorsChooseTitleBoldFont size:25]}];
    self.navigationController.navigationItem.backBarButtonItem.tintColor=[UIColor DonorsChooseGreyVeryLight];
    
    
    
    [self.tableView setSeparatorColor:[UIColor DonorsChooseOrange]];


    
    [self.view removeConstraints:self.view.constraints];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    

    UIImage *gearIconImage = [[FAKIonIcons gearAIconWithSize:25] imageWithSize:CGSizeMake(25,25)] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:gearIconImage style:UIBarButtonItemStylePlain target:self action:@selector(logOutTapped)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor DonorsChooseGreyVeryLight];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.section==0) {
        return 200;
    } else {
        return 140;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    if (section==0) {
        return [self.datastore.loggedInTeacherProposals count];
    } else {
        return [self.datastore.loggedInTeacherCompletedProposals count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"proposalCell";
    
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ProposalTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    
    if(indexPath.section==0) {
        cell.proposal = [self.datastore.loggedInTeacherProposals objectAtIndex:indexPath.row];
    } else if (indexPath.section ==1) {
        cell.proposal = [self.datastore.loggedInTeacherCompletedProposals objectAtIndex:indexPath.row];
    }
    
    
    return cell;
    
}



- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];

    return YES;
}



-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    
    if(section ==0) {
        headerLabel.text = @"Current Proposals";
    } else {
        headerLabel.text = @"Completed Proposals";
    }
    headerLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:20];
    headerLabel.textColor = [UIColor DonorsChooseGreyVeryLight];
    view.layer.borderColor=[UIColor DonorsChooseGreyLight].CGColor;
    view.layer.borderWidth=1;
    view.layer.shadowOpacity=0.6;
    view.layer.shadowRadius=10;
    view.layer.shadowColor=[UIColor DonorsChooseGrey].CGColor;
    view.layer.shadowOffset=CGSizeMake(2, 2);
    
    [view addSubview:headerLabel];
    view.backgroundColor = [UIColor DonorsChooseOrange];
    
    if (([self.datastore.loggedInTeacherCompletedProposals count] ==0) && section==1) {
        view.hidden=YES;
    } else if (([self.datastore.loggedInTeacherProposals count] ==0) && section==0){
        view.hidden=YES;
    } else {
        view.hidden = NO;
    }
    
    return view;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    [self.tableView setUserInteractionEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    [self.tableView setUserInteractionEnabled:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld", indexPath.row);

    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];
    
    
    if (indexPath.section ==0) {
//        FISDonorsChooseProposal *selectedProposal= self.datastore.loggedInTeacherProposals[indexPath.row];
        tabBarController.navigationItem.title = @"Project";
        tabBarController.selectedProposal=self.datastore.loggedInTeacherProposals[indexPath.row];

        
    } else {
//        FISDonorsChooseCompletedProposal *selectedProposal = self.datastore.loggedInTeacherCompletedProposals[indexPath.row];
        tabBarController.navigationItem.title = @"Project";
        tabBarController.selectedProposal=self.datastore.loggedInTeacherCompletedProposals[indexPath.row];
    }
    

//    NSLog(@"just before deselect code");

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
}


-(void) logOutTapped {
    veryFirstViewController *reLogInViewController = [[veryFirstViewController alloc]init];
    
    
    [self.datastore.loggedInTeacherProposals removeAllObjects];
    [self.datastore.loggedInTeacherCompletedProposals removeAllObjects];
    
    
    [PFUser logOut];
    self.navigationController.viewControllers = @[reLogInViewController];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
