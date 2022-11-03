//
//  CustomType.swift
//  TestRetainCycle
//
//  Created by VincentPro on 2022/10/30.
//

import Foundation
import LifetimeTracker


class MyClass {
    
    var info: String
    
    var someClosure: () -> Void = {}
        
    var trickySomeClosure: (MyClass) -> Void = {_ in }
    
    init(info: String = "") {
        self.info = info
    }
    
    deinit {
        print("\(info) 死掉了")
    }
    
    func showInfo() {
        print("MyClass showInfo: \(info)")
    }
    
    func someFunction(_ closure: () -> Void ) {
        closure()
    }
    
    func someDelayFunction(closure: @escaping () -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            closure()
        }
    }
}


class DeallocPrinter<T> {
    private lazy var typeInfo = String(describing: T.self )
    deinit {
        print("\(typeInfo) 死掉了")
    }
}



struct MyStruct {
    
    var info: String
    
    var someClosure: () -> Void = {}
    
    init(info: String = "") {
        self.info = info
    }
    
    //＊ deinit 僅限於ReferenceType，故使用簡單的 class 作為屬性，來觀察 struct 生命週期
    private let deallocPrinter = DeallocPrinter<MyStruct>()

    
    func showInfo() {
        print("MyStruct showInfo: \(info)")
    }
    
    func someFunction(_ closure: () -> Void ) {
        closure()
    }

}
