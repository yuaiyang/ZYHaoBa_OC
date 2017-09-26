//
//  PhotosFramworkCollectionViewFlowLayout.m
//  allinone
//
//  Created by Johnil on 16/2/29.
//  Copyright © 2016年 Johnil. All rights reserved.
//

/**
 *  相关文章
 https://onevcat.com/2013/09/spring-list-like-ios7-message/ 中文
 https://www.objc.io/issues/5-ios7/collection-views-and-uidynamics/ 英文
 */
#import "PhotosFrameworkCollectionViewFlowLayout.h"

@interface PhotosFrameworkCollectionViewFlowLayout()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) NSMutableSet *visibleIndexPathsSet;
@property (nonatomic, assign) CGFloat latestDelta;

@end


@implementation PhotosFrameworkCollectionViewFlowLayout

-(id)init {
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 0;
    NSInteger size = ceil(([UIScreen screenWidth]-2)/3-.5);
    if (size%2!=0) {
        size-=1;
    }
    self.minimumLineSpacing = floor(([UIScreen screenWidth]-size*3)/2);
    self.itemSize = CGSizeMake(size, size);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    self.visibleIndexPathsSet = [NSMutableSet set];
    
    return self;
}

-(void)prepareLayout {
    [super prepareLayout];
    // Need to overflow our actual visible rect slightly to avoid flickering.
    CGRect visibleRect = CGRectInset((CGRect){.origin = self.collectionView.bounds.origin, .size = self.collectionView.frame.size}, -100, -100);
    
    NSArray *itemsInVisibleRectArray = [super layoutAttributesForElementsInRect:visibleRect];
    
    NSSet *itemsIndexPathsInVisibleRectSet = [NSSet setWithArray:[itemsInVisibleRectArray valueForKey:@"indexPath"]];
    
    // Step 1: Remove any behaviours that are no longer visible.
    NSArray *noLongerVisibleBehaviours = [self.dynamicAnimator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behaviour, NSDictionary *bindings) {
        BOOL currentlyVisible = [itemsIndexPathsInVisibleRectSet member:[(UICollectionViewLayoutAttributes *)[[behaviour items] firstObject] indexPath]] != nil;
        return !currentlyVisible;
    }]];
    
    [noLongerVisibleBehaviours enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
        [self.dynamicAnimator removeBehavior:obj];
        [self.visibleIndexPathsSet removeObject:[(UICollectionViewLayoutAttributes *)[[obj items] firstObject] indexPath]];
    }];
    
    // Step 2: Add any newly visible behaviours.
    // A "newly visible" item is one that is in the itemsInVisibleRect(Set|Array) but not in the visibleIndexPathsSet
    NSArray *newlyVisibleItems = [itemsInVisibleRectArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings) {
        BOOL currentlyVisible = [self.visibleIndexPathsSet member:item.indexPath] != nil;
        return !currentlyVisible;
    }]];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [newlyVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop) {
        CGPoint center = item.center;
        UIAttachmentBehavior *springBehaviour = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
        
        springBehaviour.length = 1;
        springBehaviour.damping = 1;
        springBehaviour.frequency = 1;
        
        // If our touchLocation is not (0,0), we'll need to adjust our item's center "in flight"
        if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
            CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehaviour.anchorPoint.y);
            CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehaviour.anchorPoint.x);
            CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 3000;
            
            if (self.latestDelta < 0) {
                center.y += MAX(self.latestDelta, self.latestDelta*scrollResistance);
            }
            else {
                center.y += MIN(self.latestDelta, self.latestDelta*scrollResistance);
            }
            item.center = center;
        }
        [self.dynamicAnimator addBehavior:springBehaviour];
        [self.visibleIndexPathsSet addObject:item.indexPath];
    }];
}

- (void)clearDynamic{
    [self.dynamicAnimator removeAllBehaviors];
    [self.visibleIndexPathsSet removeAllObjects];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.dynamicAnimator itemsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    if(!layoutAttributes) {
        layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    }
    return layoutAttributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    self.latestDelta = delta;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 2000.0f;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[springBehaviour.items firstObject];
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}

@end
