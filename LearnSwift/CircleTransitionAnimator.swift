//
//  CircleTransitionAnimator.swift
//  LearnSwift
//
//  Created by Suric on 15/2/15.
//  Copyright (c) 2015年 Snail. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject ,UIViewControllerAnimatedTransitioning {
   
    weak var transitionContext: UIViewControllerContextTransitioning?
    var isPushing:Bool = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 1
        self.transitionContext = transitionContext
        
        // 2
        let containerView = transitionContext.containerView()
        var fromViewController :UIViewController
        var toViewController :UIViewController
        var button : UIButton
        if (self.isPushing)
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FirstViewController
            let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PingViewController
            let fromButton = fromVC.buttton
            
            fromViewController = fromVC
            toViewController = toViewVC
            button = fromButton;
        }
        else
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PingViewController
            let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FirstViewController
            let fromButton = fromVC.backBtn
            
            fromViewController = fromVC
            toViewController = toViewVC
            button = fromButton
        }
        
        // 3
        if self.isPushing
        {
            containerView!.addSubview(toViewController.view)
        }
        else
        {
            containerView!.addSubview(toViewController.view)
            containerView!.sendSubviewToBack(toViewController.view)
        }
        // 4
        let beginMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        let extremePoint = CGPointMake(button.center.x, button.center.y - CGRectGetHeight(toViewController.view.bounds)) // need more research
        let radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y)
        let endMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        var circleMaskPathInitial :UIBezierPath
        var circleMaskPathFinal :UIBezierPath
        if self.isPushing
        {
            circleMaskPathInitial = beginMaskPathInitial
            circleMaskPathFinal = endMaskPathFinal
        }
        else
        {
            circleMaskPathInitial = endMaskPathFinal
            circleMaskPathFinal = beginMaskPathInitial
        }
        
        // 5
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        
        if self.isPushing
        {
            toViewController.view.layer.mask = maskLayer
        }
        else
        {
            fromViewController.view.layer.mask = maskLayer
        }
        
        // 6
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(self.transitionContext!)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "CircleAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
