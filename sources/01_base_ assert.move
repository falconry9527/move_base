module move_base::base_assert {

    /// Error code for when the user has no access.
    const ENoAccess: u64 = 0;
    /// Trying to access a field that does not exist.
    const ENoField: u64 = 1;

    public fun test_assert() {
        let user_has_access = false;   
        // abort with a predefined constant if `user_has_access` is false
        if (!user_has_access) {
            abort ENoField 
        };
        assert!(user_has_access, ENoAccess);
    }
    
}