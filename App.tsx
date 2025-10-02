import React, { useState, useCallback } from 'react';
import { flowData } from './data/flowData';
import { outcomes } from './data/outcomes';
import type { FlowStep, Outcome } from './types';
import { DecisionNode } from './components/DecisionNode';
import { PathSummary } from './components/PathSummary';
import { GithubIcon } from './components/Icons';

const App: React.FC = () => {
  const [currentStepId, setCurrentStepId] = useState<string>('1A');
  const [history, setHistory] = useState<FlowStep[]>([]);

  const currentStep = flowData[currentStepId];
  const outcome: Outcome | undefined = currentStep?.type === 'End' && currentStep.actionResult 
    ? outcomes[currentStep.actionResult] 
    : undefined;

  const handleNextStep = useCallback((nextId: string | undefined) => {
    if (nextId && flowData[nextId]) {
      setHistory(prevHistory => [...prevHistory, currentStep]);
      setCurrentStepId(nextId);
    }
  }, [currentStep]);

  const handleBack = useCallback(() => {
    if (history.length > 0) {
      const previousStep = history[history.length - 1];
      setHistory(prevHistory => prevHistory.slice(0, -1));
      setCurrentStepId(previousStep.id);
    }
  }, [history]);

  const handleRestart = useCallback(() => {
    setCurrentStepId('1A');
    setHistory([]);
  }, []);

  return (
    <div className="bg-slate-100 min-h-screen flex flex-col items-center justify-center font-sans p-4">
      <div className="w-full max-w-2xl">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-slate-800">Decision Flow Navigator</h1>
          <p className="text-slate-600 mt-2">Navigate through 3D printing decisions with this interactive decision flow.</p>
        </header>
        
        <main className="bg-white rounded-2xl shadow-xl p-6 md:p-8 transition-all duration-300">
          <PathSummary history={history} currentStep={currentStep} />
          
          <div className="mt-6 min-h-[200px]">
            {currentStep ? (
              <DecisionNode 
                step={currentStep}
                outcome={outcome}
                onNext={handleNextStep}
                onBack={handleBack}
                onRestart={handleRestart}
                isBackDisabled={history.length === 0}
              />
            ) : (
              <div className="text-center text-red-500">
                <p>Error: Flow step not found.</p>
                <button onClick={handleRestart} className="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">Restart</button>
              </div>
            )}
          </div>


        </main>
      </div>
      <footer className="text-center mt-8 text-slate-500">
        <p>Powered by React, TypeScript, and Vite</p>
         <a href="https://github.com/willwade/medical-device-guiance-decision-flow" target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-2 mt-2 hover:text-indigo-600 transition-colors">
            <GithubIcon />
            View Source on GitHub
          </a>
      </footer>
    </div>
  );
};

export default App;
