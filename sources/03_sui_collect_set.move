module move_base::collections_vec_set{

    use sui::vec_set::{Self, VecSet};

    public struct App has drop {
        /// `VecSet` used in the struct definition
        subscribers: VecSet<address>
    }

    #[test_only]
    use std::unit_test::assert_eq;

    #[test]
    fun vec_set_playground() {
        // 用于存储一组唯一元素。它类似于vector，但不允许重复元素
        let set = vec_set::empty<u8>(); // create an empty set
        let mut set = vec_set::singleton(1); // create a set with a single item

        set.insert(2); // add an item to the set
        set.insert(3);

        assert!(set.contains(&1)); // check if an item is in the set
        assert!(set.length() == 3); // get the number of items in the set
        assert!(!set.is_empty()); // check if the set is empty

        set.remove(&2); // remove an item from the set
    }

}
