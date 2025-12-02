module move_base::collections_vector{

    public fun test_vector_2() : vector<u8>{
       let mut v = vector[10, 20, 30];
       v.push_back(40);
        (v)
    }

    public fun sum_vector_2(nums: vector<u8>): u8 {
        let mut total: u8 = 0;
        let len = vector::length(&nums); // 获取长度
        let mut i = 0;
        while (i < len) {
            total = total + *vector::borrow(&nums, i); // 获取元素值
            i = i + 1;
        } ;
        (total)
    }
}
