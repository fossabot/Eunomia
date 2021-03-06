//
//  UITabBarController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UITabBarController {

    public func tabIndexOf(_ match : UIViewController) -> Int? {
        var result : Int?
        
        if let viewControllers = self.viewControllers
        {
            for index in 0...viewControllers.count - 1
            {
                let viewControllerAtIndex = viewControllers[index]
                
                if viewControllerAtIndex == match
                {
                    result = index
                    break
                } else if viewControllerAtIndex.isKind(of: UINavigationController.self)
                {
                    let navigationController = viewControllerAtIndex as! UINavigationController
                    if navigationController.viewControllers.count > 0
                    {
                        let viewControllerAtNavRoot = navigationController.viewControllers[0]
                        if viewControllerAtNavRoot == match
                        {
                            result = index
                            break
                        }
                    }
                }
            }
        }
        
        if result == nil
        {
            Log.info(message: "View controller \(match) was not found in any tab")
        }
        
        return result
    }
    
    public func tabIndexForTabWithClass(_ matchClass : UIViewController.Type) -> Int? {
        var result : Int?
        
        if let viewControllers = self.viewControllers
        {
            for index in 0...viewControllers.count - 1
            {
                if viewControllers[index].isKind(of: matchClass)
                {
                    result = index
                    break
                } else if viewControllers[index].isKind(of: UINavigationController.self)
                {
                    let navigationController = viewControllers[index] as! UINavigationController
                    if navigationController.viewControllers.count > 0 &&
                        navigationController.viewControllers[0].isKind(of: matchClass)
                    {
                        result = index
                        break
                    }
                }
            }
        }
        
        if result == nil
        {
            Log.info(message: "No view controller class found of type \(matchClass)")
        }
        
        return result
    }

    public func selectTabWithClass(_ matchClass : UIViewController.Type) {
        if let index = self.tabIndexForTabWithClass(matchClass)
        {
            self.selectedIndex = index
        }
    }
    
    public func preloadTabs() {
        
        if let viewControllers = self.viewControllers {
            
            for viewController in viewControllers {
                let _ = viewController.view // Oh how I hate View Controllers' "view access side effect"
            }
        }
    }
    
    public func preloadTab(_ matchClass : UIViewController.Type) throws {
        guard let viewControllers = self.viewControllers else {
            return
        }
        
        guard let index = self.tabIndexForTabWithClass(matchClass) else {
            throw NSError(description: "No tab found with class \(matchClass)")
        }
        
        guard index < viewControllers.count else {
            // TODO: something is broken, log but don't throw
            return
        }
        
        let _ = viewControllers[index].view
    }
    
    public func tabBarButtonWithClass(_ matchClass : UIViewController.Type) throws -> UIView? {
        guard let tabBarButtons = try self.tabBar.tabBarButtonViews() else {
            return nil
        }
        
        guard let index = self.tabIndexForTabWithClass(matchClass) else {
            return nil
        }
        
        guard index < tabBarButtons.count else {
            // This is totally normal if the tab bar has a "More" button
            return nil
        }
        
        return tabBarButtons[index]
    }
    
    public func rectForTabWithClass(_ matchClass : UIViewController.Type) throws -> CGRect? {
        
        guard let tabBarButton = try self.tabBarButtonWithClass(matchClass) else {
            return nil
        }
        
        return tabBarButton.frame
    }
}
#endif
