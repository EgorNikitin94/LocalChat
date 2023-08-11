//
//  BaseSwiftRouter.swift
//  amoCRMFramework
//
//  Created by Егор Никитин on 06.10.2021.
//  Copyright © 2021 amoCRM. All rights reserved.
//

import UIKit

@objc protocol BaseSwiftRouterInput {
    func openModuleFrom(window: UIWindow)
    func openModuleFrom(viewController: UIViewController)
    func openModuleFrom(viewController: UIViewController, inView: UIView, onFullViewArea: Bool)
    func closeModule()
    @objc optional func openModuleFrom(viewController: UIViewController, animated: Bool)
}

class BaseSwiftRouter: BaseSwiftRouterInput {
    
    weak var view: UIViewController?
    
    func openModuleFrom(window: UIWindow) {
        window.rootViewController = view
    }
    
    func openModuleFrom(viewController: UIViewController) {
        openModuleFrom(viewController: viewController, animated: true)
    }
    
    func openModuleFrom(viewController: UIViewController, inView: UIView, onFullViewArea: Bool) {
        guard let view = view else { return }
        
        viewController.addChild(view)
        if let child = view.view {
            child.frame = inView.bounds
            inView.addSubview(child)
            if onFullViewArea {
                child.leadingAnchor.constraint(equalTo: inView.leadingAnchor).isActive = true
                child.trailingAnchor.constraint(equalTo: inView.trailingAnchor).isActive = true
                child.topAnchor.constraint(equalTo: inView.topAnchor).isActive = true
                child.bottomAnchor.constraint(equalTo: inView.bottomAnchor).isActive = true
                child.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        view.didMove(toParent: viewController)
    }
    
    func closeModule() {
        guard let view = view else { return }
        
        if let parentViewController = view.parent {
            guard let _ = parentViewController as? UINavigationController else {
                view.willMove(toParent: nil)
                view.view.removeFromSuperview()
                view.removeFromParent()
                return
            }
        } else if let navigationController = view.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    func openModuleFrom(viewController: UIViewController, animated: Bool) {
        guard let view = view else { return }
        
        if let viewController = viewController as? UINavigationController {
            viewController.pushViewController(view, animated: animated)
        } else if let viewController = viewController.navigationController {
            viewController.pushViewController(view, animated: animated)
        } else {
            viewController.present(view, animated: animated, completion: nil)
        }
    }
    
}
