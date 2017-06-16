//
//  XCRatingView.m
//  Progress_demo
//
//  Created by wxc on 15/6/17.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import "XCRatingView.h"


/**
 item
 */
@interface XCRatingViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *selectImageView;

@end

/**
 ratingView
 */
@interface XCRatingView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *ratingCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *ratingFlowLayout;

@end

@implementation XCRatingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ratingCollectionView];
    }
    return self;
}

- (UICollectionView*)ratingCollectionView
{
    if (!_ratingCollectionView) {
        _ratingCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.ratingFlowLayout];
        _ratingCollectionView.dataSource = self;
        _ratingCollectionView.delegate = self;
        _ratingCollectionView.backgroundColor = [UIColor clearColor];
        [_ratingCollectionView registerClass:[XCRatingViewCell class] forCellWithReuseIdentifier:@"XCRatingViewCell"];
        _ratingCollectionView.scrollEnabled = NO;
        _ratingCollectionView.userInteractionEnabled = NO;
    }
    
    return _ratingCollectionView;
}

- (UICollectionViewFlowLayout*)ratingFlowLayout
{
    if (!_ratingFlowLayout) {
        _ratingFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _ratingFlowLayout.minimumLineSpacing = 0;
        _ratingFlowLayout.minimumInteritemSpacing = 0;
    }
    
    return _ratingFlowLayout;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_ratingCollectionView reloadData];
}

- (void)setSelectCount:(CGFloat)selectCount
{
    _selectCount = selectCount;
    [_ratingCollectionView reloadData];
}

#pragma mark collectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.ratingCollectionView.frame.size.width / self.totalCount, self.ratingCollectionView.frame.size.height);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCRatingViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCRatingViewCell" forIndexPath:indexPath];

    CGFloat offset = round(_selectCount * 2.0) / 2.0;
    if (indexPath.row < floor(offset)) {//选择的图片
        cell.selectImageView.image = self.selectImage;
    }else if (indexPath.row == floor(offset) && floor(offset) != ceil(offset)){
        if (self.selectHalfImage) {
            cell.selectImageView.image = self.selectHalfImage;
        }else{
            cell.selectImageView.image = self.selectImage;
        }
    }else{
        cell.selectImageView.image = _unSelectImage;
    }
    
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleToush:[[touches allObjects] firstObject]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleToush:[[touches allObjects] firstObject]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleToush:[[touches allObjects] firstObject]];
}

- (void)handleToush:(UITouch*)touch
{
    CGPoint touchPoint = [touch locationInView:self.ratingCollectionView];
    CGFloat offset = touchPoint.x / _ratingCollectionView.frame.size.width * _totalCount;
    offset = round(offset * 2.0) / 2.0;
    
    offset = (offset >= 0)?offset:0;
    offset = (offset <= _totalCount)?offset:_totalCount;
    self.selectCount = offset;
    
    if (_ratingSelectAction) {
        _ratingSelectAction(_selectCount);
    }
}

@end

@implementation XCRatingViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectImageView];
    }
    return self;
}

- (UIImageView*)selectImageView
{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _selectImageView;
}

@end
