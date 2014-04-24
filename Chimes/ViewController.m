//
//  ViewController.m
//  Chimes
//
//  Created by Ryan Johnson on 4/3/14.
//  Copyright (c) 2014 iPhone SE Group. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

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
    
    buttons = [[NSMutableArray alloc] init];
    for(int i = 0; i < 25; i++) {
        [buttons addObject:[NSNull null]];
    }
    
    NSError *error;
    audio0 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"e2"ofType:@"wav"]] error:&error];
    audio0.delegate = self;
    
    audio1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"c2"ofType:@"wav"]] error:&error];
    audio1.delegate = self;
    
    audio2 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"g"ofType:@"wav"]] error:&error];
    audio2.delegate = self;
    
    audio3 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"e"ofType:@"wav"]] error:&error];
    audio3.delegate = self;
    
    audio4 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"c"ofType:@"wav"]] error:&error];
    audio4.delegate = self;

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
        
        NSInteger columnPositions[25] = { 0, 5, 10, 15, 20, 1, 6, 11, 16, 21, 2, 7, 12, 17, 22, 3, 8, 13, 18, 23, 4, 9, 14, 19, 24 };
        
        [cell addSubview:newBtn];
        [buttons replaceObjectAtIndex:columnPositions[indexPath.row] withObject:newBtn];
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [[NSFileManager defaultManager] createFileAtPath:@"chimes_savefile.txt" contents:[NSData data] attributes:nil];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"chimes_savefile.txt"];
    
    NSMutableString *str = [NSMutableString string];
    for(int i = 0; i < _collectionView.visibleCells.count; i++) {
        UICollectionViewCell *cell = _collectionView.visibleCells[i];
        if(cell.subviews.count == 2) {
            UIButton *button = cell.subviews[1];
            if(button.backgroundColor == [UIColor grayColor]) {
                [str appendString:@"0"];
            } else {
                [str appendString:@"1"];
            }
        }
    }
    [str writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(void)loadPress:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"chimes_savefile.txt"];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    int cellIndex = 0;
    for(int i = 0; i < str.length; i++) {
        //Necessary because bottom cell is index 13
        if(i >= 13)
            cellIndex = i + 1;
        else
            cellIndex = i;
        unichar character = [str characterAtIndex:i];
        UICollectionViewCell *cell = _collectionView.visibleCells[cellIndex];
        UIButton *button = cell.subviews[1];
        if(character == '0')
            button.backgroundColor = [UIColor grayColor];
        else if(character == '1')
            button.backgroundColor = [UIColor redColor];
    }
}

-(void)playPausePress:(id)sender {
    if(playing == false) {
        timerCount = 0;
        playing = true;
        //timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //while(timerCount < buttons.count - 1 && timer != nil) {
            for(int i = 0; i < buttons.count && playing; i++) {
                UIButton *button = buttons[i];
                if(button.backgroundColor == [UIColor redColor]) {
                    if(i % 5 == 0)
                        [audio0 play];
                    else if(i % 5 == 1)
                        [audio1 play];
                    else if(i % 5 == 2)
                        [audio2 play];
                    else if(i % 5 == 3)
                        [audio3 play];
                    else if(i % 5 == 4)
                        [audio4 play];
                }
                if(i % 5 == 4)
                    [NSThread sleepForTimeInterval:1.2];
                if(i == buttons.count - 1)
                    i = 0;
                //[NSThread sleepForTimeInterval:1];
            }
        });
    } else {
        //[timer invalidate];
        //timer = nil;
        playing = false;
    }
}

-(void)resetPress:(id)sender {
    for(UICollectionViewCell *cell in _collectionView.visibleCells) {
        if(cell.subviews.count == 2) {
            UIButton *button = cell.subviews[1];
            button.backgroundColor = [UIColor grayColor];
        }
    }
}

- (void) tick:(NSTimer *) timer {
    timerCount++;
}

@end
