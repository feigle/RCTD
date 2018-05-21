//
//  DDCollectionViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDNeedRefreshViewController.h"

@interface DDCollectionViewController : DDNeedRefreshViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

/**必须是流式布局才这样用*/
@property (nonatomic,strong) UICollectionViewLayout *customLayout;

@property (nonatomic,assign) UICollectionViewScrollDirection collectionDirection;

@end
