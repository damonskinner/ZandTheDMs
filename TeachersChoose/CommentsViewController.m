//
//  CommentsViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/13/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsViewController.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseCompletedProposal.h"
#import "FISDonorsChooseDatastore.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
#import "DetailsTabBarController.h"
#import "FISDonation.h"
#import "FISConstants.h"
#import "FISInputCommentCell.h"


@interface CommentsViewController () 

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;
//@property (strong, nonatomic) NSMutableDictionary *commentsDictionary;
@property (strong, nonatomic) NSMutableArray *orderedListOfDonors;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISegmentedControl *mySegmentedControl;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) NSInteger selectedDonation;

@property (nonatomic, strong) FISDonorsChooseDatastore   *datastore;
@property (nonatomic, strong) NSMutableArray *donationsWhichNeedResponse;




-(void) setupSegmentedControl;
-(void) prepareTableViewForResizingCells;
-(void) populateDonationsWhichNeedResponseArray;
//-(void) populateCommentsDictionary;



@end


NSString * const INPUT_CELL_IDENTIFIER = @"inputCell";
NSString * const BASIC_CELL_IDENTIFIER = @"basicCell";

@implementation CommentsViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    self.datastore=[FISDonorsChooseDatastore sharedDataStore];
    self.donationsWhichNeedResponse = [[NSMutableArray alloc]init];
//    [self populateDonationsWhichNeedResponseArray];

    [self setupSegmentedControl];
    [self setupLayout];
    //    [self populateCommentsDictionary];
    [self prepareTableViewForResizingCells];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.navigationController.navigationBarHidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"reloadTheTable" object:nil];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.proposal.donations removeAllObjects];
    [self.donationsWhichNeedResponse removeAllObjects];
    
    if([self.proposal isKindOfClass:[FISDonorsChooseCompletedProposal class]]){
        [self populateDonationsWithFakeRespondedDonations];
    } else {
        [self.datastore getDonationsListForProposal:self.proposal andCompletion:^(BOOL completed) {
            [self populateDonationsWhichNeedResponseArray];
            [self.myTableView reloadData];
        }];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING");
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.mySegmentedControl.selectedSegmentIndex==0) {
        return [self.donationsWhichNeedResponse count];
    } else {
        return [self.proposal.donations count];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(self.mySegmentedControl.selectedSegmentIndex==0) {
        if (indexPath.row==1) {



            FISInputCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:INPUT_CELL_IDENTIFIER];
            if (!cell) {
                cell = [[FISInputCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INPUT_CELL_IDENTIFIER];
            }
            cell.CommentsViewController=self;
            //        cell.parentTableView = tableView;
            cell.placeholder = INPUT_CELL_PLACEHOLDER;
            return cell;
            
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: BASIC_CELL_IDENTIFIER];
            if (!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASIC_CELL_IDENTIFIER];
            }

            if ([((FISDonation *)self.donationsWhichNeedResponse[indexPath.section]).donorMessage length]>0) {
                [self formatCell: cell forBasicDisplaywithMessage: ((FISDonation *)self.donationsWhichNeedResponse[indexPath.section]).donorMessage andIndexPath:indexPath];
               

                return cell;
                
            } else {
                [self formatCell: cell forBasicDisplaywithMessage: [NSString stringWithFormat:@"%@ from %@ donated.",((FISDonation *)self.donationsWhichNeedResponse[indexPath.section]).donorName,((FISDonation *)self.donationsWhichNeedResponse[indexPath.section]).donorLocation] andIndexPath:indexPath];

                return cell;
            }
        }
    } else {
        if (indexPath.row==1) {
            if ([((FISDonation *)self.proposal.donations[indexPath.section]).responseMessage length]<1) {
                FISInputCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:INPUT_CELL_IDENTIFIER];
                if (!cell) {
                    cell = [[FISInputCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INPUT_CELL_IDENTIFIER];
                }
                cell.CommentsViewController=self;
                //        cell.parentTableView = tableView;
                cell.placeholder = INPUT_CELL_PLACEHOLDER;
                return cell;
                
            } else {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: BASIC_CELL_IDENTIFIER];
                if (!cell){
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASIC_CELL_IDENTIFIER];
                }
                [self formatCell: cell forBasicDisplaywithMessage: ((FISDonation *)self.proposal.donations[indexPath.section]).responseMessage andIndexPath:indexPath];
                return cell;
                
            }
            
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: BASIC_CELL_IDENTIFIER];
            if (!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASIC_CELL_IDENTIFIER];
            }
            if ([((FISDonation *)self.proposal.donations[indexPath.section]).donorMessage length]>0) {
                [self formatCell: cell forBasicDisplaywithMessage: ((FISDonation *)self.proposal.donations[indexPath.section]).donorMessage andIndexPath:indexPath];

                return cell;
                
            } else {
                [self formatCell: cell forBasicDisplaywithMessage: [NSString stringWithFormat:@"%@ from %@ donated.",((FISDonation *)self.proposal.donations[indexPath.section]).donorName,((FISDonation *)self.proposal.donations[indexPath.section]).donorLocation] andIndexPath:indexPath];
                return cell;
            }
        }
    }
    
    
    
    
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0,0, tableView.frame.size.width, 30)];
    


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 30)];

    [label setFont:[UIFont fontWithName:DonorsChooseTitleBoldFont size:20]];
    NSString *titleString;
    if(self.mySegmentedControl.selectedSegmentIndex==0) {
        titleString= [NSString stringWithFormat:@"%@", ((FISDonation *) self.donationsWhichNeedResponse[section]).donorName];
    } else {
        titleString= [NSString stringWithFormat:@"%@", ((FISDonation *) self.proposal.donations[section]).donorName];
    }
    
    [label setText:titleString];
    [view addSubview:label];

    view.backgroundColor = [UIColor DonorsChooseGreyLight];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30; // just seemed like a magical number
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // height-less because we implement tableView:heightForFooterInSection:
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0,0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor DonorsChooseWhite];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10; // just seemed like a magical number
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.myTableView) {
            CGFloat cornerRadius = 8.f;
            cell.backgroundColor = [UIColor DonorsChooseGreyVeryLight];
            
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = (CGRectInset(cell.bounds, 10, 3));
            if (indexPath.row==0) {
                layer.fillColor = [UIColor DonorsChooseOrange].CGColor;
                CGPathMoveToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMinY(bounds));  //topcenter
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds)-5);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds)-5, CGRectGetMaxY(bounds)+3);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds)+10, CGRectGetMaxY(bounds));
                

                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMinY(bounds));
            } else {
                layer.fillColor = [UIColor clearColor].CGColor;
                layer.strokeColor=[UIColor DonorsChooseOrange].CGColor;

                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMinY(bounds));  //topcenter
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds)-5);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds)+5, CGRectGetMaxY(bounds)+3);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds)-10, CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMinX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMinY(bounds));
                
            }

            
            layer.path = pathRef;
            CFRelease(pathRef);
            

            
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}
#pragma mark - Formatting Helpers




