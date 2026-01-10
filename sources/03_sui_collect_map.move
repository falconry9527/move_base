module move_base::collections_vec_map{

    use std::string::String;
    use sui::vec_map::{Self, VecMap};
    public struct Metadata has drop {
        name: String,
        attributes: VecMap<String, String>
    }

    #[test]
    fun vec_map_playground() {
        let mut map: VecMap<u64, String> = vec_map::empty(); // create an empty map
        map.insert(2, b"two".to_string()); // add a key-value pair to the map
        map.insert(3, b"three".to_string());
        assert!(map.contains(&2)); // check if a key is in the map
        // 遍历：VecMap 没有 values()，可以用 get_entry_by_idx 访问底层 entry
        let len = vec_map::length(&map);
        let mut i = 0;
        while (i < len) {
            let (k_ref, v_ref) = vec_map::get_entry_by_idx(&map, i);
            let _k = *k_ref;
            let _v: &String = v_ref;
            i = i + 1;
        };

        let (_k_removed, _v_removed) = map.remove(&2); // remove a key-value pair from the map

    }

}
