
export enum FlowStepType {
  Question = 'Question',
  Info = 'Info',
  End = 'End',
}

export interface FlowStep {
  id: string;
  type: FlowStepType;
  text: string;
  yesNextId?: string;
  noNextId?: string;
  continueId?: string;
  actionResult?: string;
}

export interface Outcome {
  id: string;
  title: string;
  description: string;
}