-(void) prepareTableViewForResizingCells
{
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 50.0;
}


-(void) formatCell:(UITableViewCell*) cell forBasicDisplaywithMessage: (NSString*) comment andIndexPath: (NSIndexPath *) indexPath
{
    cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = comment;

    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self formatCell: cell byCommentTypeWithMessage:comment andIndexPath: indexPath];
}

-(void) formatCell: (UITableViewCell*) cell byCommentTypeWithMessage: (NSString *) comment andIndexPath: (NSIndexPath *) indexPath
{
    // !!! need to have counter-acting actions in each since cells are reusable
    if (indexPath.row==0)
    {
        cell.backgroundColor = [UIColor DonorsChooseGreyLight];
        cell.textLabel.textColor=[UIColor DonorsChooseGreyVeryLight];
        cell.textLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:17];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.indentationLevel = 0;
    }
    else
    {
        cell.backgroundColor = [UIColor DonorsChooseGreyVeryLight];
        cell.textLabel.textColor=[UIColor DonorsChooseOrange];
        cell.textLabel.font = [UIFont fontWithName:DonorsChooseBodyItalicFont size:17];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.indentationLevel = 3;
    }
}

#pragma mark - Initialization Helpers

-(void) setupLayout {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text=[NSString stringWithFormat:@"%@ (%@)",self.proposal.title ,self.proposal.proposalId];
    self.titleLabel.font=[UIFont fontWithName:DonorsChooseTitleBoldFont size:20];
    self.titleLabel.textColor=[UIColor DonorsChooseBlack];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.myTableView = [[UITableView alloc]init];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.myTableView];
    self.view.backgroundColor=[UIColor DonorsChooseWhite];
    

    [self.mySegmentedControl removeConstraints:self.mySegmentedControl.constraints];
    [self.myTableView removeConstraints:self.myTableView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.view removeConstraints:self.view.constraints];
    
    [self.myTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mySegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSDictionary *views = @{@"view":self.view,@"segmentedControl":self.mySegmentedControl,@"titleLabel":self.titleLabel,@"tableView":self.myTableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel(view)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedControl(view)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLabel(80)][segmentedControl(35)]-[tableView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views]];
}

-(void) setupSegmentedControl
{
    self.mySegmentedControl= [[UISegmentedControl alloc] initWithItems:@[@"Awaiting Reply", @"All"]];
    self.mySegmentedControl.selectedSegmentIndex = 0;
    [self.mySegmentedControl addTarget:self action:@selector(segmentedControlToggler) forControlEvents:UIControlEventValueChanged];
    self.mySegmentedControl.layer.borderWidth=1;
    self.mySegmentedControl.layer.borderColor =[UIColor DonorsChooseOrange].CGColor;
    self.mySegmentedControl.tintColor=[UIColor DonorsChooseOrange];
    [self.view addSubview:self.mySegmentedControl];
}

