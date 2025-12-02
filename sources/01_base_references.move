module move_base::metro_pass{
    /// Error code for when the card is empty.
    const ENoUses: u64 = 0;
    /// Error code for when the card is not empty.
    const EHasUses: u64 = 1;

    /// Number of uses for a metro pass card.
    const USES: u8 = 3;

    /// A metro pass card
    public struct Card { uses: u8 }

    /// Purchase a metro pass card.
    public fun purchase(/* pass a Coin */): Card {
        Card { uses: USES }
    }

    /// 只读引用
    public fun is_valid(card: &Card): bool {
        card.uses > 0
    }

    /// 可变引用
    public fun enter_metro(card: &mut Card) {
        assert!(card.uses > 0, ENoUses);
        card.uses = card.uses - 1;
    }

    /// Recycle the metro pass card.
    public fun recycle(card: Card) {
        assert!(card.uses == 0, EHasUses);
        let Card { uses: _ } = card;  
        // 把 card 解构掉，让 Move 能正确销毁这个资源值，而不会报错。
    }

    #[test]
    fun test_card_2024() {
        // declaring variable as mutable because we modify it
        let mut card = purchase();

        card.enter_metro(); // modify the card but don't move it
        assert!(card.is_valid()); // read the card!

        card.enter_metro(); // modify the card but don't move it
        card.enter_metro(); // modify the card but don't move it

        card.recycle(); // move the card out of the scope
    }
}
