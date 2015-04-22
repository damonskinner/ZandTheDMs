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
#import "ContainerViewController.h"
#import "CongratulationsViewController.h"
#import <Parse.h>
#import <FAKIonIcons.h>
#import "ImagesAPI.h"
#import "FISParseAPI.h"

@interface HomePageTableViewController () <UIScrollViewDelegate>

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];
    
    [self.tableView deselectRowAtIndexPath:nil animated:YES];
    
    UIImage *placeHolderImage = [UIImage imageNamed:@"iTunesArtwork@2x"];
    
    UIImage *formattedPlaceHolder = [self formatImageWithGradient:placeHolderImage];
    
    [self setHeaderImage:formattedPlaceHolder];
    
    [ImagesAPI getImageWithURLString:self.datastore.loggedInTeacher.photoURL andCompletion:^(UIImage *teacherImage) {
        self.datastore.loggedInTeacher.image=teacherImage;
        UIImage *formattedTeacherImage = [self formatImageWithGradient:self.datastore.loggedInTeacher.image];
        [self setHeaderImage:formattedTeacherImage];
        
    }];
//    [self setHeaderImage:self.datastore.loggedInTeacher.image];
    [self setTitleText:self.datastore.loggedInTeacher.name];
    [self setSubtitleText:self.datastore.loggedInTeacher.schoolName];
//    [self setLabelBackgroundGradientColor:[UIColor blackColor]];

    
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
    
    if ([self.datastore.decodedDeviceToken length]>0) {
        [FISParseAPI getInstallationObjectIdForDeviceToken:self.datastore.decodedDeviceToken andCompletionBlock:^(NSString * installationObjectId) {
            if ([installationObjectId length]>0) {
                [FISParseAPI attachTeacherId:self.datastore.loggedInTeacher.teacherId toInstallationWithObjectId:installationObjectId andCompletionBlock:^{
                    
                }];
            }
            
        }];
    }
    

//    UIImage *gearIconImage = [[FAKIonIcons gearAIconWithSize:25] imageWithSize:CGSizeMake(25,25)] ;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:gearIconImage style:UIBarButtonItemStylePlain target:self action:@selector(logOutTapped)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOutTapped)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor DonorsChooseGreyVeryLight];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.datastore.totalUnRespondedDonations=0;
    for (FISDonorsChooseProposal *eachProposal in self.datastore.loggedInTeacherProposals) {
        self.datastore.totalUnRespondedDonations +=eachProposal.numDonationsNeedResponse;

    }
    [UIApplication sharedApplication].applicationIconBadgeNumber =self.datastore.totalUnRespondedDonations;
    if ([self.datastore.decodedDeviceToken length]>0) {
        [FISParseAPI getInstallationObjectIdForTeacherId:self.datastore.loggedInTeacher.teacherId andCompletionBlock:^(NSString *objectId) {
            if ([objectId length]>0) {
                [FISParseAPI updateBadgeNumber:@(self.datastore.totalUnRespondedDonations) forInstallationWithObjectId:objectId andCompletionBlock:^{
                    
                }];
            }
        }];
    }
    [self.tableView reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.section==0) {
        return 180;
    } else {
        return 180;
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
    
    if(cell.completionButton)
    {
        [cell.completionButton addTarget:self action:@selector(segueToCompletionFlow:) forControlEvents:UIControlEventTouchUpInside];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 30)];
    
    if(section ==0) {
        headerLabel.text = @"Current Projects";
    } else {
        headerLabel.text = @"Completed Projects";
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
    
    [view removeConstraints:view.constraints];
    [headerLabel removeConstraints:headerLabel.constraints];
    headerLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *headerLabelCenterY = [NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [view addConstraint:headerLabelCenterY];
    
    NSLayoutConstraint *headerLabelLeft = [NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:0];
    [view addConstraint:headerLabelLeft];
    
    
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


-(UIImage *) formatImageWithGradient: (UIImage *) image {
    
    UIImageView *testView = [[UIImageView alloc] initWithImage:image];
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
    
    return newImage;
}

-(void) segueToCompletionFlow: (id) sender
{
    UIButton *theButton = (UIButton*) sender;
    UIView *contentView = [theButton superview];
    ProposalTableViewCell *theCell = (ProposalTableViewCell*)[contentView superview];
    FISDonorsChooseProposal *selectedProposal = theCell.proposal;

    UIStoryboard *completionFlowStoryboard = [UIStoryboard storyboardWithName:@"CompletionFlow" bundle:nil];
    
    if(![selectedProposal.completionInfo[@"fundingConfirmed"] isEqualToString: @"YES"])
    {
        ContainerViewController *containerVC = [completionFlowStoryboard instantiateInitialViewController];
        containerVC.proposal = selectedProposal;
        [self.navigationController presentViewController:containerVC animated:YES completion:nil];
    }
    else
    {
        UINavigationController *navController = [[UINavigationController alloc]init];
        
        CongratulationsViewController *congratsVC = [completionFlowStoryboard instantiateViewControllerWithIdentifier:@"congratulationsVC"];
        congratsVC.proposal = selectedProposal;
        
        [navController addChildViewController:congratsVC];
        
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
}





@end
