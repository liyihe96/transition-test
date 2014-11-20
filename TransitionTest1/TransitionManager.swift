//
//  TransitionManager.swift
//  TransitionTest1
//
//  Created by Yihe Li on 11/19/14.
//  Copyright (c) 2014 Yihe Li. All rights reserved.
//

import UIKit

class TransitionManager: NSObject,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
   
    var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        if self.presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }
        container.addSubview(fromView)
        container.addSubview(toView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            if self.presenting {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            toView.transform = CGAffineTransformIdentity
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
        
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
}
