module scratchcards;

import std.algorithm.searching : canFind;

struct Scratchcard
{
    int cardNumber;
    int[] winningNumbers;
    int[] cardNumbers;
    int score = 0;

    this(int cardNumber, int[] winningNumbers, int[] cardNumbers)
    {
        this.cardNumber = cardNumber;
        this.winningNumbers = winningNumbers;
        this.cardNumbers = cardNumbers;

        getScore();
    }

    private void getScore()
    {
        foreach(int winningNumber; this.winningNumbers)
        {
            if(canFind(this.cardNumbers, winningNumber) && this.score == 0)
            {
                this.score++;
            }
            else if(canFind(this.cardNumbers, winningNumber))
            {
                this.score *= 2;
            }
        }
    }
}


