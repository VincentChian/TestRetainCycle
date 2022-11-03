//
//  FirstContentViewController.swift
//  TestRetainCycle
//
//  Created by VincentPro on 2022/10/30.
//

import UIKit
import LifetimeTracker


class FirstContentViewController: DefaultLifetimeTrackableVC {
   
    private var myClass: MyClass = MyClass(info: "MyClass")
    
    private var myStruct: MyStruct = MyStruct(info: "MyStruct")

    
    deinit {
        print("FirstContentViewController 死掉了")
    }
    
    override func viewDidLoad() {
        // ＊保留 super vc 的設定
        super.viewDidLoad()
        testRetainCycle()
        setTitle(text: "FirstContent")
    }

    
    private func testRetainCycle() {

        // MARK: - Retain Cycle
        // MARK: 案例1. class 的屬性成員，於 closure 中互相capture 住其他成員(同為self)，導致 FirstContentViewController 無法釋放

        // 方法1. capture list 加上 weak
//        myStruct.someClosure = { [weak self] in
//            self?.myClass.showInfo()
//        }
//        myStruct.someClosure()
        
//        myClass.someClosure = { [weak self] in
//            self?.myStruct.showInfo()
//        }
//        myClass.someClosure()
        // 註：重點在兩個屬性成員都來自同一個實體(self)，且 capture 住彼此
        
        
        // ＊改成 function 可以正常釋放 (但有隱憂，例如非同步、延遲等)
        // 一般版
//        myClass.someFunction {
//            self.myStruct.showInfo()
//        }
        
        // 延遲版
//        myClass.someDelayFunction {
//            self.myStruct.showInfo()
//        }
        
        // 方法2. 同上，讓「實體本身」成為參數，效果與 function 傳入參數相同
//        myClass.trickySomeClosure = { instance in
//            instance.showInfo()
//        }
//
//        myClass.trickySomeClosure(myClass)
        
        
        // MARK: 案例2. 「區域變數 capture 住自己」或「區域變數互相 capture 」，儘管 FirstContentViewController 釋放了，但區域變數卻產生 Retain Cycle (Debug memory graph 有紫色驚嘆號)
        
        // ＊註解上方 myClass / myStruct 以便觀察
//        var regionalMyClass = MyClass(info: "Regional MyClass")
//        // 「區域變數 capture 住自己」
//        regionalMyClass.someClosure = {  [weak regionalMyClass] in
//            regionalMyClass?.showInfo()
//        }
//
//        regionalMyClass.someClosure()
        
        
        // 「區域變數互相 capture 」
//        var regionalStructA: MyStruct = MyStruct(info: "Regional StructA")
//        var regionalStructB: MyStruct = MyStruct(info: "Regional StructB")
//
//        regionalStructA.someClosure = {
//            regionalStructB.showInfo()
//        }
//
//        regionalStructB.someClosure = {
//            regionalStructA.showInfo()
//        }
        
        // 加映：三個區域變數「依序」capture
//        var regionalMyClassA: MyClass = MyClass(info: "Regional MyClassA")
//        var regionalMyClassB: MyClass = MyClass(info: "Regional MyClassB")
//        var regionalMyClassC: MyClass = MyClass(info: "Regional MyClassC")
//
//        regionalMyClassA.someClosure = {
//            regionalMyClassB.showInfo()
//        }
//
//        regionalMyClassB.someClosure = {
//            regionalMyClassC.showInfo()
//        }
//
//        regionalMyClassC.someClosure = {
//            regionalMyClassA.showInfo()
//        }
    }
    
    // MARK: - API
    func setRandomColor() {
        view.backgroundColor = .random
    }
}



extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
