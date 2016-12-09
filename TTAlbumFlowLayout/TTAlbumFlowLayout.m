//
//  TTAlbumFlowLayout.m
//  https://github.com/JadynSky/TTAlbumFlowLayout
//
//  Created by WuZhongTian on 15/12/10.
//  Copyright © 2015年 WuZhongTian. All rights reserved.
//

#import "TTAlbumFlowLayout.h"

@implementation TTAlbumFlowLayout
static const CGFloat myHeight = 100;
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}


//核心内容
/**每个Cell都有它单独的一套UICollectionViewLayoutAttributes(布局属性)  可以用来实时监听cell的各种参数
 *每个indexPath也都有它单独的一套UICollectionViewLayoutAttributes(布局属性)
 *
 */



//这个函数放在第一位:当开始布局了就会执行这个监听,而且这样只要移动一点就会一直持续刷新UICollectionViewLayoutAttributes(布局属性)
//这个函数返回BOOL-----是否在当cell的边缘发生改变的时候刷新UICollectionViewLayoutAttributes(布局属性)
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 *用来控制scrollView停止滚动的那一刻的位置
 *targetContentOffset:是指设定后(希望停在的)scrollView停止滚动的那一刻的位置
 *ProposedContentOffset:是原本scrollView停止滚动的那一刻的位置
 *velocity:滚动的速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算scrollView最后会停留在什么范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    //计算屏幕最中间的中线X(当前位置的坐标的X+屏幕宽度的一半)
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width/2;
    
    //取出最后停留范围内的所有属性
    NSArray *arr = [self layoutAttributesForElementsInRect:lastRect];
    
    //声明需要调整的距离   默认一个最大值
    CGFloat adjustOffsetX = MAXFLOAT;
    //遍历所有属性
    for (UICollectionViewLayoutAttributes *arre in arr) {
        //如果偏移量小于这个调整移动距离,则调整移动距离等于小的值(计算最小值)
        if (ABS(arre.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = arre.center.x - centerX;
        }
    }
    
    
    
    return CGPointMake(proposedContentOffset.x+adjustOffsetX, proposedContentOffset.y);
    
}


//最好把布局放到这里,这样的话,布局是在collectionView init之后才开始的
-(void)prepareLayout
{
/**
  *如果以下变化sectionInset的部分放在init里面的话  那么就会适得其反
  *因为是先初始化了布局,才初始化的collectionView   也就是在初始化collectionView之前,那一部分就被切掉了,
  *等到collectionView初始化了,起点就会外移了.
  *
  */
    
    //获得初始的布局,在这个基础上布新局
    [super prepareLayout];
    //设置items的尺寸
    self.itemSize = CGSizeMake(myHeight, myHeight);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置最小行间距(因为是横向滑动   行间距就是item之间的间距了)
    self.minimumLineSpacing = myHeight/2;
    
    //设置最左边和最右边的两张图滑到的时候居中
    //左右都加上一段空白
    CGFloat inset = (self.collectionView.frame.size.width - myHeight) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}





//既然每个cell都有一套UICollectionViewLayoutAttributes(布局属性),那么所有cell就是数组了
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    //获得屏幕中的所有的item的属性,只是获得,等到处理的时候,再选择能看的见的部分进行
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕能看的见的部分
    CGRect visableRect;
    visableRect.size = self.collectionView.frame.size;
    visableRect.origin = self.collectionView.contentOffset;

/*
 *实现中间放大的效果
 *涉及思路是用item的中线和屏幕(不是屏幕宽度,而是划过所有item要经历过的宽度)中线的绝对值差,
 *这个差越小,图片就越大
 */
    
    //整个滑动所有的宽度的中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *arrts in arr) {
        //判断item是否在屏幕中(获取屏幕看的到的部分)
        
        //CGRectIntersectsRect是判断两个frame之间是否有交叉部分,如果没有,就continue掉;
        if (!CGRectIntersectsRect(visableRect, arrts.frame)) continue;
        
        //item的中线x
        CGFloat itemCenterX = arrts.center.x;
        
        //中线差占总比例越小,视图的scale越大
        //得到中线差的绝对值
        CGFloat abss = ABS(itemCenterX - centerX);
        
        /*因为scale改变的是frame的缘故,当frame离开屏幕的时候  图片会瞬变  
         *办法就是:以左划为例,当中间的那个item居中的时候,左边的那个不再变小*/
        CGFloat scale;
        if (abss>self.collectionView.frame.size.width/2) {
            scale = 1;
        }else{
            scale = 1 + 0.6*(1 - abss*2/self.collectionView.frame.size.width);
        }
        
        arrts.transform = CGAffineTransformMakeScale(scale, scale);
    }
    NSLog(@"end");
    
    
    
    //这是系统开始默认的cell的UICollectionViewLayoutAttributes(布局属性)
    return arr;
}






@end
