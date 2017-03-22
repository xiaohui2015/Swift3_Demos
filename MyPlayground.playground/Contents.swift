//: Playground - noun: a place where people can play

import UIKit



// 函数是可以加外部参数名的
func test0(aa a: Int) {
    
}



// 闭包不可以加外部参数名
func test1(speed: CGFloat, time: CGFloat, begin: (_ distance: CGFloat) -> Void) {
    
    begin(speed * time)
}

test1(speed: 100, time: 30) { (distance) -> Void in
    
    print("test1的距离是：\(distance)米")
}



//但是可以用类型别名typealias的方式替换系统提供的类名，提高参数类型的可读性
typealias Distance = CGFloat
func test2(speed: CGFloat, time: CGFloat, begin: (_ distance: Distance) -> Void) {
    
    begin(speed * time)
}

test2(speed: 100, time: 30) { (distance) -> Void in

    print("test2的距离是：\(distance)米")
}



var outGroupsss = ["hello world"]
func loadCategoryGroup(finished: (_ outGroups: [String]) -> [String]) {
    
    finished(outGroupsss)
}

loadCategoryGroup { (outGroups) in
    
    return outGroups
}



typealias MyClosure = (_ a: Int) -> Void
var mc: MyClosure?
func test() {
    if let mc = mc {
        mc(1)
    }
}



class ClassA {
    // 接受非逃逸闭包作为参数
    func someMethod(closure: () -> Void) {
        // 想干什么？
    }
}



class ClassB {
    let classA = ClassA()
    var someProperty = "Hello"
    
    func testClosure() {
        classA.someMethod {
            // self被捕获
            self.someProperty = "闭包内..."
        }
    }
}



class ClassC {
    // 接受逃逸闭包作为参数
    func someMethod(closure:@escaping () -> Void) {
        // 想干什么？
    }
}



class ClassD {
    let classC = ClassC()
    var someProperty = "Hello"
    
    func testClosure() {
        classC.someMethod {
            // self未被捕获
            self.someProperty = "闭包内..."
        }
    }
}


// ******高阶函数******//

// 1.映射 map（如：整型数组转字符型数组）
let array0 = [3, 5, 1, 11, 2, 8]
//var convertedArray = array0.map { (x) -> String in
//    return String(x)
//}
var convertedArray = array0.map { String($0) }
convertedArray



// 2.排序 sorted（如：数组元素升序）
let array1 = [3, 5, 1, 11, 2, 8]
//var sortedArray = array1.sorted { (x, y) -> Bool in
//    return x < y
//}
var sortedArray = array1.sorted { $0 < $1 }
sortedArray



// 3.过滤 filter（如：数组元素提偶）
let array2 = [3, 5, 1, 11, 2, 8]
//var filteredArray = array2.filter { (x) -> Bool in
//    return x > 1
//}
var filteredArray = array2.filter { $0 % 2 == 0 }
filteredArray



// 4.计算 reduce（如：数组元素求和）
// 在这里$0和$1的意义不同，$0代表元素计算后的结果，$1代表元素
// 0代表初始化值，在这里可以理解为 $0初始值 = 0
let array3 = [3, 5, 1, 11, 2, 8]
//var reducedArray = array3.reduce(0) { (result, x) -> Int in
//    return result + x
//}
var reducedArray = array3.reduce(0) { $0 + $1 }
reducedArray








