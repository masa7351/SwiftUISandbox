import UIKit

protocol Animal {
    func say()
}

class Dog: Animal {
    func say() {
        print("bark bark")
    }
}

class Bird: Animal {
    func say() {
        print("sing sing")
    }
}

// ジェネリクス
func say<A: Animal>(_ animal: A) {
    animal.say()
}

//『リバースジェネリクス』
//func makeAnimal() -> <A: Animal> A {
//    return Dog()
//}

func makeAnimal1() -> some Animal {
    return Dog()
}

func makeAnimal2() -> some Animal {
    return Bird()
}


say(Dog())
makeAnimal1().say()
makeAnimal2().say()
