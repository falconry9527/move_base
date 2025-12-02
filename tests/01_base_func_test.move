module move_base::base_func_tests {
    use move_base::base_func;

    #[test]
    fun test_internal_logic_via_call_internal() {
        // internal_logic 是私有的，不能直接调用
        let result = base_func::call_internal(10);
        assert!(result == 11, 100); // 10 + 1 = 11
    }

    #[test]
    fun test_public_logic() {
        let result = base_func::public_logic(10);
        assert!(result == 12, 101); // 10 + 2 = 12
    }

    #[test]
    fun test_entry_logic() {
        let result = base_func::entry_logic(10);
        assert!(result == 13, 102); // 10 + 3 = 13
    }
}
