module move_base::table_link_demo {
    /// Imported from the `sui::linked_table` module.
    use sui::linked_table::{Self, LinkedTable};
    use std::string::String ;

    /// Some record type with `store`
    public struct Permissions has store { /* ... */ }

    /// An example of a `LinkedTable` as a struct field.
    public struct AdminRegistry has key {
        id: UID,
        linked_table: LinkedTable<address, Permissions>
    }
    public fun test_table_link(ctx: &mut TxContext) {
        // LinkedTable requires explicit type parameters for the key and value
        // ...but does it only once in initialization.
        let mut linked_table = linked_table::new<address, String>(ctx);

        // linked_table has the `length` function to get the number of elements
        // assert_eq!(linked_table.length(), 0);

        linked_table.push_front(@0xa0a, b"first_value".to_string());
        linked_table.push_back(@0xb1b, b"second_value".to_string());
        linked_table.push_back(@0xc2c, b"third_value".to_string());

        // length has changed to 3
        // assert_eq!(linked_table.length(), 3);

        // in order: `borrow`, `borrow_mut` and `remove`
        let first_value_ref = &linked_table[@0xa0a];
        let second_value_mut = &mut linked_table[@0xb1b];

        // remove by key, from the beginning or from the end
        let _second_value = linked_table.remove(@0xb1b);
        let (_first_addr, _first_value) = linked_table.pop_front();
        let (_third_addr, _third_value) = linked_table.pop_back();

        // length is back to 0 - we can unpack
        linked_table.destroy_empty();
    }

}
