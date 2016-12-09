## TTAlbumFlowLayout
*一个简单的相册流水布局*

*里面有详细的注释，以便于根据不同的项目修改参数*

## 功能展示
1. 相册横向流水布局

2. 中间大，两边小的效果

3. 无论如何滚动，最终停止的位置始终是一个Item居中

4. 点击空白处，更换布局

![(动图)](http://a1.qpic.cn/psb?/V14HUEIQ0mQ1ma/eIoa4RNjukhOs65j*Gxq8ragf5cGyFt.MG9jMzfpziA!/b/dOEAAAAAAAAA&bo=ngHeAgAAAAACF3A!&rf=viewer_4.gif)


## 用法

*创建一个UICollectionView，将TTAlbumFlowLayout.h和TTAlbumFlowLayout.m导入工程，然后通过以下方式创建一个collectionView*
```
UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[TTAlbumFlowLayout alloc]init]];
```

