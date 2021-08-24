export type OutcomeT = 'failure' | 'success';

export interface BaseResponseT {
  outcome: OutcomeT;
  message: string;
}
