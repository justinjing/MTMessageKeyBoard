//
//  MTMoreView.m
//  MTMessageKeyBoardDemo
//
//  Created by 董徐维 on 2016/12/21.
//  Copyright © 2016年 Mr.Tung. All rights reserved.
//

#import "MTMoreView.h"

#define MTScreenW [UIScreen mainScreen].bounds.size.width

#define MTScreenH [UIScreen mainScreen].bounds.size.height

#import "MTEmojiView.h"
#import "UIView+Extension.h"
#import "MoreCollectionViewCell.h"

@interface MTMoreView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSArray *dataProvider;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UICollectionViewFlowLayout *layout;

@end
@implementation MTMoreView

-(UICollectionViewFlowLayout*)layout
{
    if (!_layout)
        _layout =[[UICollectionViewFlowLayout alloc]init];
    
    _layout.collectionView.pagingEnabled = YES;
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _layout.collectionView.bounces = YES;
    
    return _layout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dataProvider = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MTScreenW, self.height) collectionViewLayout:self.layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[MoreCollectionViewCell class] forCellWithReuseIdentifier:@"MTMoreCollectionViewCell"];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((MTScreenW - self.pageControl.width)/2, CGRectGetMaxY(self.collectionView.frame)+10, 0, 10)];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.userInteractionEnabled = NO;
    
    self.pageControl.numberOfPages = (int)ceil(7 / 8.0);
    self.pageControl.hidden = self.pageControl.numberOfPages == 1;
    [self addSubview:self.pageControl];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = ((scrollView.contentOffset.x - MTScreenW * (self.dataProvider.count / 8)) / MTScreenW);
}

#pragma mark UICollectionViewDelegate

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTMoreCollectionViewCell" forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:@"img_defaulthead_nor"];
    cell.string = @"照片";
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat W = (self.collectionView.bounds.size.width) / 4;
    CGFloat H = (self.collectionView.bounds.size.height) / 2;
    
    return CGSizeMake(W, H);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didSelectItemAtIndexPath)
        self.didSelectItemAtIndexPath(indexPath);
}

@end
