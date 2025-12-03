module move_base::table_demo {
    /// Imported from the `sui::table` module.
    use sui::table::{Self, Table};
    use std::string::String ;

    /// Some record type with `store`
    public struct Record has store { /* ... */ }

    /// An example of a `Table` as a struct field.
    public struct UserRegistry has key {
        id: UID,
        table: Table<address, Record>
    }

    public fun test_table(ctx: &mut TxContext) {
          // Table requires explicit type parameters for the key and value
        // ...but does it only once in initialization.
        let mut table = table::new<address, String>(ctx);

        // table has the `length` function to get the number of elements
        // assert_eq!(table.length(), 0);

        table.add(@0xa11ce, b"my_value".to_string());
        table.add(@0xb0b, b"another_value".to_string());

        // length has changed to 2
        // assert_eq!(table.length(), 2);

        // in order: `borrow`, `borrow_mut` and `remove`
        let value_ref = &table[@0xa11ce];
        let value_mut = &mut table[@0xa11ce];

        // removing both values
        let _value = table.remove(@0xa11ce);
        let _another_value = table.remove(@0xb0b);

        // length is back to 0 - we can unpack
        table.destroy_empty();
    }

}
