//
//  ViewController.m
//  AuToMvoeView
//
//  Created by hcui on 13-8-9.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ViewController.h"

#define BUTTONNUMBER 8
@interface ViewController ()

@end


@implementation ViewController
@synthesize scrollview;
@synthesize viewArray;
@synthesize currentpage;
@synthesize autoScrollDelayTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.autoScrollDelayTime=2.0;
    self.scrollview.contentSize = CGSizeMake(80*BUTTONNUMBER, 60);
    self.viewArray=[[NSMutableArray alloc]init];
    for (int i=0; i<BUTTONNUMBER; i++)
    {
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(320/4*i, 6, 80,60)];
        buttonView.backgroundColor = [UIColor clearColor];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(5, 0, 70, 35);
        button.tag = i;
        [buttonView addSubview:button];
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:buttonView];
        [self.viewArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self shouldAutoShow:YES];
    back=false;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self userInteractionEnabled:NO];
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint currentPoint =[touch locationInView:self.view];
    if (CGRectContainsPoint(self.scrollview.frame, currentPoint))
    {
        isTouchSV = YES;
        startPoint = currentPoint;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint endPoint =[touch locationInView:self.view];
     
    if (isTouchSV)
    {
        float dx = endPoint.x - startPoint.x;
        float dy = fabsf(endPoint.y - startPoint.y);
   
        float huangdongfanwei = self.scrollview.frame.size.width/4;
        if (dx < -50 && dy < 30) {
            suoyin += -dx / 50;
            if (suoyin>4) suoyin =3;
        }
        if (dx > 50 && dy < 30) {
            suoyin -= dx / 50;
            if (suoyin<0) suoyin = 0;
        }
        [self.scrollview setContentOffset:CGPointMake(suoyin*huangdongfanwei, 0) animated:YES];
        isTouchSV = !isTouchSV;
    }
    self.currentpage=suoyin;
}
-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart) {
        if ([autoScrollTimer isValid]) {
            
        }
        else
        {
        autoScrollTimer=[NSTimer scheduledTimerWithTimeInterval:autoScrollDelayTime target:self selector:@selector(autoShowNext) userInfo:nil repeats:YES];
        }
    }
    else
    {
        if ([autoScrollTimer isValid]) {
            [autoScrollTimer invalidate];
            autoScrollTimer = nil;
        }
    }
}

-(void)autoShow
{
   
}

-(void)autoShowNext
{
    
    if (back==false || currentpage==0) {
         
        currentpage++;
        if (currentpage==[self.viewArray count]-4) {
            back=true;
        }
        float huangdongfanwei = self.scrollview.frame.size.width/4;
            
        [self.scrollview setContentOffset:CGPointMake(currentpage*huangdongfanwei, 0) animated:YES];
    }
    else if(back)
    {
        currentpage--;
        if (currentpage==0) {
            back=false;
        }
        float huangdongfanwei = self.scrollview.frame.size.width/4;
        
        [self.scrollview setContentOffset:CGPointMake(currentpage*huangdongfanwei, 0) animated:YES];
    }
    
}
-(void) selectBtn:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);

}

//滑动效果停止的时候
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView  
{

}

-(void)userInteractionEnabled:(BOOL )touch
{
    self.scrollview.userInteractionEnabled=touch;
}
- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
