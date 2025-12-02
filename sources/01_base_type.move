module move_base::base_type {
    // const ITEM_PRICE: u64 = 100; // 常量不能更改

    use std::string;
    // 引用数据类型
    // 基本数据类型: bool，address ，uint
    // mut： 变量值可变，所有数据类型
    public fun test_bool():bool {
        let mut _x: bool = true;
        _x=false ;
       (_x)
    }
    
    public fun test_addr():address {
        let addr: address = @0x1;
       (addr)
    }

    // /// 测试基础类型变量
    public fun test_int() :u8 {
        let mut y: u8 = 42;
        y = y + 1;
         (y)
    }

    // 引用数据类型： String，vector，struct, Option
    public fun test_str() : string::String {
        let str: string::String = string::utf8(b"MoveLang"); // b的作用是把字符串转为byte数组
         (str)
    }

    public fun test_vector() : vector<u8>{
       let mut v = vector[10, 20, 30];
       v.push_back(40);
        (v)
    }

    public fun sum_vector(nums: vector<u8>): u8 {
        let mut total: u8 = 0;
        let len = vector::length(&nums); // 获取长度
        let mut i = 0;
        while (i < len) {
            total = total + *vector::borrow(&nums, i); // 获取元素值
            i = i + 1;
        } ;
        (total)
    }

    public struct User has drop {
        first_name: string::String,
        middle_name: Option<string::String>,
        last_name: string::String,
    }

    /// Create a new `User` struct with the given fields.
    public fun register(
        first_name: string::String,
        middle_name: Option<string::String>,
        last_name: string::String,
    ): User {
        User { first_name, middle_name, last_name }
    }


}
