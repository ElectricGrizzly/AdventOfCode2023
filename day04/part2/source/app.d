import std.stdio;
import std.string;

import parsing : ScratchcardParser;
import scratchcards : Scratchcard;

void main()
{
    printHeader();

    string isTest = getRunState();
    File input = File("test-input.txt");
    if(isTest == "N" || isTest == "n")
    {
        input = File("input.txt");
    }

    runDay(input);
}

void printHeader()
{
    writeln("**** Advent of Code 2023");
    writeln("**** Day 4: Scratchcards");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    int sum = 0;
    int[int] cardInstances;
    string cardDataLine;
    while((cardDataLine = input.readln()) !is null)
    {
        Scratchcard scratchcard = ScratchcardParser.getCard(cardDataLine);
        int currentCardNumber = scratchcard.cardNumber;
        int currentCardNumberWins = scratchcard.numberOfWins;
        cardInstances[currentCardNumber]++;
        for(int instance = currentCardNumber + 1; instance <= currentCardNumber + currentCardNumberWins; instance++)
        {
            cardInstances[instance] += cardInstances[currentCardNumber];
        }
        sum += cardInstances[currentCardNumber];
    }
    writeln(sum);
}
