module cards;

enum Rank: int
{
    HIGH_CARD = 1,
    ONE_PAIR = 2,
    TWO_PAIR = 3,
    THREE_OF_A_KIND = 4,
    FULL_HOUSE = 5,
    FOUR_OF_A_KIND = 6,
    FIVE_OF_A_KIND = 7
}

struct Card
{
    int value;

    this(dchar character)
    {
        getValue(character);
    }

    private void getValue(dchar character)
    {
        switch(character)
        {
            case 'J':
                this.value = 1;
                break;
            case '2':
                this.value = 2;
                break;
            case '3':
                this.value = 3;
                break;
            case '4':
                this.value = 4;
                break;
            case '5':
                this.value = 5;
                break;
            case '6':
                this.value = 6;
                break;
            case '7':
                this.value = 7;
                break;
            case '8':
                this.value = 8;
                break;
            case '9':
                this.value = 9;
                break;
            case 'T':
                this.value = 10;
                break;
            case 'Q':
                this.value = 11;
                break;
            case 'K':
                this.value = 12;
                break;
            case 'A':
                this.value = 13;
                break;
            default:
                break;
        }
    }
}

struct Hand
{
    Card[] cards;
    int bid;
    Rank rank;
    bool hasJoker;

    this(Card[] cards, int bid)
    {
        this.cards = cards;
        this.bid = bid;
        assignRank();
    }

    private void assignRank()
    {
        int[int] cardCounts = getCardCounts();
        long length = cardCounts.keys.length;
        if(length == 1)
        {
            this.rank = Rank.FIVE_OF_A_KIND;
        }
        else if(length == 2)
        {
            if(isFullHouse(cardCounts))
            {
                this.rank = Rank.FULL_HOUSE;
            }
            else
            {
                this.rank = Rank.FOUR_OF_A_KIND;
            }
        }
        else if(length == 3)
        {
            if(isThreeOfAKind(cardCounts))
            {
                this.rank = Rank.THREE_OF_A_KIND;
            }
            else
            {
                this.rank = Rank.TWO_PAIR;
            }
        }
        else if(length == 4)
        {
            this.rank = Rank.ONE_PAIR;
        }
        else
        {
            this.rank = Rank.HIGH_CARD;
        }
    }

    private bool isFullHouse(int[int] cardCounts)
    {
        if(cardCounts.keys.length != 2)
        {
            return false;
        }

        int arbitraryCount = cardCounts.values[0];
        if(arbitraryCount == 2 || arbitraryCount == 3)
        {
            return true;
        }

        return false;
    }

    private bool isThreeOfAKind(int[int] cardCounts)
    {
        if(cardCounts.keys.length != 3)
        {
            return false;
        }

        foreach(int value; cardCounts.values)
        {
            if(value == 3)
            {
                return true;
            }
        }

        return false;
    }

    private int[int] getCardCounts()
    {
        int[int] cardCounts;
        foreach(Card card; this.cards)
        {   
            if(isJoker(card.value))
            {
                this.hasJoker = true;
            }
            cardCounts[card.value]++;
        }

       
        return this.hasJoker ? optimizeCardCountsForJokers(cardCounts) : cardCounts;
    }

    private bool isJoker(int value)
    {
        return value == 1;
    }

    private int[int] optimizeCardCountsForJokers(int[int] cardCounts)
    {
        if(cardCounts[1] > 0 && cardCounts[1] < 5)
        {
            int largestCount;
            int largestValue;
            foreach(int cardValue, int cardCount; cardCounts)
            {
                if(isJoker(cardValue))
                {
                    continue;
                }
                if(cardCount > largestCount)
                {
                    largestCount = cardCount;
                    largestValue = cardValue;
                }
                else if(cardCount == largestCount && cardValue > largestValue)
                {
                    largestValue = cardValue;
                }
            }

            cardCounts[largestValue] += cardCounts[1];
            cardCounts.remove(1);
        }

        return cardCounts;
    }

    int opCmp(ref const Hand other) const
    {
        if(this.rank > other.rank)
        {
            return 1;
        }
        else if(this.rank < other.rank)
        {
            return -1;
        }

        for(int index = 0; index < this.cards.length; index++)
        {
            if(this.cards[index].value > other.cards[index].value)
            {
                return 1;
            }
            else if(this.cards[index].value < other.cards[index].value)
            {
                return -1;
            }
        }

        return 0;
    }
}
