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
    }

}
