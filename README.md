# tableview-animation
tableview滚动时产生缩放动画

####效果如图
![](https://github.com/crossPQW/tableview-animation/blob/master/tableview-animation/tableviewAnimation.gif)

#####核心代码如下
~~~
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat viewHeight = scrollView.bounds.size.height + scrollView.contentInset.top;
    for (TableViewCell *cell in [self.tableview visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.9) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.image.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}
~~~
