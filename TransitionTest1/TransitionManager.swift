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
        
        let pi:CGFloat = 3.14159265359
        
        let offScreenRotateIn = CGAffineTransformMakeRotation(-pi/2)
        let offScreenRotateOut = CGAffineTransformMakeRotation(pi/2)
        
        toView.transform = presenting ? offScreenRotateIn : offScreenRotateOut
        
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: { () -> Void in
            fromView.transform = self.presenting ? offScreenRotateOut : offScreenRotateIn
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
