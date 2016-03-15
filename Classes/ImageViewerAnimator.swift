//
//  BaseViewController.swift
//  CPImageViewer
//
//  Created by ZhaoWei on 16/2/27.
//  Copyright © 2016年 cp3hnu. All rights reserved.
//

import UIKit

public class ImageViewerAnimator: NSObject, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {

    private let animator = ImageViewerAnimationTransition()
    private let interativeAnimator = ImageViewerInteractiveTransition()

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presenting is ImageControllerProtocol && presented is ImageViewerViewController {
            interativeAnimator.wireToViewController(presented as! ImageViewerViewController)
            interativeAnimator.isPresented = true
            animator.dismiss = false
            return animator
        }
        
        return nil
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed is ImageControllerProtocol {
            animator.dismiss = true
            return animator
        }
        
        return nil
    }
    
    public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interativeAnimator.interactionInProgress ? interativeAnimator : nil
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .Push && fromVC is ImageControllerProtocol && toVC is ImageViewerViewController {
            interativeAnimator.wireToViewController(toVC as! ImageViewerViewController)
            interativeAnimator.isPresented = false
            animator.dismiss = false
            return animator
        } else if operation == .Pop  && fromVC is ImageViewerViewController && toVC is ImageControllerProtocol {
            animator.dismiss = true
            return animator
        }
        
        return nil
    }
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interativeAnimator.interactionInProgress ? interativeAnimator : nil
    }
}
