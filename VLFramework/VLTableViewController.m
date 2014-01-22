//
//  VLTableViewController.m
//  Pods
//
//  Created by Deniz Adalar on 21/01/14.
//
//

#import "VLTableViewController.h"
#import "UIViewController+VLFramework.h"

@interface VLTableViewController () {
    CGFloat totalKeyboardOverlap;
    CGFloat keyboardOverlap;   
}
@end

@implementation VLTableViewController

-(void)displayData:(id)data {
    [self.tableView reloadData];
}


#pragma mark tableview frame <-> keyboard size
-(void)vl_keyboardWillShow:(NSNotification *)aNotification {
    // Get the keyboard size
    UIScrollView *tableView = self.tableView;
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [tableView.superview convertRect:[aValue CGRectValue] fromView:nil];
    
    // Get the keyboard's animation details
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    // Determine how much overlap exists between tableView and the keyboard
    CGRect tableFrame = tableView.frame;
    CGFloat tableLowerYCoord = tableFrame.origin.y + tableFrame.size.height - tableView.contentInset.bottom;
    keyboardOverlap = tableLowerYCoord - keyboardRect.origin.y;
    if(self.inputAccessoryView && keyboardOverlap>0)
    {
        CGFloat accessoryHeight = self.inputAccessoryView.frame.size.height;
        keyboardOverlap -= accessoryHeight;
        //CONSIDER ALSO TABLEVIEW'S CONTENT INSET ALSO
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, accessoryHeight, 0);
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, accessoryHeight, 0);
    }
    
    totalKeyboardOverlap += keyboardOverlap;
    
    if(keyboardOverlap != 0)
    {
        tableFrame.size.height -= keyboardOverlap;
        
        NSTimeInterval delay = 0;
        if(keyboardRect.size.height)
        {
            delay = (1 - keyboardOverlap/keyboardRect.size.height)*animationDuration;
            animationDuration = animationDuration * keyboardOverlap/keyboardRect.size.height;
        }
        
        [UIView animateWithDuration:animationDuration delay:delay
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ tableView.frame = tableFrame; }
                         completion:^(BOOL finished){
                             [self tableAnimationEnded:nil finished:nil contextInfo:nil]; }
         ];
    }
}

-(void)vl_keyboardWillHide:(NSNotification *)aNotification {
    UIScrollView *tableView = self.tableView;
    if(self.inputAccessoryView)
    {
        tableView.contentInset = UIEdgeInsetsZero;
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
    
    if(totalKeyboardOverlap == 0)
        return;
    
    // Get the size & animation details of the keyboard
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [tableView.superview convertRect:[aValue CGRectValue] fromView:nil];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    CGRect tableFrame = tableView.frame;
    tableFrame.size.height += totalKeyboardOverlap;
    
    if(keyboardRect.size.height)
        animationDuration = animationDuration * totalKeyboardOverlap/keyboardRect.size.height;
    
    [UIView animateWithDuration:animationDuration delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         tableView.frame = tableFrame;
                     }
                     completion:nil];
    
    totalKeyboardOverlap = 0;
    
}

- (void) tableAnimationEnded:(NSString*)animationID finished:(NSNumber *)finished contextInfo:(void *)context
{
    UIView *active = [self findFirstResponder:nil];
    CGRect frameInTable = [active convertRect:active.bounds toView:self.tableView];
    frameInTable.origin.y -= 40;
    frameInTable.size.height += 120;
    [self.tableView scrollRectToVisible:frameInTable animated:YES];
}

-(UIView*)findFirstResponder:(UIView*)parentView {
    if (parentView == nil) {
        parentView = self.view;
    }
    if (parentView.isFirstResponder) {
        return parentView;
    }
    for (UIView *subView in parentView.subviews) {
        UIView *r = [self findFirstResponder:subView];
        if (r) return r;
    }
    return nil;
}
@end
