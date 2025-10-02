
import React from 'react';
import type { FlowStep } from '../types';
import { ChevronRightIcon } from './Icons';

interface PathSummaryProps {
  history: FlowStep[];
  currentStep: FlowStep;
}

export const PathSummary: React.FC<PathSummaryProps> = ({ history, currentStep }) => {
  if (history.length === 0) {
    return null; // Don't show summary if we are at the start
  }

  return (
    <div className="mb-6 pb-6 border-b border-slate-200">
      <h3 className="text-sm font-semibold text-slate-500 mb-3 uppercase tracking-wider">Your Path</h3>
      <div className="flex flex-wrap items-center gap-2 text-slate-600">
        {history.map((step) => (
          <React.Fragment key={step.id}>
            <span className="bg-slate-100 text-slate-700 px-3 py-1 rounded-md text-sm font-medium">
              {step.id}
            </span>
            <ChevronRightIcon />
          </React.Fragment>
        ))}
        <span className="bg-indigo-100 text-indigo-700 px-3 py-1 rounded-md text-sm font-bold">
          {currentStep.id}
        </span>
      </div>
    </div>
  );
};
