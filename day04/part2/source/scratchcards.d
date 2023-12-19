module scratchcards;

import std.algorithm.searching : canFind;

struct Scratchcard
{
    int cardNumber;
    int[] winningNumbers;
    int[] cardNumbers;
    int numberOfWins = 0;

    this(int cardNumber, int[] winningNumbers, int[] cardNumbers)
    {
        this.cardNumber = cardNumber;
        this.winningNumbers = winningNumbers;
        this.cardNumbers = cardNumbers;

        getNumberOfWins();
    }

    private void getNumberOfWins()
    {
        foreach(int winningNumber; this.winningNumbers)
        {
            if(canFind(this.cardNumbers, winningNumber))
            {
                this.numberOfWins++;
            }
        }
    }
}


