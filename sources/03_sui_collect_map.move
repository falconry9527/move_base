module move_base::collections_vec_map{

    use std::string::String;
    use sui::vec_map::{Self, VecMap};
    public struct Metadata has drop {
        name: String,
        attributes: VecMap<String, String>
    }

    #[test]
    fun vec_map_playground() {
        let mut map = vec_map::empty(); // create an empty map
        map.insert(2, b"two".to_string()); // add a key-value pair to the map
        map.insert(3, b"three".to_string());
        assert!(map.contains(&2)); // check if a key is in the map
        map.remove(&2); // remove a key-value pair from the map

        let keys = vec_map::keys(&map);
        let values = vec_map::values(&map);

        let len = vector::length(&keys);
        let mut i = 0;
        while (i < len) {
            let k = *vector::borrow(&keys, i);
            let v = *vector::borrow(&values, i);
            // 使用 k 和 v
            i = i + 1;
        }

    }

}
