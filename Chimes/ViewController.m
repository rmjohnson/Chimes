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
    return 26;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if(indexPath.row == 25)
    {
        //Play/Pause button
        UIButton *playPauseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [playPauseBtn setFrame:CGRectMake(100,30,100,20)];
        playPauseBtn.backgroundColor = [UIColor grayColor];
        [playPauseBtn addTarget:self action:@selector(playPausePress:) forControlEvents:UIControlEventTouchUpInside];
        [playPauseBtn setTitle: @"Play/Pause" forState:UIControlStateNormal];
        [playPauseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:playPauseBtn];
        
        //Save button
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setFrame:CGRectMake(100,60,50,20)];
        saveBtn.backgroundColor = [UIColor grayColor];
        [saveBtn addTarget:self action:@selector(savePress:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle: @"Save" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:saveBtn];
        
        //Load button
        UIButton *loadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [loadBtn setFrame:CGRectMake(155,60,50,20)];
        loadBtn.backgroundColor = [UIColor grayColor];
        [loadBtn addTarget:self action:@selector(loadPress:) forControlEvents:UIControlEventTouchUpInside];
        [loadBtn setTitle: @"Load" forState:UIControlStateNormal];
        [loadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:loadBtn];
        
        //Reset button
        UIButton *resetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [resetBtn setFrame:CGRectMake(100,90,100,20)];
        resetBtn.backgroundColor = [UIColor grayColor];
        [resetBtn addTarget:self action:@selector(resetPress:) forControlEvents:UIControlEventTouchUpInside];
        [resetBtn setTitle: @"Reset" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:resetBtn];
    }
    else
    {
        UIButton *newBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [newBtn setFrame:CGRectMake(0,0,50,50)];
        newBtn.backgroundColor = [UIColor grayColor];
        [newBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:newBtn];
    }
    
    cell.backgroundColor=[UIColor blackColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 25)
    {
        return CGSizeMake(310,150);
    }
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

-(void)savePress:(id)sender {
    
}

-(void)loadPress:(id)sender {
    
}

-(void)playPausePress:(id)sender {
    
}

-(void)resetPress:(id)sender {
    
}


@end
