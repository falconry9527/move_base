module move_base::base_func {
    // 私有函数，只能模块内调用
    fun internal_logic(x: u8): u8 {
        x + 1
    }
    // 公共函数，可以被其他模块调用
    // 如果是只读函数，也可以被外部调用
    public fun public_logic(x: u8): u8 {
        x + 2
    }

    // 公共入口函数，可以被外部交易调用
    public fun entry_logic(x: u8): u8 {
        x + 3
    }

    public fun call_internal(x: u8): u8 {
        // 公共入口函数内部可以调用私有函数
        internal_logic(x)
    }

    public fun add(a: u64, b: u64): u64 {
       a + b
     }

    #[test] 
    fun test_add() {
        let sum = add(1, 2);
        assert!(sum == 3, 0); // 0 是自定义错误码
    }
   
    // 多个返回值
    // fun get_name_and_age(): (vector<u8>, u8) {
    //   (b"John", 25)
    // }



}
