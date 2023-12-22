module parsing;

import std.conv;
import std.stdio : File;
import std.string;

import cards : Card, Hand;

struct HandParser
{
    public static Hand[] getHands(File handData)
    {
        Hand[] hands;
        string handDataLine;
        while((handDataLine = handData.readln()) !is null)
        {
            string[] handAndBid = strip(handDataLine).split();
            Card[] cards = getCards(handAndBid[0]);
            int bid = to!int(handAndBid[1]);
            hands ~= Hand(cards, bid);
        }
        return hands;
    }

    private static Card[] getCards(string expectedHandData)
    {
        Card[] cards;
        foreach(dchar character; expectedHandData)
        {
            cards ~= Card(character);
        }

        return cards;
    }
}
