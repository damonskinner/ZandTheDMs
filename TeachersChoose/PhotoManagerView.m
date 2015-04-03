//
//  PhotoManagerView.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "PhotoManagerView.h"
#import "CompletionImageCollectionViewCell.h"
@interface PhotoManagerView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation PhotoManagerView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self addSubview: self.view];
        [self initialSetup];
        
    }
    return self;
    
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                  owner:self
                                options:nil];
    
    [self addSubview:self.view];
    [self initialSetup];
    
    return self;
}


-(void) initialSetup
{
    
    
    // make sure we dont break the collection view
    if (self.picturesForUpload == nil)
    {
        self.picturesForUpload = [[NSMutableArray alloc] init];
    }
    
    // fill the collection view with any necessary placeholders
    while ([self.picturesForUpload count] < 6)
    {
        [self.picturesForUpload addObject: [UIImage imageNamed:@"tapHereIcon"]];
    }
    
    // setup collectionView
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
}

#pragma mark - UICollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.picturesForUpload count];
}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    CompletionImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:<#(NSString *)#> forIndexPath:<#(NSIndexPath *)#>]
////    
////    if (cell == nil)
//    
//        
//    
//}


@end
