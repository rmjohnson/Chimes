//
//  ViewController.h
//  Chimes
//
//  Created by Ryan Johnson on 4/3/14.
//  Copyright (c) 2014 iPhone SE Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *buttons;
    int timerCount;
    AVAudioPlayer *theAudio;
}
@end

