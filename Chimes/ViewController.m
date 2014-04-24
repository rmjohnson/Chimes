//
//  ViewController.m
//  Chimes
//
//  Created by Ryan Johnson on 4/3/14.
//  Copyright (c) 2014 iPhone SE Group. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

UIView *infoView;

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
    if(buttons == nil)
    {
        buttons = [[NSMutableArray alloc] init];
        for(int i = 0; i < 25; i++)
        {
            [buttons addObject:[NSNull null]];
        }
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
        [playPauseBtn setFrame:CGRectMake(65,10,180,30)];
        playPauseBtn.backgroundColor = [UIColor grayColor];
        [playPauseBtn addTarget:self action:@selector(playPausePress:) forControlEvents:UIControlEventTouchUpInside];
        [playPauseBtn setTitle: @"Play/Pause" forState:UIControlStateNormal];
        [playPauseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:playPauseBtn];
        
        //Save button
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setFrame:CGRectMake(65,60,80,30)];
        saveBtn.backgroundColor = [UIColor grayColor];
        [saveBtn addTarget:self action:@selector(savePress:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle: @"Save" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:saveBtn];
        
        //Load button
        UIButton *loadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [loadBtn setFrame:CGRectMake(165,60,80,30)];
        loadBtn.backgroundColor = [UIColor grayColor];
        [loadBtn addTarget:self action:@selector(loadPress:) forControlEvents:UIControlEventTouchUpInside];
        [loadBtn setTitle: @"Load" forState:UIControlStateNormal];
        [loadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:loadBtn];
        
        //Reset button
        UIButton *resetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [resetBtn setFrame:CGRectMake(65,110,180,30)];
        resetBtn.backgroundColor = [UIColor grayColor];
        [resetBtn addTarget:self action:@selector(resetPress:) forControlEvents:UIControlEventTouchUpInside];
        [resetBtn setTitle: @"Reset" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:resetBtn];
        
        //Info button
        UIButton *infoButton=[UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton setTintColor: [UIColor grayColor]];
        [infoButton setFrame:CGRectMake(255,105,50,40)];
        
        [infoButton addTarget:self action:@selector(infoButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        // [infoButton setTitle: @"Help" forState:UIControlStateNormal];
        [infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell addSubview:infoButton];

    }
    else
    {
        NSInteger columnPositions[25] = { 0, 5, 10, 15, 20, 1, 6, 11, 16, 21, 2, 7, 12, 17, 22, 3, 8, 13, 18, 23, 4, 9, 14, 19, 24 };
        
        //Load in save file
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"chimes_savefile.txt"];
        NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        
        UIButton *newBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [newBtn setFrame:CGRectMake(0,0,50,50)];
        if(str != nil)
        {
            unichar character = [str characterAtIndex:columnPositions[indexPath.row]];
            if(character == '0')
                newBtn.backgroundColor = [UIColor grayColor];
            else
                newBtn.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            newBtn.backgroundColor = [UIColor grayColor];
        }
        [newBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        
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


-(void)buttonPress:(id)sender
{
    UIButton *button = sender;
    
    //Use background color of button to track button state (on or off)
    if(button.backgroundColor == [UIColor grayColor])
        button.backgroundColor = [UIColor whiteColor];
    else
        button.backgroundColor = [UIColor grayColor];
}

-(void)savePress:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [[NSFileManager defaultManager] createFileAtPath:@"chimes_savefile.txt" contents:[NSData data] attributes:nil];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"chimes_savefile.txt"];
    
    NSMutableString *str = [NSMutableString string];
    for(int i = 0; i < buttons.count; i++)
    {
        UIButton *button = buttons[i];
        if(button.backgroundColor == [UIColor grayColor])
        {
            [str appendString:@"0"];
        }
        else
        {
            [str appendString:@"1"];
        }
    }
    [str writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(void)loadPress:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"chimes_savefile.txt"];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    for(int i = 0; i < str.length; i++)
    {
        unichar character = [str characterAtIndex:i];
        UIButton *button = buttons[i];
        if(character == '0')
            button.backgroundColor = [UIColor grayColor];
        else if(character == '1')
            button.backgroundColor = [UIColor whiteColor];
    }
}

-(void)playPausePress:(id)sender
{
    if(playing == false)
    {
        timerCount = 0;
        playing = true;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //while(timerCount < buttons.count - 1 && timer != nil) {
            for(int i = 0; i < buttons.count && playing; i++)
            {
                UIButton *button = buttons[i];
                if(button.backgroundColor == [UIColor whiteColor])
                {
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
                    [NSThread sleepForTimeInterval:0.6];
                if(i == buttons.count - 1)
                    i = 0;
            }
        });
    }
    else
    {
        playing = false;
    }
}

-(void)resetPress:(id)sender
{
    for(UICollectionViewCell *cell in _collectionView.visibleCells)
    {
        if(cell.subviews.count == 2)
        {
            UIButton *button = cell.subviews[1];
            button.backgroundColor = [UIColor grayColor];
        }
    }
}

-(void)backPress
{
    [self viewDidLoad];
    [self loadPress:0];
}

-(IBAction)infoButtonPress:(id)sender
{
    [self savePress:0];
    
    infoView = [[UIView alloc]init];
    infoView.frame = CGRectMake(0, 0, 480, 320);
    infoView.backgroundColor = [UIColor whiteColor];
    self.view = infoView;
    
    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
    textLabel1.font = [UIFont systemFontOfSize:12];
    textLabel1.text = @"Begin by pressing an individual cell.";
    [infoView addSubview:textLabel1];
    
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 40)];
    textLabel2.font = [UIFont systemFontOfSize:12];
    textLabel2.text = @"Each cell contains a unique sound.";
    [infoView addSubview:textLabel2];
    
    UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    textLabel3.font = [UIFont systemFontOfSize:12];
    textLabel3.text = @"Press as many cells as you would like to hear.";
    [infoView addSubview:textLabel3];
    
    UILabel *textLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 40)];
    textLabel4.font = [UIFont systemFontOfSize:12];
    textLabel4.text = @"Once finished, press play to hear what you created.";
    [infoView addSubview:textLabel4];
    
    UILabel *textLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textLabel5.font = [UIFont systemFontOfSize:12];
    textLabel5.text = @"You can reset the grid by pressing the reset button.";
    [infoView addSubview:textLabel5];
    
    //creates the back button and calls new method to control its action
    UIButton *backBtn=[[UIButton alloc] initWithFrame:CGRectMake(250,400,60,60)];
    [backBtn addTarget:self action: @selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle: @"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [infoView addSubview:backBtn];
}



@end
