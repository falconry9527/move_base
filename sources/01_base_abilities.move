module move_base::base_abilities {

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