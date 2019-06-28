

let someText = document.getElementById("sometext");
let hits = document.getElementById("hit");
let newGame = document.getElementById("newGame");
let stay = document.getElementById("stay");

hits.style.display = 'none';
stay.style.display = 'none';

newGame.addEventListener('click', function(){
  
  gameStarted = true;
  gameOver = false;
  playerWon = false;
  
  deck = createDeck();
  shuffleDeck(deck);
  playerCards = [getNextCard(), getNextCard()];
  dealerCards = [getNextCard(), getNextCard()];
  
  newGame.style.display = 'none';
  hits.style.display = 'inline';
  stay.style.display = 'inline';
  showStatus();
});

hits.addEventListener('click', function(){
  playerCards.push(getNextCard());
  checkForEndOfGame();
  showStatus();
});

stay.addEventListener('click', function(){
  gameOver = true;
  checkForEndOfGame();
  showStatus();
});

let gameStarted = false;
let gameOver = false;
let playerWon = false;
let playerCards = [];
let dealerCards = [];
let playerScore = 0;
let dealerScore = 0;
let deck = [];

let suits = ["Hearts", "Clubs","Diamonds","Spades"];

let values = ["Ace", "King", "Queen", "Jack",
              "Ten", "Nine", "Eight", "Seven", "Six",
              "Five", "Four", "Three", "Two"];

function createDeck(){
  let deck = [];
  for (let suitIdx=0; suitIdx < suits.length; suitIdx++){
  for (let valueIdx=0; valueIdx < values.length; valueIdx++){
        let card = {
          suit: suits[suitIdx],
          value: values[valueIdx]
        };
        deck.push(card);
    
  }
}
  return deck;
}
function shuffleDeck(deck){
  for (let i = 0; i < deck.length; i++){
    let swapIdx = Math.trunc(Math.random() * deck.length);
    let tmp = deck[swapIdx];
    deck[swapIdx] = deck[i];
    deck[i] = tmp;
  }
}

function updateScores(){
  dealerScore = getScore(dealerCards);
  playerScore = getScore(playerCards);
}

function getScore(cardArray){
  let score = 0;
  let hasAce = false;
  for( let i = 0; i < cardArray.length; i++){
    let card = cardArray[i];
    score += getCardNumericValue(card);
    if (card.value === "Ace"){
      hasAce = true;
    }
  }
    
    if (hasAce && score + 10 <= 21){
      return score + 10;
    }
    return score;
}

function checkForEndOfGame(){
  //SOON
  updateScores();
  
  if (gameOver){
    while (dealerScore < playerScore
          && dealerScore <= 21
          && playerScore <= 21){
            dealerCards.push(getNextCard());
            updateScores();
          }
  }
  
  if (playerScore > 21){
    playerWon = false;
    gameOver = true;
  }
  else if (dealerScore > 21){
    playerWon = true;
    gameOver = true;
  }
  else if (gameOver){
    if (playerScore > dealerScore){
      playerWon = true;
    }
    else{
      playerWon = false;
    }
  }
}

function getCardNumericValue(card){
  switch(card.value){
    case "Ace":
      return 1;
    case "Two":
      return 2;
    case "Three":
      return 3;
    case "Four":
      return 4;
    case "Five":
      return 5;
    case "Six":
      return 6;
    case "Seven":
      return 7;
    case "Eight":
      return 8;
    case "Nine":
      return 9;
    default:
      return 10;
      
  }
}

function getNextCard(){
  return deck.shift();
}

//let deck = createDeck();

function getCardString(card){
  return card.value + " of " + card.suit;
}

function showStatus(){
  
  if (!gameStarted){
    someText.innerText = 'Welcome to Blackjack';
  }
  
  let dealerCardString = '';
  for (let i=0; i < dealerCards.length; i++){
    dealerCardString += getCardString(dealerCards[i]) + '\n';
  }
  
  let playerCardString = '';
  for (let i=0; i < playerCards.length; i++){
    playerCardString += getCardString(playerCards[i]) + '\n';
  }
  
  updateScores();
  
  someText.innerText = 
    'Dealer has:\n' +
    dealerCardString +
    '(score: ' + dealerScore + ')\n\n' +
    
    'Player has:\n' +
    playerCardString +
    '(score: ' + playerScore + ')\n\n';
    
  
  if (gameOver){
    if (playerWon){
      someText.innerText += 'CONGRATS you Won!';
    }
    else {
      someText.innerText += 'Sorry, you lost :( Try Again!';
    }
    
    
  newGame.style.display = 'inline';
  hits.style.display = 'none';
  stay.style.display = 'none';
  }
}

/*for (let i=0; i < deck.length; i++){
  console.log(deck[i]);
}
*/ 
/*
let playerCards =[deck[0],deck[2]];


console.log("Welcome to Blackjack!");

console.log("You are dealt: ");
console.log(" " + getCardString(deck[Math.floor(Math.random() * deck.length)]));
console.log(" " + getCardString(deck[Math.floor(Math.random() * deck.length)]));
*/


/*function myFunction(){
  console.log("This is my Function!");
}

myFunction();
*/
/*
let state = 'TX';

switch (state) {
  case 'TX':
    console.log("This is Austin Texas");
    break;

}

for (let i = 0; i < 3; i++){
  console.log(i);
}
*/



