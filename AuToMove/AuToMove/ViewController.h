//
//  ViewController.h
//  AuToMvoeView
//
//  Created by hcui on 13-8-9.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollview;
    CGPoint startPoint;
    BOOL isTouchSV;
    int suoyin;
    NSTimer *autoScrollTimer;
    NSMutableArray *viewArray;
    BOOL back;
}
@property (nonatomic,assign) NSInteger currentpage;
@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,assign) NSTimeInterval  autoScrollDelayTime;
@property (retain,nonatomic) IBOutlet UIScrollView *scrollview;

@end