-(void) segmentedControlToggler {
    [self.donationsWhichNeedResponse removeAllObjects];
    [self populateDonationsWhichNeedResponseArray];
    [self.myTableView reloadData];
    [self prepareTableViewForResizingCells];
}


-(void) saveDonationWithMessage:(NSString *)responseMessage andIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@ for donation: %ld",responseMessage, indexPath.section);

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Send Confirmation"
                                                                   message:@"Are you really really sure you want to send this message?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              if (self.mySegmentedControl.selectedSegmentIndex==0) {
                                                                  [self.datastore addNewDonationResponseMessage:responseMessage forDonation:self.donationsWhichNeedResponse[indexPath.section] forProposal:self.proposal andCompletion:^(BOOL completion) {
                                                                      
                                                                      
                                                                  }];
                                                              } else {
                                                                  [self.datastore addNewDonationResponseMessage:responseMessage forDonation:self.proposal.donations[indexPath.section] forProposal:self.proposal andCompletion:^(BOOL completion) {
                                                                  }];
                                                                  
                                                              }
                                                              [self.donationsWhichNeedResponse removeAllObjects];
                                                              [self populateDonationsWhichNeedResponseArray];
                                                              [self.myTableView reloadData];
                                                              [self prepareTableViewForResizingCells];
                                                              
                                                          }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES  completion:nil];
    
}


-(void) populateDonationsWhichNeedResponseArray {
    for (FISDonation *eachDonation in self.proposal.donations) {
        if (!(eachDonation.hasResponded)) {
            [self.donationsWhichNeedResponse addObject:eachDonation];

        }
        
    }
    
}

- (void)reloadTable:(NSNotification *)notification
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Notification Received"
                                                                   message:@"You just received a new donation!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [self.proposal.donations removeAllObjects];
    [self.donationsWhichNeedResponse removeAllObjects];
    
    
    
    if([self.proposal isKindOfClass:[FISDonorsChooseCompletedProposal class]]){
        [self populateDonationsWithFakeRespondedDonations];
    } else {
        [self.datastore getDonationsListForProposal:self.proposal andCompletion:^(BOOL completed) {
            [self populateDonationsWhichNeedResponseArray];
            [self.myTableView reloadData];
        }];
    }
}

-(void) populateDonationsWithFakeRespondedDonations {
    FISDonation *donation0=[[FISDonation alloc]initWithName:@"Johnny B. Gud" Location:@"San Francisco" Date:[NSDate date] DonorMessage:@"Good luck!" ResponseMessage:@"Thanks!" DonationAmount:@"35.00"];
    FISDonation *donation1=[[FISDonation alloc]initWithName:@"Sandra Kyles" Location:@"New York" Date:[NSDate date] DonorMessage:@"Nice job" ResponseMessage:@"You're the best!  Thank you!" DonationAmount:@"5.00"];
    FISDonation *donation2=[[FISDonation alloc]initWithName:@"Bartholomew Cubbins" Location:@"Idaho" Date:[NSDate date] DonorMessage:@"Wow, keep up the good work!" ResponseMessage:@"Wow, thanks!" DonationAmount:@"2.00"];
    FISDonation *donation3=[[FISDonation alloc]initWithName:@"Mimi Dieter" Location:@"Hawaii" Date:[NSDate date] DonorMessage:@"Yay learning!" ResponseMessage:@"Thank you so much!" DonationAmount:@"40.00"];
    FISDonation *donation4=[[FISDonation alloc]initWithName:@"Adam Jones" Location:@"Miami" Date:[NSDate date] DonorMessage:@"Neat" ResponseMessage:@"Incredible, thanks!" DonationAmount:@"6.00"];
    FISDonation *donation5=[[FISDonation alloc]initWithName:@"Clarissa Starling" Location:@"Texas" Date:[NSDate date] DonorMessage:@"Good job!  Hope they learn a lot." ResponseMessage:@"So generous, thank you!" DonationAmount:@"100.00"];
    FISDonation *donation6=[[FISDonation alloc]initWithName:@"Johnny English" Location:@"Ohio" Date:[NSDate date] DonorMessage:@"Super fun!" ResponseMessage:@"Thanks!" DonationAmount:@"80.00"];
    FISDonation *donation7=[[FISDonation alloc]initWithName:@"Chad Hemmingsworth" Location:@"Chicago" Date:[NSDate date] DonorMessage:@"What a cool project.  Those kids sure are lucky" ResponseMessage:@"Wow, thank you so much!" DonationAmount:@"20.00"];
    FISDonation *donation8=[[FISDonation alloc]initWithName:@"Jasmine Yee" Location:@"Illinois" Date:[NSDate date] DonorMessage:@"Cooooool!" ResponseMessage:@"Thank you." DonationAmount:@"10.00"];
    FISDonation *donation9=[[FISDonation alloc]initWithName:@"Charlotte Kelly" Location:@"Los Angeles" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"Oh my word, thank you!!!" DonationAmount:@"400.00"];
    
    self.proposal.donations=[@[donation0,donation1,donation2,donation3,donation4,donation5,donation6,donation7,donation8,donation9] mutableCopy];
    
}
        

@end