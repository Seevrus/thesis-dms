export type OutcomeT = 'error' | 'failure' | 'success';

export interface BaseResponseT {
  outcome: OutcomeT;
  message: string;
}
