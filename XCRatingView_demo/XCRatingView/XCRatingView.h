//
//  XCRatingView.h
//  Progress_demo
//
//  Created by wxc on 15/6/17.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 星级评分
 */
@interface XCRatingView : UIView

@property (nonatomic, assign) NSUInteger totalCount;    //总个数
@property (nonatomic, assign) CGSize itemSize;          //每个item的大小
@property (nonatomic, assign) CGFloat selectCount;      //所选个数，0.5为单位，初始化为0
@property (nonatomic, strong) UIImage *selectImage;     //选择状态图片，整
@property (nonatomic, strong) UIImage *selectHalfImage; //选择状态图片，半
@property (nonatomic, strong) UIImage *unSelectImage;   //未选择状态图片


/**
 选取回调，可选
 */
@property (nonatomic, strong) void (^ratingSelectAction)(CGFloat selectCount);

@end
