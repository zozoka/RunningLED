//
//  ViewController.m
//  RunningLed
//
//  Created by thanh tung on 11/18/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

{
    CGFloat _margin;
    CGFloat _space;
    CGFloat _diameterBall;
    CGFloat _y;
    int _lastOnLed;
    int _lastOnLed2;
    NSTimer* _time;
    NSTimer* _time2;
    int _numberOfBall;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self placeGreenBallWithX:100 andY:100 andTag:1];
    //[self checkSizeApp];
    _margin = 40.0;
    _diameterBall = 24.0;
    _lastOnLed = -1;
    
    _numberOfBall = 91; // number ball in view
    _lastOnLed2 = _numberOfBall;
    
    [self drawBallsInView:_numberOfBall];
    _time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    _time2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED2) userInfo:nil repeats:true];
}

-(void) runningLED{
    if (_lastOnLed != -1) {
        [self turnOffLED:_lastOnLed];
    }
    if (_lastOnLed != _numberOfBall-1) {
        _lastOnLed ++;
    }else{
        _lastOnLed = 0;
    }
    //NSLog(@"index %d",_lastOnLed);
    [self turnOnLED:_lastOnLed];
}

-(void) runningLED2{
    if (_lastOnLed2 != -1) {
        [self turnOffLED:_lastOnLed2];
    }
    if (_lastOnLed2 != 0) {
        _lastOnLed2 --;
    }else{
        _lastOnLed2 = _numberOfBall-1;
    }
    //NSLog(@"index %d",_lastOnLed);
    [self turnOnLED:_lastOnLed2];
}


-(void) turnOnLED: (int) index{
    //NSLog(@"turn on index: %d",index);
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

-(void) turnOffLED: (int) index{
    //NSLog(@"turn off index: %d", index);
    UIView* view = [self.view viewWithTag: index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"grey"];
    }
}

- (void) placeGreenBallWithX: (CGFloat)x
                        andY:(CGFloat)y
                      andTag:(int)tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];

}



-(void) drawBallsInView:(int) numberBall{
    int numberMaxBall = [self maxBallinRow];
    CGFloat space = [self spaceBetweenBallCenterWhenBallIsKnown:numberMaxBall];
    int temp = 0; // biến tạm đếm số bóng
    int rows = (int)numberBall/numberMaxBall + 1; // số dòng theo số lượng bóng;
    _y = [self spaceBetweenBallCenterWhenBallIsKnown:numberMaxBall]; //  = khoảng cách giữa 2 quả bóng giữa các dòng.
    for(int i=0; i < rows; i++){
        for (int j=0; j<numberMaxBall; j++) {
            if(temp == numberBall){
                return;
            }
            [self placeGreenBallWithX: _margin+j*space andY:100+_y*i andTag:temp+100];
            temp++;
            NSLog(@"so bong %d",temp);
        }
    }
    
}


-(void) numberOfBallvsSpace{
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenBallIsKnown:n];
        if (space <= _diameterBall) {
            stop = true;
        }else{
            NSLog(@"Ball = %d space between center balls : %3.0f", n,space);
        }
        n++;
    }
}

-(int) maxBallinRow{
    int n = 3;
    bool stop = false;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenBallIsKnown:n];
        if (space <= _diameterBall) {
            stop = true;
        }else{
            NSLog(@"Ball = %d space between center balls : %3.0f", n,space);
            n++;
        }
        
    }
    NSLog(@"max: %d",n-1);
    return n-1;
}

-(CGFloat) spaceBetweenBallCenterWhenBallIsKnown:(int) n{
    return (self.view.bounds.size.width - 2*_margin)/(n-1);
}

-(void) checkSizeApp{
    CGSize size = self.view.bounds.size;
    NSLog(@"with: %3.0f Height: %3.0f",size.width,size.height);
}

@end
