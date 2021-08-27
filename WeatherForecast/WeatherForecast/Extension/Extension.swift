//
//  Extension.swift
//  WeatherForecast
//
//  Created by Vipul on 24/08/21.
//

import Foundation
import UIKit
import MapKit

extension UIViewController{
    @objc private func swizzled_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
           if #available(iOS 13.0, *) {
               if viewControllerToPresent.modalPresentationStyle == .automatic || viewControllerToPresent.modalPresentationStyle == .pageSheet {
                   viewControllerToPresent.modalPresentationStyle = .fullScreen
               }
           }
           self.swizzled_present(viewControllerToPresent, animated: animated, completion: completion)
       }

    @nonobjc private static let _swizzlePresentationStyle: Void = {
       let instance: UIViewController = UIViewController()
       let aClass: AnyClass! = object_getClass(instance)

       let originalSelector = #selector(UIViewController.present(_:animated:completion:))
       let swizzledSelector = #selector(UIViewController.swizzled_present(_:animated:completion:))

       let originalMethod = class_getInstanceMethod(aClass, originalSelector)
       let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)

       if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
           if !class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
               method_exchangeImplementations(originalMethod, swizzledMethod)
           } else {
               class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
           }
       }
    }()

    @objc static func swizzlePresentationStyle() {
       _ = self._swizzlePresentationStyle
    }
}

extension UITableView {
    private func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCellFromNIB<T: UITableViewCell>(_: T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T{
            return cell
        }else{
            self.register(T.self)
            return self.dequeueCellFromNIB(T.self)
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
