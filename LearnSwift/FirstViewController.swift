//
//  FirstViewController.swift
//  LearnSwift
//
//  Created by Suric on 15/2/11.
//  Copyright (c) 2015年 Snail. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var buttton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goBack(sender: AnyObject) {
        self.navigationController?.navigationController?.popViewControllerAnimated(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    
    @IBOutlet weak var navigationController: UINavigationController?
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pan = UIPanGestureRecognizer(target: self, action: "panned:")
        self.navigationController!.view.addGestureRecognizer(pan)
    }
    
    func panned(gestureRecognizer: UIPanGestureRecognizer){
        switch gestureRecognizer.state {
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            if self.navigationController?.viewControllers.count > 1 {
                self.navigationController?.popViewControllerAnimated(true)
            }
            else{
                self.navigationController?.topViewController!.performSegueWithIdentifier("PushSegue", sender: nil)
            }
        case .Changed:
            let translation = gestureRecognizer.translationInView(self.navigationController!.view)
            var completionProgress :CGFloat
            if self.navigationController?.viewControllers.count > 1
            {
                completionProgress = (translation.x < 0 ? -translation.x :0) / CGRectGetWidth(self.navigationController!.view.bounds)

            }
            else
            {
                completionProgress = (translation.x > 0 ? translation.x :0) / CGRectGetWidth(self.navigationController!.view.bounds)
            }
            print(completionProgress)
            self.interactionController?.updateInteractiveTransition(completionProgress)
        case .Ended:
            print("velocityInView:",gestureRecognizer.velocityInView(self.navigationController!.view).x)
            if gestureRecognizer.velocityInView(self.navigationController!.view).x > 0 {
                if self.navigationController?.viewControllers.count > 1
                {
                   self.interactionController?.cancelInteractiveTransition()
                }
                else
                {
                    self.interactionController?.finishInteractiveTransition()
                }
            }
            else{
                if self.navigationController?.viewControllers.count > 1
                {
                    self.interactionController?.finishInteractiveTransition()
                }
                else
                {
                    self.interactionController?.cancelInteractiveTransition()
                }
                }
            self.interactionController = nil
        default:
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      let animator = CircleTransitionAnimator()
      animator.isPushing = operation == UINavigationControllerOperation.Push ? true : false
      return animator
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }

}

