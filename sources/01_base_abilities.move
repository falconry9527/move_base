module move_base::base_abilities {
    // `move` 类支持 4 种能力：复制 (copy ) 、丢弃 (drop)、键 (key)和 存储 (store)
    // drop: 类型可以被销毁
    // copy: 类型可以被复制: Move 中的所有原生类型都具有复制功能; 标准库中定义的所有类型都具有复制能力
    // key: 类型可以作为链上对象的唯一 key（全局唯一标识） 
    // 注意 : 具有key 能力的类型 永远不能拥有drop 或 copy能力。
    // store : 类型可以存储在链上
    // 定义可复制结构体
    public struct Point has copy, drop {
        x: u8,
        y: u8,
    }

    public fun test_point() : u8 {
        let p1 = Point { x: 10, y: 20 };
        let p2 = p1; // ✅ 可以复制
        let p3 = p1; // ✅ 再次复制
        p2.x + p3.y // ✅ 使用了 p3
    }

}