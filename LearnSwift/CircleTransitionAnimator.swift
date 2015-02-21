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
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 1
        self.transitionContext = transitionContext
        
        // 2
        var containerView = transitionContext.containerView()
        var fromViewController :UIViewController
        var toViewController :UIViewController
        var button : UIButton
        if (self.isPushing)
        {
            var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as FirstViewController
            var toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as PingViewController
            var fromButton = fromVC.buttton
            
            fromViewController = fromVC
            toViewController = toViewVC
            button = fromButton;
        }
        else
        {
            var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as PingViewController
            var toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as FirstViewController
            var fromButton = fromVC.backBtn
            
            fromViewController = fromVC
            toViewController = toViewVC
            button = fromButton
        }
        
        // 3
        if self.isPushing
        {
            containerView.addSubview(toViewController.view)
        }
        else
        {
            containerView.addSubview(toViewController.view)
            containerView.sendSubviewToBack(toViewController.view)
        }
        // 4
        var beginMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        var extremePoint = CGPointMake(button.center.x, button.center.y - CGRectGetHeight(toViewController.view.bounds)) // need more research
        var radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y)
        var endMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
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
        var maskLayer = CAShapeLayer()
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
        var maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(self.transitionContext!)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "CircleAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
