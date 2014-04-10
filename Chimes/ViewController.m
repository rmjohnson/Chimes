//
//  ViewController.m
//  Chimes
//
//  Created by Ryan Johnson on 4/3/14.
//  Copyright (c) 2014 iPhone SE Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(25, 5, 5, 5)];
    
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:_collectionView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIButton *newBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [newBtn setFrame:CGRectMake(0,0,50,50)];
    newBtn.backgroundColor = [UIColor grayColor];
    [newBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:newBtn];
    
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

-(void)buttonPress:(id)sender {
    UIButton *button = sender;
    //Use background color of button to track button state (on or off)
    if(button.backgroundColor == [UIColor grayColor])
        button.backgroundColor = [UIColor redColor];
    else
        button.backgroundColor = [UIColor grayColor];
}

@end
