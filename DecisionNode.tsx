import React from 'react';
import type { FlowStep, Outcome } from '../types';
import { FlowStepType } from '../types';
import { ArrowLeftIcon } from './Icons';

interface DecisionNodeProps {
  step: FlowStep;
  outcome?: Outcome;
  onNext: (nextId: string | undefined) => void;
  onBack: () => void;
  onRestart: () => void;
  isBackDisabled: boolean;
}

const Button: React.FC<React.ButtonHTMLAttributes<HTMLButtonElement> & { variant?: 'primary' | 'secondary' | 'ghost' }> = ({ children, className, variant = 'primary', ...props }) => {
  const baseClasses = 'px-6 py-3 rounded-lg font-semibold text-base transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2';
  
  const variantClasses = {
    primary: 'bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500 disabled:bg-indigo-300',
    secondary: 'bg-slate-200 text-slate-800 hover:bg-slate-300 focus:ring-slate-400 disabled:bg-slate-100 disabled:text-slate-400',
    ghost: 'bg-transparent text-slate-600 hover:bg-slate-100 focus:ring-slate-400 disabled:text-slate-400',
  };

  return (
    <button className={`${baseClasses} ${variantClasses[variant]} ${className}`} {...props}>
      {children}
    </button>
  );
};

export const DecisionNode: React.FC<DecisionNodeProps> = ({ step, outcome, onNext, onBack, onRestart, isBackDisabled }) => {
  return (
    <div className="flex flex-col items-center">
      
      {step.type === FlowStepType.End && outcome ? (
        <div className="text-center">
          <h2 className="text-2xl font-bold text-slate-800 mb-3">{outcome.title}</h2>
          <p className="text-lg text-slate-700 mb-8 leading-relaxed">{outcome.description}</p>
        </div>
      ) : (
        <p className="text-xl text-slate-700 mb-8 leading-relaxed text-center">{step.text}</p>
      )}
      
      <div className="flex flex-wrap justify-center gap-4 w-full">
        {step.type === FlowStepType.Question && (
          <>
            <Button onClick={() => onNext(step.yesNextId)}>Yes</Button>
            <Button variant="secondary" onClick={() => onNext(step.noNextId)}>No</Button>
          </>
        )}

        {step.type === FlowStepType.Info && (
          <Button onClick={() => onNext(step.continueId)}>Continue</Button>
        )}

        {step.type === FlowStepType.End && (
           <Button onClick={onRestart}>Start Over</Button>
        )}
      </div>

      <div className="mt-8 w-full border-t border-slate-200 pt-4 flex justify-start">
         <Button variant="ghost" onClick={onBack} disabled={isBackDisabled}>
           <span className="flex items-center gap-2">
            <ArrowLeftIcon />
            Back
           </span>
         </Button>
      </div>
    </div>
  );
};
