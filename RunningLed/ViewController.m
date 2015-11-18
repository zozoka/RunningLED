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
    int _numberBall;
    CGFloat _space;
    CGFloat _diameterBall;
    CGFloat _y;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self placeGreenBallWithX:100 andY:100 andTag:1];
    //[self checkSizeApp];
    _margin = 40.0;
    _diameterBall = 24.0;
    [self drawBallsInView:100];
}

- (void) placeGreenBallWithX: (CGFloat)x
                        andY:(CGFloat)y
                      andTag:(int)tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
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
            [self placeGreenBallWithX: _margin+j*space andY:100+_y*i andTag:i+j];
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
