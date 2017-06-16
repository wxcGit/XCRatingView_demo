//
//  ViewController.m
//  XCRatingView_demo
//
//  Created by wxc on 16/6/17.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import "ViewController.h"
#import "XCRatingView.h"
@interface ViewController ()

@property(nonatomic, strong) UILabel *rationLabel;
@property (nonatomic, strong) XCRatingView *rationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.rationLabel];
    
    [self.view addSubview:self.rationView];
}

- (UILabel*)rationLabel
{
    if (!_rationLabel) {
        _rationLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 150, 50)];
        _rationLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _rationLabel;
}

- (XCRatingView*)rationView
{
    if (!_rationView) {
        _rationView = [[XCRatingView alloc]initWithFrame:CGRectMake(100, 200, 150, 20)];
        _rationView.totalCount = 5;
        _rationView.selectImage = [UIImage imageNamed:@"star_full"];
        _rationView.unSelectImage = [UIImage imageNamed:@"star_none"];
        _rationView.selectHalfImage = [UIImage imageNamed:@"star_half"];
        _rationView.itemSize = CGSizeMake(20, 20);
        
        __weak typeof(self) weakSelf = self;
        _rationView.ratingSelectAction = ^(CGFloat selectCount){
            weakSelf.rationLabel.text = [NSString stringWithFormat:@"%.2lf",selectCount];
        };
    }
    
    return _rationView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
