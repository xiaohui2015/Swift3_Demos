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



// 可以用类型别名typealias的方式替换系统提供的类名，提高参数类型的可读性
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



// 图片资源通过枚举实现一一对应
extension UIImage {
    enum AssetIdentifier: String {
        // Image Names of Minions
        case Bob, Dave, Jorge, Jerry, Tim, Kevin, Mark, Phil, Stuart
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
let minionBobImage = UIImage(assetIdentifier: .Kevin)



// 1.存储属性

// a.结构体
struct FixedLengthRange {
    var firstValue:Int      // 变量存储属性
    let length:Int          // 常量存储属性
}
let item1 = FixedLengthRange(firstValue: 10, length: 10)
//item1.firstValue = 5 // 错误：不能修改常量结构体实例的存储属性
var item2 = FixedLengthRange(firstValue: 10, length: 10)
item2.firstValue = 5


// b.类
class Person {
    var name: String = ""
    let heart: Int = 1
}
let p1 = Person()
p1.name = "xiaohui"
p1.heart
var p2 = Person()
p2.name = "xiaohong"
p2.heart



// 2.计算属性
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    
    var origin = Point()
    
    var size = Size()
    
    var center: Point {          // 计算属性
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
//        set {            // 若不提供新值变量名，则默认为newValue
//            origin.x = newValue.x - size.width / 2
//            origin.y = newValue.y - size.height / 2
//        }
    }
    
    var maxX: Float {        // 只读属性，省略get{}
        return Float(origin.x) + Float(size.width)
    }
}

var rect = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 100, height: 100))
rect.size.width
rect.size.height
rect.origin.x
rect.origin.y
rect.center.x
rect.center.y
rect.maxX

let initialSquareCenter = rect.center
rect.center = Point(x: 15.0, y:15.0)
rect.center.x
rect.center.y
rect.origin.x
rect.origin.y
rect.maxX
rect.size.width
rect.size.height



// 3.类型属性
struct AudioChannel {
    
    static let threaholdLevel = 10
    
    static var maxInputLevelForAllChannels = 0
    
    var currentLevel: Int = 0 {
        didSet{
            if currentLevel > AudioChannel.threaholdLevel {
                currentLevel = AudioChannel.threaholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7

print(leftChannel.currentLevel)       // 7
print(AudioChannel.maxInputLevelForAllChannels)   // 7

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)      // 10
print(AudioChannel.maxInputLevelForAllChannels)   // 10



// 正则表达式
var a = "^123."
a
