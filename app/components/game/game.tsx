"use client";
import { useEffect, useState } from "react";

type Question = {
  id: number;
  question: string;
  answer_one: string;
  answer_two: string;
  correct_answer: number;
};

// Core GameLoop prototype
function GameLoop() {
  const [question, setQuestion] = useState<Question | null>(null);

  useEffect(() => {
    async function loadQuestion() {
      const response = await fetch("/api/questions/random");
      const data = await response.json();

      setQuestion(data);
    }

    loadQuestion();
  }, []);

  // checks if question exists
  if (!question) {
    return <p>Loading...</p>;
  }

  async function loadQuestion() {
    const response = await fetch("/api/questions/random");
    const data = await response.json();

    setQuestion(data);
  }

  const correct = question.correct_answer;
  // check if user chose the right anwser
  function checkAnswer(chosenAnswer: number) {
    const output = document.getElementById("output");
    if (chosenAnswer === correct) {
      output!.textContent = "correct";
      loadQuestion();
    } else {
      output!.textContent = "incorrect";
      loadQuestion();
    }
  }

  return (
    <>
      <div className="flex m-10 h-[50vh]">
        <h1 id="output" className="bg-black flex-1 text-white"></h1>
        <h1 className="bg-black flex-1 text-white">{question.question}</h1>
        <button
          id="1"
          onClick={() => checkAnswer(1)}
          className="flex-1 bg-black cursor-pointer"
        >
          {question.answer_one}
        </button>
        <button
          id="2"
          onClick={() => checkAnswer(2)}
          className="flex-1 bg-black cursor-pointer"
        >
          {question.answer_two}
        </button>
      </div>
    </>
  );
}

export default GameLoop;
