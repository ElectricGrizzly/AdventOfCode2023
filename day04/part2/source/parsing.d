module parsing;

import std.conv;
import std.string;

import scratchcards : Scratchcard;

struct ScratchcardParser
{
    public static Scratchcard getCard(string cardDataLine)
    {
        // Expected format is "Card x: a b c d e | f i a j c k b l m"
        string[] splitOnPipe = split(cardDataLine, "|");

        int cardNumber = getCardNumber(splitOnPipe[0]);
        int[] winningNumbers = getWinningNumbers(splitOnPipe[0]);
        int[] cardNumbers = getCardNumbers(splitOnPipe[1]);

        return Scratchcard(cardNumber, winningNumbers, cardNumbers);
    }

    private static int getCardNumber(string expectedData)
    {
        // Expected format is "Card x: a b c d e"
        return to!int(strip(split(expectedData, ":")[0].replace("Card ", "")));
    }

    private static int[] getWinningNumbers(string expectedData)
    {
        int[] winningNumbers;

        // Expected format is "Card x: a b c d e"
        string[] winningNumberStrings = split(split(expectedData, ":")[1]);
        foreach(string winningNumberString; winningNumberStrings)
        {
            winningNumbers ~= to!int(winningNumberString);
        }

        return winningNumbers;
    }

    private static int[] getCardNumbers(string expectedData)
    {
        int[] cardNumbers;

        // Expected format is "f i a j c k b l m"
        string[] cardNumberStrings = split(expectedData);
        foreach(string cardNumberString; cardNumberStrings)
        {
            cardNumbers ~= to!int(cardNumberString);
        }

        return cardNumbers;
    }
}

